import 'package:flutter/material.dart';

import '../routes/route_handeler.dart';

class SubNavigationRoutes {
  String title;
  IconData icon;
  RouteData route;
  SubNavigationRoutes({required this.title, required this.icon, required this.route});
}

List<SubNavigationRoutes> routeList = [
  SubNavigationRoutes(
    title: RouteData.setting.name.toUpperCase(),
    icon: Icons.settings,
    route: RouteData.setting,
  ),
];
