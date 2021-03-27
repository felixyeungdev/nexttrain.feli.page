import 'package:flutter/material.dart';
import 'package:next_train/db_api.dart';
import 'hexColor.dart' show HexColor;

Map<String, Map<String, String>> lineStationDictionary = {
  "AEL": {
    "en": "Airport Express",
    "tc": "機場快線",
    "sc": "机场快线",
  },
  "TCL": {
    "en": "Tung Chung Line",
    "tc": "東涌線",
    "sc": "东涌线",
  },
  "WRL": {
    "en": "West Rail Line",
    "tc": "西鐵線",
    "sc": "西铁线",
  },
  "TKL": {
    "en": "Tseung Kwan O Line",
    "tc": "將軍澳線",
    "sc": "将军澳线",
  },
  "HOK": {
    "en": "Hong Kong",
    "tc": "香港",
    "sc": "香港",
  },
  "KOW": {
    "en": "Kowloon",
    "tc": "九龍",
    "sc": "九龙",
  },
  "TSY": {
    "en": "Tsing Yi",
    "tc": "青衣",
    "sc": "青衣",
  },
  "AIR": {
    "en": "Airport",
    "tc": "機場",
    "sc": "机场",
  },
  "AWE": {
    "en": "AsiaWorld Expo",
    "tc": "博覽館",
    "sc": "博览馆",
  },
  "OLY": {
    "en": "Olympic",
    "tc": "奧運",
    "sc": "奥运",
  },
  "NAC": {
    "en": "Nam Cheong",
    "tc": "南昌",
    "sc": "南昌",
  },
  "LAK": {
    "en": "Lai King",
    "tc": "荔景",
    "sc": "荔景",
  },
  "SUN": {
    "en": "Sunny Bay",
    "tc": "欣澳",
    "sc": "欣澳",
  },
  "TUC": {
    "en": "Tung Chung",
    "tc": "東涌",
    "sc": "东涌",
  },
  "HUH": {
    "en": "Hung Hom",
    "tc": "紅磡",
    "sc": "红磡",
  },
  "ETS": {
    "en": "East Tsim Sha Tsui",
    "tc": "尖東",
    "sc": "尖东",
  },
  "AUS": {
    "en": "Austin",
    "tc": "柯士甸",
    "sc": "柯士甸",
  },
  "MEF": {
    "en": "Mei Foo",
    "tc": "美孚",
    "sc": "美孚",
  },
  "TWW": {
    "en": "Tsuen Wan West",
    "tc": "荃灣西",
    "sc": "荃湾西",
  },
  "KSR": {
    "en": "Kam Sheung Road",
    "tc": "錦上路",
    "sc": "锦上路",
  },
  "YUL": {
    "en": "Yuen Long",
    "tc": "元朗",
    "sc": "元朗",
  },
  "LOP": {
    "en": "Long Ping",
    "tc": "朗屏",
    "sc": "朗屏",
  },
  "TIS": {
    "en": "Tin Shui Wai",
    "tc": "天水圍",
    "sc": "天水围",
  },
  "SIH": {
    "en": "Siu Hong",
    "tc": "兆康",
    "sc": "兆康",
  },
  "TUM": {
    "en": "Tuen Mun",
    "tc": "屯門",
    "sc": "屯门",
  },
  "NOP": {
    "en": "North Point",
    "tc": "北角",
    "sc": "北角",
  },
  "QUB": {
    "en": "Quarry Bay",
    "tc": "鰂魚涌",
    "sc": "鲗鱼涌",
  },
  "YAT": {
    "en": "Yau Tong",
    "tc": "油塘",
    "sc": "油塘",
  },
  "TIK": {
    "en": "Tiu Keng Leng",
    "tc": "調景嶺",
    "sc": "调景岭",
  },
  "TKO": {
    "en": "Tseung Kwan O",
    "tc": "將軍澳",
    "sc": "将军澳",
  },
  "LHP": {
    "en": "LOHAS Park",
    "tc": "康城",
    "sc": "康城",
  },
  "HAH": {
    "en": "Hang Hau",
    "tc": "坑口",
    "sc": "坑口",
  },
  "POA": {
    "en": "Po Lam",
    "tc": "寶琳",
    "sc": "宝琳",
  },
};

