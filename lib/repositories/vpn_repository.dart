import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/models/vpn_info.dart';
import 'package:http/http.dart' as http;
import 'package:vpn_app/settings/app_preferences.dart';

import '../models/ip_info.dart';

class VpnRepository {
  static Future<List<VpnInfo>> getAvailableVpnServers() async {
    final List<VpnInfo> vpnServerList = [];

    try {
      final response = await http.get(
        Uri.parse('http://www.vpngate.net/api/iphone/'),
      );

      final commaSeparatedValuesString = response.body.split('#')[1].replaceAll('*', '');

      List<List<dynamic>> listData = const CsvToListConverter().convert(commaSeparatedValuesString);
      final header = listData[0];
      for (int counter = 1; counter < listData.length - 1; counter++) {
        Map<String, dynamic> jsonData = {};

        for (int innerCounter = 0; innerCounter < header.length; innerCounter++) {
          jsonData.addAll(
            {header[innerCounter].toString(): listData[counter][innerCounter]},
          );
        }
        vpnServerList.add(VpnInfo.fromMap(jsonData));
      }
    } on Exception catch (e) {
      Get.snackbar(
        'Error Occurred',
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
      );
    }
    vpnServerList.shuffle();
    if (vpnServerList.isNotEmpty) AppPreferences.vpnList = vpnServerList;
    return vpnServerList;
  }

  static Future<void> retrieveIPDetails({required Rx<IpInfo> ipInformation}) async {
    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json/'));

      ipInformation.value = IpInfo.fromJson(response.body);
    } on Exception catch (e) {
      Get.snackbar(
        'Error Occurred',
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
      );
    }
  }
}
