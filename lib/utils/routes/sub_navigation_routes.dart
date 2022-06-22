import 'package:flutter/material.dart';
import 'package:lead_management_system/utils/routes/route_handeler.dart';

class SubNavigationRoutes {
  String title;
  IconData icon;
  RouteData route;
  SubNavigationRoutes({required this.title, required this.icon, required this.route});
}

List<SubNavigationRoutes> routeList = [
  SubNavigationRoutes(
    title: RouteData.dashboard.name.toUpperCase(),
    icon: Icons.dashboard,
    route: RouteData.dashboard,
  ),
  SubNavigationRoutes(
    title: RouteData.settings.name.toUpperCase(),
    icon: Icons.settings,
    route: RouteData.settings,
  ),
];
