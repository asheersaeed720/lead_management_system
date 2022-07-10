import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lead_management_system/src/dashboard/popup_menu/popup_menu.dart';
import 'package:lead_management_system/utils/constants.dart';
import 'package:lead_management_system/utils/input_decoration.dart';
import 'package:lead_management_system/utils/responsive_builder.dart';
import 'package:lead_management_system/utils/routes/route_delegate.dart';
import 'package:lead_management_system/utils/routes/route_handeler.dart';

class MainScreenController extends GetxController {
  int selectedIndex = 0;

  onTapItem(int index) {
    selectedIndex = index;
    if (index == 0) {
      AppRouterDelegate().setPathName(RouteData.dashboard.name);
    } else if (index == 1) {
      AppRouterDelegate().setPathName(RouteData.user.name);
    } else if (index == 2) {
      AppRouterDelegate().setPathName(RouteData.settings.name);
    }
    update();
  }
}

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
  // Future<void> launchLink(String url, {bool isNewTab = true}) async {
  //   await launchUrl(
  //     Uri.parse(url),
  //     webOnlyWindowName: isNewTab ? '_blank' : '_self',
  //   );
  // }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade50,
      backgroundColor: const Color(0xFFf2edf3),
      body: SafeArea(
        child: ResponsiveBuilder(
          mobileBuilder: (BuildContext context, BoxConstraints constraints) =>
              const Text('Mobile View'),
          tabletBuilder: (BuildContext context, BoxConstraints constraints) =>
              const Text('Tablet View'),
          desktopBuilder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSideNavView(),
                const VerticalDivider(thickness: 0.5, width: 1),
                Flexible(
                  flex: constraints.maxWidth > 1350 ? 10 : 9,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: _buildAppBarAndBodyView(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSideNavView() {
    return GetBuilder<MainScreenController>(
      init: MainScreenController(),
      builder: (mainController) => NavigationRail(
        backgroundColor: kPrimaryColor,
        selectedIndex: mainController.selectedIndex,
        onDestinationSelected: mainController.onTapItem,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: const IconThemeData(color: Colors.white70),
        labelType: NavigationRailLabelType.all,
        useIndicator: true,
        indicatorColor: kPrimaryColor.shade800,
        elevation: 10.0,
        selectedLabelTextStyle: kBodyStyle.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontFamily: fontName,
        ),
        unselectedLabelTextStyle: kBodyStyle.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.w500,
          fontFamily: fontName,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/icons/logo-white.png', width: 50.0),
        ),
        destinations: const <NavigationRailDestination>[
          NavigationRailDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Text('Dashboard'),
            ),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Text('Users'),
            ),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.settings_applications_outlined),
            selectedIcon: Icon(Icons.settings_applications),
            label: Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Text('Setting'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarAndBodyView() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                offset: Offset(2, 1),
              )
            ],
            color: Colors.white,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: const Icon(EvaIcons.menu),
              ),
              const SizedBox(width: 14.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 38.0,
                child: TextFormField(
                  controller: _searchController,
                  decoration: buildTextFieldInputDecoration(
                    context,
                    preffixIcon: const Icon(EvaIcons.search),
                    labelTxt: 'Search',
                  ),
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  textInputAction: TextInputAction.search,
                ),
              ),
              const Spacer(),
              Stack(
                children: [
                  const Icon(Icons.notifications, color: Colors.grey),
                  Positioned(
                    right: 0.0,
                    child: Icon(
                      Icons.circle,
                      size: 8.0,
                      color: Colors.red.shade700,
                    ),
                  )
                ],
              ),
              const SizedBox(width: 18.0),
              InkWell(
                onTap: () {},
                child: MyPopupMenu(
                  child: Row(
                    key: GlobalKey(),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(width: 2.0, color: kPrimaryColor),
                        ),
                        child: const CircleAvatar(
                          minRadius: 12.0,
                          maxRadius: 18.0,
                          backgroundImage: AssetImage('assets/images/man.png'),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      const Text('Administrator'),
                      const Icon(Icons.arrow_drop_down_rounded),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 18.0),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        RouteHandeler().getRouteWidget(widget.routeName),
      ],
    );
  }
}
