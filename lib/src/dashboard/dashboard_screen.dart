import 'package:flutter/material.dart';
import 'package:lead_management_system/routes/route_delegate.dart';
import 'package:lead_management_system/routes/route_handeler.dart';
import 'package:lead_management_system/utils/sub_navigation_routes.dart';

class DashboardScreen extends StatefulWidget {
  final String routeName;

  const DashboardScreen({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Widget? render;

  @override
  Widget build(BuildContext context) {
    return Text('asd');
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Dashboard'),
    //     actions: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: InkWell(
    //           onTap: () => _logOut(),
    //           child: const Center(
    //             child: Text(
    //               'Log Out ',
    //               style: TextStyle(color: Colors.white, fontSize: 16),
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    //   body: Row(
    //     key: UniqueKey(),
    //     children: [
    //       Drawer(
    //         elevation: 1,
    //         child: ListView.builder(
    //             itemCount: routeList.length,
    //             itemBuilder: (context, i) {
    //               return _navTile(routeList[i]);
    //             }),
    //       ),
    //       Expanded(
    //         child: Center(child: RouteHandeler().getRouteWidget(widget.routeName)),
    //       ),
    //     ],
    //   ),
    // );
  }

  _logOut() async {
    // await HiveDataStorageService.logOutUser();
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
