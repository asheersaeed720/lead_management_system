import 'package:flutter/material.dart';
import 'package:lead_management_system/widgets/page_title.dart';

class SettingScreen extends StatelessWidget {
  final String routeName;

  const SettingScreen({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: const [
            PageTitle(
              title: 'Setting',
              iconData: Icons.settings,
            ),
          ],
        ),
      ),
    );
  }
}
