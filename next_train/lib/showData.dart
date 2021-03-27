import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'lines.dart' show convertLineKeyToDisplay, convertStaKeyToDisplay;
import 'db_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart' show feliOrange;
import 'translations.dart';

Future<http.Response> getTrainData(String line, String station) async {
  try {
    return await http.get(
        'https://rt.data.gov.hk/v1/transport/mtr/getSchedule.php?line=$line&sta=$station');
  } catch (e) {
    return null;
  }
  // return http
  //     .get(
  //         'https://rt.data.gov.hk/v1/transport/mtr/getSchedule.php?line=$line&sta=$station')
  //     .catchError((error) {
  //   throw error;
  // });
}

parseTrainData(String line, String station) async {
  Map data;
  await getTrainData(line, station).then((response) {
    var decodedData = json.decode(response.body);
    data = decodedData['data']['$line-$station'];
    data['status'] = decodedData['status'];
    data['message'] = decodedData['message'];
    data['isdelay'] = decodedData['isdelay'];
    data['url'] = decodedData['url'];
  }).catchError((error) {
    data = {'internet': false};
  });

  return data;
}

class ShowData extends StatefulWidget {
  final String line;
  final String station;

  ShowData(this.line, this.station);

  @override
  _ShowDataState createState() => _ShowDataState(line, station);
}

// MAIN
class _ShowDataState extends State<ShowData> {
  // bool _showFab = true;
  final String line;
  final String station;
  _ShowDataState(this.line, this.station);

  bool debug = false;

  String dummyData = '';
  String pageTitle;
  bool loading = false;
  Timer timer;
  List<Widget> info = [];
  Widget progress;
  String allData = '';
  String lastUpdated = '';
  String dataStatus = '1';
  String dataMessage = '';
  String dataUrl = '';
  String isDelayed = 'N';
  bool internetConnection = true;
  Widget favouriteButton = Container();

  updateFavButton(bool update) {
    Widget isFavedButton = IconButton(
      tooltip: 'Unlike',
      onPressed: () => updateFavButton(false),
      icon: Icon(
        Icons.favorite,
        color: Colors.red,
      ),
    );
    Widget notFavedButton = IconButton(
      tooltip: 'Like',
      onPressed: () => updateFavButton(true),
      icon: Icon(
        Icons.favorite_border,
      ),
    );

    update
        ? FeliStorageAPI().saveFavouriteStation('$line-$station')
        : FeliStorageAPI().removeFavouriteStation('$line-$station');

    setState(() {
      favouriteButton = update ? isFavedButton : notFavedButton;
    });
  }

  checkThisInFav() {
    List favedStations = FeliStorageAPI().getFavouriteStations();
    if (favedStations.contains('$line-$station')) {
      return true;
    }
    return false;
  }

  favButtonHandler() {
    updateFavButton(checkThisInFav());
  }

  @override
  void initState() {
    setState(() {
      pageTitle = convertLineKeyToDisplay(line) +
          ' - ' +
          convertStaKeyToDisplay(station, line);
      favButtonHandler();
    });
    updateProgressIndicator(false);
    updateData();
    timer = Timer.periodic(Duration(seconds: 15), (e) => updateData());
    super.initState();
  }

