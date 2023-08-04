import 'package:get/get.dart';
import 'package:vpn_app/settings/app_preferences.dart';

import '../../models/vpn_info.dart';
import '../../repositories/vpn_repository.dart';

class VpnLocationController extends GetxController {
  List<VpnInfo> vpnServerList = AppPreferences.vpnList;

  final RxBool isLoadingLocations = false.obs;

  Future<void> retrieveVpnInformation() async {
    isLoadingLocations.value = true;
    vpnServerList.clear();
    vpnServerList = await VpnRepository.getAvailableVpnServers();
    isLoadingLocations.value = false;
  }
}
