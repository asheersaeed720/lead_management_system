import 'package:flutter/material.dart';
import 'package:lead_management_system/utils/split_route_params.dart';

class SettingScreen extends StatelessWidget {
  final String routeName;

  const SettingScreen({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      getRouteParams(routeName).length > 1
          ? "Settings Screen with param ${getRouteParams(routeName)[1]}"
          : "Settings Screen",
    );
  }
}