  void updateData() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      updateProgressIndicator(loading);
      var response = await parseTrainData(line, station);
      setState(() {
        loading = false;
      });
      updateProgressIndicator(loading);
      setState(() {
        dummyData = response.toString();
      });
      handleData(response);
    }
  }

  void handleData(response) {
    allData = response.toString();
    info = [];
    List scheduleUP = response['UP'];
    List scheduleDOWN = response['DOWN'];
    lastUpdated = response['curr_time'];
    dataStatus = response['status'].toString();
    dataUrl = response['url'] ?? '';
    dataMessage = response['message'] ?? '';
    isDelayed = response['isdelay'] ?? '';
    internetConnection = response['internet'] ?? true;
    if (scheduleUP == null) scheduleUP = [];
    if (scheduleDOWN == null) scheduleDOWN = [];
    List<List> schedules = [scheduleUP, scheduleDOWN];
    if (FeliStorageAPI().getDisplayOrderFlipped())
      schedules = List.from(schedules.reversed);

    if (!(dataStatus == '0' || dataStatus == '1')) {
      // showDialog(
      //     context: context,
      //     barrierDismissible: true,
      //     builder: (_) => AlertDialog(
      //           title: Text('Error'),
      //         ));
      return;
    }

    schedules.forEach((way) {
      List<DataRow> rows = [];
      way.forEach((train) {
        rows.add(DataRow(cells: [
          DataCell(Text(convertStaKeyToDisplay(train['dest'], line))),
          DataCell(Text(handleTime(train['time']))),
          DataCell(Text(handleTTNT(train['ttnt']))),
          DataCell(Text(train['plat'])),
        ]));
      });
      Widget table = Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: DataTable(
          columns: [
            DataColumn(
                label: Text(Translate.get('destination')), numeric: false),
            DataColumn(label: Text(Translate.get('time')), numeric: false),
            DataColumn(
                label: Text(Translate.get('next_train')), numeric: false),
            DataColumn(label: Text(Translate.get('platform')), numeric: false),
          ],
          rows: rows,
        ),
      );
      if (rows.length > 0)
        info.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: table,
            ),
          ),
        ));
      if (info.length >= 1) info.add(SizedBox(height: 16));
    });
    setState(() {
      info = info;
    });
  }

  String handleTTNT(ttnt) {
    if (ttnt == '0') return Translate.get('departing');
    if (ttnt == '1') return Translate.get('arriving');
    return (ttnt + Translate.get('mins'));
  }

  String handleTime(time) {
    return time.substring(11, 16);
  }

  void updateProgressIndicator(loading) {
    setState(() {
      if (loading)
        progress = LinearProgressIndicator(
          backgroundColor: Colors.transparent,
        );
      else
        // progress = LinearProgressIndicator(value: 0);
        progress = SizedBox(height: 6);
    });
  }

  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$pageTitle'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: Translate.get('back'),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            progress,
            SizedBox(
              height: 8,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 480.0 + 20),
              child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(children: <Widget>[
                      Center(
                        child: Text(lastUpdated != '-'
                            ? (loading
                                ? Translate.get('loading')
                                : Translate.get('updated_at') + ' $lastUpdated')
                            : Translate.get('no_data')),
                      ),
                      internetConnection
                          ? Container()
                          : Center(
                              child: Text(Translate.get('no_internet')),
                            ),
                      isDelayed == 'Y'
                          ? Center(
                              child: Text(Translate.get('train_delayed')),
                            )
                          : Container(),
                      dataStatus == '0'
                          ? Center(
                              child: Column(
                                children: <Widget>[
                                  Text('$dataMessage'),
                                  GestureDetector(
                                    child: Text('$dataUrl',
                                        style: TextStyle(color: feliOrange)),
                                    onTap: () => launch(dataUrl),
                                  )
                                ],
                              ),
                            )
                          : Container()
                    ]),
                  )),
            ),
            SizedBox(height: 8),
            Column(
              children: info,
            ),
            debug
                ? Column(
                    children: <Widget>[
                      Text('Status $dataStatus'),
                      Text('Data $allData'),
                    ],
                  )
                : Container()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: !loading
          ? FloatingActionButton(
              onPressed: updateData,
              child: Icon(Icons.refresh),
              tooltip: Translate.get('refresh'),
            )
          // FloatingActionButton.extended(
          //     label: Text(Translate.get('refresh')),
          //     tooltip: Translate.get('refresh'),
          //     icon: Icon(Icons.refresh),
          //     onPressed: () => updateData(),
          //   )
          : null,
      bottomNavigationBar: BottomAppBar(
        elevation: FeliStorageAPI().getPreferredThemeElevation(),

        // shape: CircularNotchedRectangle(),
        child: Container(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 4.0),
              favouriteButton,
              SizedBox(width: 4.0),
            ],
          ),
        ),
      ),
    );
  }
}
