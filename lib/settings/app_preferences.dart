import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

import '../models/vpn_info.dart';

class AppPreferences {
  static late Box boxData;

  static Future<void> initHive() async {
    await Hive.initFlutter();
    boxData = await Hive.openBox('data');
  }

  // saving user choice about theme selection
  static bool get isDarkMode => boxData.get('isDarkMode') ?? false;
  static set isDarkMode(bool value) => boxData.put('isDarkMode', value);

  // for saving single selected vpn details
  static VpnInfo get vpnInfo => VpnInfo.fromMap(jsonDecode(boxData.get('vpn') ?? '{}'));
  static set vpnInfo(VpnInfo value) => boxData.put('vpn', jsonEncode(value));

  // for saving all selected vpn details
  // static List<VpnInfo> get vpnList {
  //   List<VpnInfo> tempVpnList = [];
  //   final dataVpn = jsonDecode(boxData.get('vpnList') ?? '[]');
  //   for (var data in dataVpn) {
  //     tempVpnList.add(VpnInfo.fromMap(jsonDecode(data)));
  //   }
  //
  //   return tempVpnList;
  // }

  static List<VpnInfo> get vpnList {
    final tempVpnList = jsonDecode(boxData.get('vpnList') ?? '[]');
    return List<VpnInfo>.from(tempVpnList.map((data) => VpnInfo.fromMap(jsonDecode(data))));
  }

  static set vpnList(List<VpnInfo> value) => boxData.put('vpnList', jsonEncode(value));
}
