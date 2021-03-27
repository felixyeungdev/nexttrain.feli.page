import 'package:flutter/material.dart';
import 'package:next_train/translations.dart';
import 'cardShape.dart';
import 'feliLocation.dart';
import 'showData.dart';
import 'lines.dart'
    show
        Line,
        Station,
        convertLineKeyToColor,
        convertLineKeyToDisplay,
        convertStaKeyToDisplay,
        lines;
import 'db_api.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;
  String appLanguage = FeliStorageAPI().getLanguage();
  final _pageController = PageController(initialPage: 0, keepPage: false);
  // Locale locale = Localizations.;

  List<Widget> appHomeBodies = [
    Container(),
    Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          constraints: BoxConstraints(maxWidth: 480),
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.access_time),
                title: Text(Translate.get('loading')),
              ),
            ),
          ),
        ),
      ),
    ),
    Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          constraints: BoxConstraints(maxWidth: 480),
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.sentiment_dissatisfied),
                title: Text(Translate.get('feature_not_supported')),
              ),
            ),
          ),
        ),
      ),
    )
  ];

  @override
  void initState() {
    // showSelection();
    // showNearMe();
    // showFavourite();
    updatePageHandler();
    super.initState();
  }

  void showSelection() async {
    print('Search By Line Updated');
    // var location = await FeliLocation().location();

    // for (var line in lines) {
    //   print(line.line + ' ' + line.displayName);
    //   for (var station in line.stations) {
    //     print(station.sta + ' ' + station.displayName);
    //     print(station.coords);
    //   }
    // }

    appHomeBodies[0] = Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 480),
        child: ListView.builder(
          itemCount: lines.length,
          itemBuilder: (content, i) {
            return Container(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: lines.length - 1 == i ? 16 : 0),
                child: Card(
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            color: lines[i].color,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        width: 24,
                        height: 24,
                      ),
                      title: Text(lines[i].displayName),
                      children:
                          _buildStationPicker(i, lines[i].line, lines[i].color),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
    setState(() {
      appHomeBodies[0] = appHomeBodies[0];
    });
  }

  void showNearMe() async {
    print('Near Me Updated');

    var location = await FeliLocation().location();
    bool locationDisabled = location[0] == 360 && location[1] == 360;
    print('Location Enabled: ${!locationDisabled}');
    List<Widget> nearMe = [];
    if (locationDisabled)
      nearMe.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Card(
          child: ListTile(
            leading: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Icon(
                Icons.location_off,
              ),
            ),
            title: Text(Translate.get('access_location_denied')),
            subtitle: Text(Translate.get('access_location_denied_sub')),
          ),
        ),
      ));
    List<List> sorter = [];
    for (var line in lines) {
      for (var station in line.stations) {
        var distance =
            FeliLocation.distanceBetweenTwoPoints(location, station.coords);
        sorter.add([distance, line, station]);
      }
    }
    // return;
    var multiplier = 100000;

    sorter.sort((a, b) => (a[0] * multiplier).compareTo((b[0]) * multiplier));
    for (var i = 0; i < sorter.length; i++) {
      var element = sorter[i];
      // }
      // for (var key in sortedSorterKeys) {
      double distance = element[0];
      Line line = element[1];
      Station station = element[2];
      nearMe.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Card(
          child: ListTile(
            onTap: () => _showLineData(line.line, station.sta),
            leading: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Icon(
                Icons.location_on,
                color: convertLineKeyToColor(line.line),
              ),
            ),
            title: Text(convertStaKeyToDisplay(station.sta, line.line)),
            subtitle: Text(convertLineKeyToDisplay(line.line)),
            trailing:
                Text('${distance.toStringAsFixed(2)} ${Translate.get('km')}'),
          ),
        ),
      ));
    }

    appHomeBodies[1] = Center(
      child: Container(
          constraints: BoxConstraints(maxWidth: 480),
          padding: EdgeInsets.only(top: 0),
          child: ListView(
            key: UniqueKey(),
            children: nearMe,
          )),
    );
    setState(() {
      appHomeBodies[1] = appHomeBodies[1];
    });
  }

  void showFavourite() {
    print('Favourites Updated');

    List favourites = FeliStorageAPI().getFavouriteStations();
    if (favourites == null) favourites = [];
    // print('Retrieved $favourites');
    // print(favourites.length);
    // print(favourites.length != 0);
    if (favourites.length != 0) {
      // List<Widget> favWidgets = [];
      List<Widget> favouritesWidgets = [];
      for (var i = 0; i < favourites.length; i++) {
        String fav = favourites[i];
        List favArray = (fav.split('-'));
        String favLn = favArray[0];
        String favSta = favArray[1];
        String favLnDisplay = convertLineKeyToDisplay(favLn);
        String favStaDisplay = convertStaKeyToDisplay(favSta, favLn);

        favouritesWidgets.add(Dismissible(
          direction: DismissDirection.endToStart,
          confirmDismiss: (DismissDirection direction) async {
            final bool res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(Translate.get('delete_item')),
                  content: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('$favStaDisplay'),
                    subtitle: Text('$favLnDisplay'),
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(Translate.get('cancel'))),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(Translate.get('confirm')),
                    ),
                  ],
                );
              },
            );
            return res;
          },
          onDismissed: (direction) {
            setState(() {
              favourites.removeAt(i);
            });
            FeliStorageAPI().removeFavouriteStation(fav);
            showFavourite();
          },
          background: Container(
            color: Colors.red,
          ),
          key: UniqueKey(),
          // key: ValueKey(fav),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Card(
              child: ListTile(
                leading: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(
                    Icons.favorite,
                    color: convertLineKeyToColor(favLn),
                  ),
                ),
                onTap: () => _showLineData(favLn, favSta),
                title: Text('$favStaDisplay'),
                subtitle: Text('$favLnDisplay'),
                // dense: true,
              ),
            ),
          ),
        ));
      }
      // favouritesWidgets.add(
      //   Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Card(
      //       child: ListTile(
      //         leading: Icon(Icons.delete),
      //         title: Text('Tip'),
      //         subtitle: Text('Swipe From the Right to Left to Remove'),
      //       ),
      //     ),
      //   ),
      // );
      appHomeBodies[2] = Center(
        child: Container(
            constraints: BoxConstraints(maxWidth: 480),
            padding: EdgeInsets.only(top: 0),
            child: ListView(
              key: UniqueKey(),
              children: favouritesWidgets,
            )),
      );
    } else {
      appHomeBodies[2] = Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            constraints: BoxConstraints(maxWidth: 480),
            child: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(Icons.sentiment_neutral),
                  title: Text(Translate.get('no_favourites')),
                ),
              ),
            ),
          ),
        ),
      );
    }
    setState(() {
      appHomeBodies[2] = appHomeBodies[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.get('next_train')),
        leading: Icon(Icons.train),
        actions: <Widget>[
          PopupMenuButton(
            elevation: 0,
            tooltip: Translate.get('show_menu'),
            onSelected: (result) async {
              switch (result) {
                case 'settings_page':
                  await Navigator.pushNamed(context, '/settings/');
                  updatePageHandler();
                  break;
                case 'about_page':
                  await Navigator.pushNamed(context, '/about/');
                  updatePageHandler();
                  break;
                default:
                  {}
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'settings_page',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(Translate.get('settings')),
                ),
              ),
              PopupMenuItem(
                value: 'about_page',
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text(Translate.get('about')),
                ),
              ),
            ],
          ),
          // IconButton(
          //     tooltip: Translate.get('settings'),
          //     icon: Icon(Icons.settings),
          //     onPressed: () {
          //       Navigator.pushNamed(context, '/settings');
          //     })
        ],
      ),
      body: PageView(
        onPageChanged: _onPageChange,
        controller: _pageController,
        children: [
          appHomeBodies[0],
          appHomeBodies[2],
          appHomeBodies[1],
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.black),
        child: BottomNavigationBar(
          elevation: FeliStorageAPI().getPreferredThemeElevation(),
          backgroundColor: Theme.of(context).bottomAppBarColor,
          showUnselectedLabels: false,
          onTap: _onNavItemTapped,
          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.train),
                title: Text(Translate.get('search_by_line'))),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                title: Text(Translate.get('favourites'))),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                title: Text(Translate.get('near_me'))),
          ],
        ),
      ),
    );
  }

  void _onNavItemTapped(int index) {
    if (_selectedIndex == 1)
    showNearMe();
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    // setState(() {
    //   _selectedIndex = index;
    // });
  }

  void _onPageChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
    updatePageHandler();
  }

  _buildStationPicker(i, line, Color color) {
    List<Widget> stationSelector = [];
    for (var j = 0; j < lines[i].stations.length; j++) {
      // bool firstLast = j == 0 || j == lines[i].stations.length - 1;
      bool first = j == 0;
      bool last = j == lines[i].stations.length - 1;

      var station = lines[i].stations[j];
      stationSelector.add(ListTile(
        title: Text(station.displayName),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: first ? 18 : (last ? 38 : 28),
                    width: 16,
                    decoration: BoxDecoration(
                      color: !first ? color : null,
                      borderRadius: last
                          ? BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8))
                          : null,
                    ),
                  ),
                  Container(
                    height: first ? 38 : (last ? 18 : 28),
                    width: 16,
                    decoration: BoxDecoration(
                      color: !last ? color : null,
                      borderRadius: first
                          ? BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))
                          : null,
                    ),
                  ),
                ],
              ),
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        onTap: () => _showLineData(line, station.sta),
      ));
    }
    return stationSelector;
  }

  void _showLineData(ln, sta) async {
    // await Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => ShowData(ln, sta)));
    await Navigator.pushNamed(context, '/showData/?line=$ln&station=$sta');
    updatePageHandler();
  }

  void updatePageHandler() {
    print(_selectedIndex);
    switch (_selectedIndex) {
      case 0:
        showSelection();
        break;
      case 2:
        showNearMe();
        break;
      case 1:
        showFavourite();
        break;
      default:
    }
  }
}
