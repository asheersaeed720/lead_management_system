import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lead_management_system/constants/controllers.dart';
import 'package:lead_management_system/helpers/reponsiveness.dart';
import 'package:lead_management_system/pages/clients/widgets/clients_table.dart';
import 'package:lead_management_system/widgets/custom_text.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              Clientstable(),
            ],
          )),
        ],
      ),
    );
  }
}
