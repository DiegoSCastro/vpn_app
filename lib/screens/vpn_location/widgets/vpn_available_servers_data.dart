import 'package:flutter/material.dart';
import 'package:vpn_app/screens/vpn_location/vpn_location_controller.dart';
import 'package:vpn_app/screens/vpn_location/widgets/vpn_location_card.dart';

class VpnAvailableServersData extends StatelessWidget {
  final VpnLocationController controller;
  const VpnAvailableServersData({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.vpnServerList.length,
      padding: const EdgeInsets.all(8),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final vpnInfo = controller.vpnServerList[index];
        return VpnLocationCard(vpnInfo: vpnInfo);
      },
    );
  }
}
