import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/models/vpn_configuration.dart';
import 'package:vpn_app/models/vpn_info.dart';
import 'package:vpn_app/settings/app_preferences.dart';
import 'package:vpn_app/vpn_engine/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<VpnInfo> vpnInfo = AppPreferences.vpnInfo.obs;

  final vpnConnectionState = VpnEngine.vpnDisconnectedNow.obs;

  Future<void> connectToVpnNow() async {
    if (vpnInfo.value.base64OpenVPNConfigurationsData.isEmpty) {
      Get.snackbar('Country / Location', 'Please select country / location first');
      return;
    }
    // Disconnected
    if (vpnConnectionState.value == VpnEngine.vpnDisconnectedNow) {
      final dataConfigVpn =
          const Base64Decoder().convert(vpnInfo.value.base64OpenVPNConfigurationsData);
      final configuration = const Utf8Decoder().convert(dataConfigVpn);
      final vpnConfiguration = VpnConfiguration(
        username: 'vpn',
        password: 'vpn',
        countryName: vpnInfo.value.countryLongName,
        config: configuration,
      );
      await VpnEngine.startVpnNow(vpnConfiguration);
    } else {
      await VpnEngine.stopVpnNow();
    }
  }

  Color get getRoundVpnButtonColor {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return Colors.redAccent;
      case VpnEngine.vpnConnectedNow:
        return Colors.green;
      default:
        return Colors.orangeAccent;
    }
  }

  String get getRoundVpnButtonText {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return 'Tap to Connect';
      case VpnEngine.vpnConnectedNow:
        return 'Tap to Disconnect';
      default:
        return 'Connecting ...';
    }
  }
}
