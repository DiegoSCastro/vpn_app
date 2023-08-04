import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/models/vpn_status.dart';
import 'package:vpn_app/screens/home/home_controller.dart';
import 'package:vpn_app/screens/vpn_location/vpn_location_screen.dart';
import 'package:vpn_app/settings/app_preferences.dart';
import 'package:vpn_app/vpn_engine/vpn_engine.dart';
import 'package:vpn_app/widgets/custom_round_widget.dart';

import '../../widgets/vpn_round_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    VpnEngine.snapshotVpnStage().listen((event) {
      homeController.vpnConnectionState.value = event;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Free VPN'),
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.perm_device_info),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(AppPreferences.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              AppPreferences.isDarkMode = !AppPreferences.isDarkMode;
            },
            icon: const Icon(Icons.brightness_2_outlined),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Semantics(
          button: true,
          child: InkWell(
            onTap: () {
              Get.to(() => VpnLocationScreen());
            },
            child: Container(
              color: Colors.redAccent,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 62,
              child: const Row(
                children: [
                  Icon(
                    CupertinoIcons.flag_circle,
                    color: Colors.white,
                    size: 36,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Select Country / Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.redAccent,
                      size: 26,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRoundWidget(
                  title: homeController.vpnInfo.value.countryLongName.isEmpty
                      ? 'Location'
                      : homeController.vpnInfo.value.countryLongName,
                  subtitle: 'FREE',
                  roundWidget: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.redAccent,
                    backgroundImage: homeController.vpnInfo.value.countryShortName.isEmpty
                        ? null
                        : AssetImage(
                            'assets/flags/${homeController.vpnInfo.value.countryShortName.toLowerCase()}.png',
                          ),
                    child: homeController.vpnInfo.value.countryLongName.isEmpty
                        ? const Icon(
                            Icons.graphic_eq,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                CustomRoundWidget(
                  title: homeController.vpnInfo.value.ping == 0
                      ? 'no ping'
                      : '${homeController.vpnInfo.value.ping} ms',
                  subtitle: 'PING',
                  roundWidget: const CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.black54,
                    child: Icon(
                      Icons.graphic_eq,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          VpnRoundButton(homeController: homeController),
          StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.snapshotVpnStatus(),
            builder: (context, snapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRoundWidget(
                    title: '${snapshot.data?.byteIn ?? 0} Kb/s',
                    subtitle: 'DOWNLOAD',
                    roundWidget: const CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.arrow_circle_down,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CustomRoundWidget(
                    title: '${snapshot.data?.byteOut ?? 0} Kb/s',
                    subtitle: 'UPLOAD',
                    roundWidget: const CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.purpleAccent,
                      child: Icon(
                        Icons.arrow_circle_up,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
