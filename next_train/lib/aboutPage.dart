import 'package:flutter/material.dart';
import 'package:next_train/main.dart';
import 'package:next_train/translations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:next_train/launchLink.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // String _appLanguage = FeliStorageAPI().getLanguage();

  var content = '''
  
> English

# About
### Next Train
- Next Train is a redesign of 'MTR Next Train'
- Next Train provides the arrival time information for up to the next four trains of the Airport Express, Tung Chung Line, West Rail Line and Tseung Kwan O Line

### MTR Next Train
- Available on [Android](https://play.google.com/store/apps/details?id=com.mtr.nexttrain) and [iOS](https://apps.apple.com/hk/app/mtr-next-train/id531631636)

### Data
- The data contained in this application is provided by the [MTR](https://www.mtr.com.hk/) open data and is retrieved through [data.gov.hk](https://data.gov.hk/)

| |
|-|
| |

> 繁體中文

# 關於
### 下班列車
- 下班列車為 'MTR Next Train' 的重新設計
- 下班列車為提供港鐵實時列車服務資訊，包括機場快綫、東涌綫、西鐵綫及將軍澳綫最多四班即將到站列車的抵達時間。

### MTR Next Train
- 在 [Android](https://play.google.com/store/apps/details?id=com.mtr.nexttrain) 和 [iOS](https://apps.apple.com/hk/app/mtr-next-train/id531631636)

### 資訊
- 該應用程序中包含的數據由 [MTR](https://www.mtr.com.hk/) 的開放數據提供，並通過 [data.gov.hk](https://data.gov.hk/) 存取

| |
|-|
| |

> 简体中文

# 关于
### 下班列车
- 下班列车为 'MTR Next Train' 的重新设计
- 下班列车为提供港铁实时列车服务资讯，包括机场快线、东涌线、西铁线及将军澳线最多四班即将到站列车的抵达时间。

### MTR Next Train
- 在 [Android](https://play.google.com/store/apps/details?id=com.mtr.nexttrain) 和 [iOS](https://apps.apple.com/hk/app/mtr-next-train/id531631636)

### 资讯
- 该应用程序中包含的数据由 [MTR](https://www.mtr.com.hk/) 的开放数据提供，并通过 [data.gov.hk](https://data.gov.hk/) 存取

| |
|-|
| |
| |
| |

UI and Logic Built by [Felix](https://felixyeung2002.com/)

Support me by [Buying me a Coffee](https://www.buymeacoffee.com/iWuHsKU "Buy me a Coffee")

Thanks,

[Felix](https://felixyeung2002.com/)
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          icon: Image.network(
              'https://cdn.buymeacoffee.com/buttons/bmc-new-btn-logo.svg'),
          label: Text('Buy me a Coffee'),
          onPressed: () {
            FeliURLLauncher('https://www.buymeacoffee.com/felixyeungdev')
                .launchURL(context);
          }),
      appBar: AppBar(
        title: Text(Translate.get('about')),
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            constraints: BoxConstraints(maxWidth: 480),
            child: Card(
                child: Markdown(
              styleSheet: MarkdownStyleSheet(
                  tableCellsDecoration:
                      BoxDecoration(color: Colors.transparent),
                  tableBorder: TableBorder.all(color: Colors.transparent),
                  a: TextStyle(color: feliOrange),
                  blockquoteDecoration: BoxDecoration(
                      color: Colors.grey.withAlpha(64),
                      borderRadius: BorderRadius.circular(8.0))),
              styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
              data: content,
              onTapLink: (var link) {
                FeliURLLauncher(link).launchURL(context);
              },
            )),
          ),
        ),
      ),
    );
  }
}
