import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lead_management_system/src/auth/auth_controller.dart';
import 'package:lead_management_system/src/hive/hive_storage_service.dart';
import 'package:lead_management_system/utils/routes/route_delegate.dart';
import 'package:lead_management_system/utils/routes/route_handeler.dart';
import 'package:lead_management_system/utils/routes/sub_navigation_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  // Receives the name of the route from router delegate
  final String routeName;

  const MainScreen({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<void> launchLink(String url, {bool isNewTab = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }

  _logOut() async {
    await HiveDataStorageService.logOutUser();
    Get.find<AuthController>().logoutUser();
    AppRouterDelegate().setPathName(RouteData.login.name, loggedIn: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => _logOut(),
              child: const Center(
                child: Text(
                  'Log Out ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
      body: Row(
        key: UniqueKey(),
        children: [
          Drawer(
            elevation: 1,
            child: ListView.builder(
              itemCount: routeList.length,
              itemBuilder: (context, i) {
                return _navTile(routeList[i]);
              },
            ),
          ),
          Expanded(
            child: Center(child: RouteHandeler().getRouteWidget(widget.routeName)),
          ),
        ],
      ),
    );
  }

  Widget _navTile(SubNavigationRoutes subRoute) {
    return ListTile(
      leading: Icon(
        subRoute.icon,
        color: widget.routeName.contains(subRoute.route.name) ? Colors.blue : Colors.grey,
      ),
      title: Text(
        subRoute.title,
        style: TextStyle(
          color: widget.routeName.contains(subRoute.route.name) ? Colors.blue : Colors.grey,
        ),
      ),
      onTap: () {
        AppRouterDelegate().setPathName(subRoute.route.name);
      },
    );
  }
}
