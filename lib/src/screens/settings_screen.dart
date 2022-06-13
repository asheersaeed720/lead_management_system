import 'package:flutter/material.dart';
import 'package:lead_management_system/src/auth/split_route_params.dart';

class Settings extends StatelessWidget {
  final String routeName;

  const Settings({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        getRouteParams(routeName).length > 1
            ? "Settings Screen with param ${getRouteParams(routeName)[1]}"
            : "Settings Screen",
        style: const TextStyle(color: Colors.blue, fontSize: 16),
      ),
    );
  }
}
