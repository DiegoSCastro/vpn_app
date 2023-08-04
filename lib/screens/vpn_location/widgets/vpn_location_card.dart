import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/main.dart';
import 'package:vpn_app/models/vpn_info.dart';
import 'package:vpn_app/screens/home/home_controller.dart';
import 'package:vpn_app/settings/app_preferences.dart';
import 'package:vpn_app/vpn_engine/vpn_engine.dart';

class VpnLocationCard extends StatelessWidget {
  final VpnInfo vpnInfo;
  const VpnLocationCard({super.key, required this.vpnInfo});

  String formatSpeedBytes(int speedBytes) {
    if (speedBytes <= 0) {
      return '0 B';
    }
    const suffixesTitle = ['B/s', 'Kb/s', 'Mb/s', 'Gb/s', 'Tb/s'];
    var speedIndex = (log(speedBytes) / log(1024)).floor();
    return '${(speedBytes / pow(1024, speedIndex)).toStringAsFixed(2)} '
        '${suffixesTitle[speedIndex]}';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final homeController = Get.find<HomeController>();
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          homeController.vpnInfo.value = vpnInfo;
          AppPreferences.vpnInfo = vpnInfo;
          Get.back();
          if (homeController.vpnConnectionState.value == VpnEngine.vpnConnectedNow) {
            VpnEngine.stopVpnNow();
            Future.delayed(const Duration(seconds: 3), () => homeController.connectToVpnNow());
            return;
          } else {
            homeController.connectToVpnNow();
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          leading: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Image.asset(
              'assets/flags/${vpnInfo.countryShortName.toLowerCase()}.png',
              height: 40,
              width: size.width * 0.15,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(vpnInfo.countryLongName),
          subtitle: Row(
            children: [
              const Icon(
                Icons.shutter_speed,
                color: Colors.redAccent,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                formatSpeedBytes(vpnInfo.speed),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpnInfo.vpnSessionsNum.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).lightTextColor,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                CupertinoIcons.person_2_alt,
                color: Colors.redAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
