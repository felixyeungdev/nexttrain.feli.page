import 'package:next_train/db_api.dart';

class Translate {
  static Map<String, Map<String, String>> translate = {
    'next_train': {
      'en': 'Next Train',
      'tc': '下班列車',
      'sc': '下班列车',
    },
    'search_by_line': {
      'en': 'Search By Line',
      'tc': '以線搜索',
      'sc': '以线搜索',
    },
    'favourites': {
      'en': 'Favourites',
      'tc': '收藏夾',
      'sc': '收藏夹',
    },
    'near_me': {
      'en': 'Near Me',
      'tc': '在我附近',
      'sc': '在我附近',
    },
    'access_location_denied': {
      'en': 'Unable to Access Device Location',
      'tc': '無法訪問設備位置',
      'sc': '无法访问设备位置',
    },
    'access_location_denied_sub': {
      'en': 'A Random Location is Used',
      'tc': '使用隨機位置',
      'sc': '使用随机位置',
    },
    'km': {
      'en': 'km',
      'tc': '公里',
      'sc': '公里',
    },
    'no_favourites': {
      'en': "You don't have any stations favourited..",
      'tc': '你沒有收藏任何車站...',
      'sc': '你没有收藏任何车站...',
    },
    'color_scheme': {
      'en': 'Appearance',
      'tc': '外表',
      'sc': '外表',
    },
    'elevation': {
      'en': 'Elevation',
      'tc': '提高',
      'sc': '提高',
    },
    'language': {
      'en': 'Language',
      'tc': '語言',
      'sc': '语言',
    },
    'automatic': {
      'en': 'Automatic',
      'tc': '自動',
      'sc': '自动',
    },
    'light': {
      'en': 'Light',
      'tc': '光',
      'sc': '光',
    },
    'dark': {
      'en': 'Dark',
      'tc': '暗',
      'sc': '暗',
    },
    'black': {
      'en': 'Black',
      'tc': '黑',
      'sc': '黑',
    },
    'settings': {
      'en': 'Settings',
      'tc': '設定',
      'sc': '设定',
    },
    'about': {
      'en': 'About',
      'tc': '關於',
      'sc': '关于',
    },
    'error_occured': {
      'en': 'An Error Occurred',
      'tc': '發生錯誤',
      'sc': '发生错误',
    },
    'previous_page': {
      'en': 'Previous Page',
      'tc': '上一頁',
      'sc': '上一页',
    },
    'next_page': {
      'en': 'Next Page',
      'tc': '下一頁',
      'sc': '下一页',
    },
    'loading': {
      'en': 'Loading...',
      'tc': '載入中...',
      'sc': '載入中...',
    },
    'updated_at': {
      'en': 'Last Updated At',
      'tc': '上次更新時間',
      'sc': '上次更新时间',
    },
    'close_navigation_drawer': {
      'en': 'Open Navigation Drawer',
      'tc': '關閉導航抽屜',
      'sc': '关闭导航抽屉',
    },
    'open_navigation_drawer': {
      'en': 'Close Navigation Drawer',
      'tc': '打開導航抽屜',
      'sc': '打开导航抽屉',
    },
    'back': {
      'en': 'Back',
      'tc': '返回',
      'sc': '返回',
    },
    'show_menu': {
      'en': 'Show Menu',
      'tc': '顯示菜單',
      'sc': '显示菜单',
    },
    'refresh': {
      'en': 'Refresh',
      'tc': '刷新',
      'sc': '刷新',
    },
    'destination': {
      'en': 'Destination',
      'tc': '目的地',
      'sc': '目的地',
    },
    'time': {
      'en': 'Time',
      'tc': '時間',
      'sc': '时间',
    },
    'platform': {
      'en': 'Platform',
      'tc': '平台',
      'sc': '平台',
    },
    'departing': {
      'en': 'Departing',
      'tc': '出發中',
      'sc': '出发中',
    },
    'arriving': {
      'en': 'Arriving',
      'tc': '即將到達',
      'sc': '即将到达',
    },
    'delete_item': {
      'en': 'Delete Item',
      'tc': '刪除項目',
      'sc': '删除项目',
    },
    'confirm': {
      'en': 'OK',
      'tc': '確認',
      'sc': '确认',
    },
    'cancel': {
      'en': 'CANCEL',
      'tc': '取消',
      'sc': '取消',
    },
    'feature_not_supported': {
      'en': 'This feature is not supported on your device..',
      'tc': '您的設備不支持此功能..',
      'sc': '您的设备不支持此功能..',
    },
    'mins': {
      'en': ' mins',
      'tc': ' 分鐘',
      'sc': ' 分钟',
    },
    'no_internet': {
      'en': 'No Internet Connection...',
      'tc': '沒有網絡連接...',
      'sc': '没有网络连接...',
    },
    'train_delayed': {
      'en': 'No Internet Connection...',
      'tc': '火車服務延遲',
      'sc': '火车服务延迟',
    },
    'no_data': {
      'en': 'Data Not Available',
      'tc': '沒有資訊',
      'sc': '没有资讯',
    },
    'link_leave_app_title': {
      'en': 'Are you sure you want to leave Next Train?',
      'tc': '您確定離開下班列車嗎?',
      'sc': '您确定离开下班列车吗',
    },
    'link_leave_app_desc': {
      'en': 'This link is taking you to a site outside of NextTrain',
      'tc': '此鏈接將您帶到下班列車以外的網站',
      'sc': '此链接将您带到下班列车以外的网站',
    },
    'link_leave_app_confirm': {
      'en': 'GO TO SITE',
      'tc': '到鏈接去',
      'sc': '到链接去',
    },
    'link_leave_app_cancel': {
      'en': 'BACK',
      'tc': '返回',
      'sc': '返回',
    },
    'reverse_display_order': {
      'en': 'Reverse Display Order',
      'tc': '反向顯示順序',
      'sc': '反向显示顺序',
    },
  };

  static String get(String name) {
    String appLanguage = FeliStorageAPI().getLanguage();
    try {
      return translate[name][appLanguage];
    } catch (e) {
      return '.,;,,;,.';
    }
  }
}
