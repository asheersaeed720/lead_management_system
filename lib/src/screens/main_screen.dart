import 'package:flutter/material.dart';
import 'package:lead_management_system/src/data.dart';
import 'package:lead_management_system/src/hive_storage_service.dart';
import 'package:lead_management_system/src/routes/route_delegate.dart';
import 'package:lead_management_system/src/routes/route_handeler.dart';

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
  // Widget? render;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
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
                }),
          ),
          Expanded(
            child: Center(child: RouteHandeler().getRouteWidget(widget.routeName)),
          ),
        ],
      ),
    );
  }

  _logOut() async {
    await HiveDataStorageService.logOutUser();
    AppRouterDelegate().setPathName(RouteData.login.name, loggedIn: false);
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
