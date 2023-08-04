import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/screens/vpn_location/vpn_location_controller.dart';

import 'widgets/loading_widget.dart';
import 'widgets/no_vpn_found_widget.dart';
import 'widgets/vpn_available_servers_data.dart';

class VpnLocationScreen extends StatelessWidget {
  VpnLocationScreen({super.key});

  final vpnLocationController = VpnLocationController();

  @override
  Widget build(BuildContext context) {
    if (vpnLocationController.vpnServerList.isEmpty) {
      vpnLocationController.retrieveVpnInformation();
    }
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('VPN Locations ${vpnLocationController.vpnServerList.length}'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            vpnLocationController.retrieveVpnInformation();
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(CupertinoIcons.refresh_circled),
        ),
        body: vpnLocationController.isLoadingLocations.value
            ? const LoadingWidget()
            : vpnLocationController.vpnServerList.isEmpty
                ? const NoVpnFoundWidget()
                : VpnAvailableServersData(
                    controller: vpnLocationController,
                  ),
      ),
    );
  }
}
