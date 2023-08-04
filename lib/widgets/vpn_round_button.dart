import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/screens/home/home_controller.dart';

class VpnRoundButton extends StatelessWidget {
  final HomeController homeController;
  const VpnRoundButton({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Obx(
      () => Column(
        children: [
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: homeController.getRoundVpnButtonColor.withOpacity(0.1),
                ),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.getRoundVpnButtonColor.withOpacity(0.3),
                  ),
                  child: Container(
                    height: size.height * 0.14,
                    // width: size.width * 0.14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: homeController.getRoundVpnButtonColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.power_settings_new,
                          size: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          homeController.getRoundVpnButtonText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
