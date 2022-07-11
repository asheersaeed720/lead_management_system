import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lead_management_system/src/call_logs/call_logs_screen.dart';
import 'package:lead_management_system/src/dashboard/dashboard_screen.dart';
import 'package:lead_management_system/src/leads/leads_screen.dart';
import 'package:lead_management_system/src/page_not_found.dart';
import 'package:lead_management_system/src/projects/projects_screen.dart';
import 'package:lead_management_system/src/setting/setting_screen.dart';
import 'package:lead_management_system/src/users/users_screen.dart';

enum RouteData {
  /// For routes for which we want to show unkown page that are not being parsed
  unkownRoute,

  /// For routes that are parsed but not data is found for them eg. /user/?userName=abc and abc doesnt exist
  notFound,

  login,
  signup,
  dashboard,
  users,
  projects,
  leads,
  callLogs,
  settings,
}

/// Class to handle route path related informations
class RouteHandeler {
  static final RouteHandeler _instance = RouteHandeler._();
  factory RouteHandeler() => _instance;
  RouteHandeler._();

  /// Returns [WidgetToRender, PathName]
  /// [WidgetToRender] - Renders specified widget
  /// [PathName] - Re-directs to [PathName] if invalid path is entered
  Widget getRouteWidget(String? routeName) {
    log('routeName $routeName');
    RouteData routeData;

    if (routeName != null) {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isNotEmpty) {
        /// Getting first endpoint
        final pathName = uri.pathSegments.elementAt(0).toString();

        /// Getting route data for specified pathName
        routeData = RouteData.values
            .firstWhere((element) => element.name == pathName, orElse: () => RouteData.notFound);

        if (routeData != RouteData.notFound) {
          switch (routeData) {
            case RouteData.dashboard:
              return DashboardScreen();

            case RouteData.users:
              return const UsersScreen();

            case RouteData.projects:
              return const ProjectsScreen();

            case RouteData.leads:
              return const LeadsScreen();

            case RouteData.callLogs:
              return const CallLogsScreen();

            case RouteData.settings:
              return SettingScreen(
                routeName: routeName,
              );

            default:
              return DashboardScreen();
          }
        } else {
          return const PageNotFound();
        }
      } else {
        return DashboardScreen();
      }
    } else {
      return const PageNotFound();
    }
  }
}
