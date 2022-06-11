import 'package:flutter/material.dart';
import 'package:lead_management_system/src/auth/views/signup_screen.dart';
import 'package:lead_management_system/src/dashboard/dashboard_screen.dart';
import 'package:lead_management_system/src/page_not_found.dart';
import 'package:lead_management_system/src/setting/setting_screen.dart';

enum RouteData {
  /// For routes for which we want to show unkown page that are not being parsed
  unkownRoute,

  /// For routes that are parsed but not data is found for them eg. /user/?userName=abc and abc doesnt exist
  notFound,

  login,
  signUp,
  dashboard,
  setting,
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
              return DashboardScreen(
                routeName: routeName,
              );

            case RouteData.signUp:
              return SignUpScreen();

            case RouteData.setting:
              return const SettingScreen();

            default:
              return DashboardScreen(
                routeName: routeName,
              );
          }
        } else {
          return const PageNotFound();
        }
      } else {
        return DashboardScreen(
          routeName: routeName,
        );
      }
    } else {
      return const PageNotFound();
    }
  }
}
