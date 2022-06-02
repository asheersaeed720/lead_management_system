import 'package:flutter/material.dart';
import 'package:lead_management_system/pages/clients/clients.dart';
import 'package:lead_management_system/pages/drivers/drivers.dart';
import 'package:lead_management_system/pages/overview/overview.dart';
import 'package:lead_management_system/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case driversPageRoute:
      return _getPageRoute(DriversPage());
    case clientsPageRoute:
      return _getPageRoute(ClientsPage());
    default:
      return _getPageRoute(OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