class Station {
  final String sta;
  final String name;
  final List<double> coordinates;
  Station(this.sta, this.name, [this.coordinates]);
  String get displayName {
    try {
      String result =
          lineStationDictionary[sta][FeliStorageAPI().getLanguage()] ?? '';
      return result == '' ? name : result;
    } catch (e) {
      print(e);
      return name;
    }
  }

  List get coords => coordinates;
}

class Line {
  final List<Station> stations;
  final String name;
  final String line;
  // final String color;
  final Color color;

  Line(this.line, this.name, this.color, this.stations);

  String get displayName {
    try {
      String result =
          lineStationDictionary[line][FeliStorageAPI().getLanguage()] ?? '';
      return result == '' ? name : result;
    } catch (e) {
      print(e);
      return name;
    }
  }
}

String appLanguage = FeliStorageAPI().getLanguage();
List<Line> lines = [
  Line('WRL', 'West Rail Line', HexColor('#A2228E'), [
    Station('HUH', 'Hung Hom', [22.303330, 114.181630]),
    Station('ETS', 'East Tsim Sha Tsui', [22.295314, 114.174571]),
    Station('AUS', 'Austin', [22.305305, 114.166111]),
    Station('NAC', 'Nam Cheong', [22.326812, 114.153683]),
    Station('MEF', 'Mei Foo', [22.337621, 114.137996]),
    Station('TWW', 'Tsuen Wan West', [22.368469, 114.109657]),
    Station('KSR', 'Kam Sheung Road', [22.434895, 114.063525]),
    Station('YUL', 'Yuen Long', [22.446127, 114.034770]),
    Station('LOP', 'Long Ping', [22.447654, 114.025479]),
    Station('TIS', 'Tin Shui Wai', [22.448200, 114.004762]),
    Station('SIH', 'Siu Hong', [22.411724, 113.979012]),
    Station('TUM', 'Tuen Mun', [22.394912, 113.973128]),
  ]),
  Line('TCL', 'Tung Chung Line', HexColor('#F7943D'), [
    Station('HOK', 'Hong Kong', [22.284679, 114.158179]),
    Station('KOW', 'Kowloon', [22.304294, 114.161469]),
    Station('OLY', 'Olympic', [22.317812, 114.160221]),
    Station('NAC', 'Nam Cheong', [22.326812, 114.153683]),
    Station('LAK', 'Lai King', [22.348438, 114.126169]),
    Station('TSY', 'Tsing Yi', [22.358541, 114.107665]),
    Station('SUN', 'Sunny Bay', [22.331681, 114.029044]),
    Station('TUC', 'Tung Chung', [22.289261, 113.941457]),
  ]),
  Line('TKL', 'Tseung Kwan O Line', HexColor('#7D489C'), [
    Station('NOP', 'North Point', [22.291268, 114.200496]),
    Station('QUB', 'Quarry Bay', [22.287883, 114.209753]),
    Station('YAT', 'Yau Tong', [22.297926, 114.237015]),
    Station('TIK', 'Tiu Keng Leng', [22.304265, 114.252677]),
    Station('TKO', 'Tseung Kwan O', [22.307425, 114.259893]),
    Station('LHP', 'LOHAS Park', [22.296339, 114.269612]),
    Station('HAH', 'Hang Hau', [22.315568, 114.264403]),
    Station('POA', 'Po Lam', [22.322535, 114.257832]),
  ]),
  Line('AEL', 'Airport Express', HexColor('#008889'), [
    Station('HOK', 'Hong Kong', [22.284679, 114.158179]),
    Station('KOW', 'Kowloon', [22.304294, 114.161469]),
    Station('TSY', 'Tsing Yi', [22.358492, 114.107660]),
    Station('AIR', 'Airport', [22.316010, 113.936549]),
    Station('AWE', 'AsiaWorld Expo', [22.320867, 113.941861])
  ]),
];

String convertStaKeyToDisplay(sta, line) {
  for (var l in lines) {
    if (l.line == line) {
      for (var s in l.stations) {
        if (s.sta == sta) return s.displayName;
      }
      break;
    }
  }
  return sta;
}

String convertLineKeyToDisplay(ln) {
  for (var l in lines) {
    if (l.line == ln) return l.displayName;
  }
  return ln;
}

Color convertLineKeyToColor(ln) {
  for (var l in lines) {
    if (l.line == ln) return l.color;
  }
  return null;
}
