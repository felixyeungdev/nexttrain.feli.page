import 'package:flutter/material.dart';
import 'package:next_train/translations.dart';
import 'package:url_launcher/url_launcher.dart';

class FeliURLLauncher {
  final url;
  FeliURLLauncher(this.url);
  void launchURL(BuildContext context) async {
    if (await canLaunch(url)) {
      var shouldLaunch = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(Translate.get('link_leave_app_title')),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(Translate.get('link_leave_app_desc')),
                SizedBox(height: 8.0),
                ListTile(
                  leading: Icon(Icons.link),
                  title: Text(url),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(Translate.get('link_leave_app_cancel'))),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(Translate.get('link_leave_app_confirm')),
              ),
            ],
          );
        },
      );
      if (shouldLaunch == true) await launch(url);
    } else {
      print('Unable to launch $url');
    }
  }
}
