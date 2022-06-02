import 'package:flutter/cupertino.dart';
import 'package:lead_management_system/constants/controllers.dart';
import 'package:lead_management_system/routing/router.dart';
import 'package:lead_management_system/routing/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: overviewPageRoute,
    );
