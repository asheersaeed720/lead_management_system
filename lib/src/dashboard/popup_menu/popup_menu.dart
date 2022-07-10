import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lead_management_system/src/auth/auth_controller.dart';
import 'package:lead_management_system/utils/constants.dart';
import 'package:lead_management_system/utils/responsive_builder.dart';

class MyPopupMenu extends StatefulWidget {
  final Widget child;

  const MyPopupMenu({Key? key, required this.child}) : super(key: key);
  // MyPopupMenu({Key? key, required this.child})
  //     // : assert(child.key != null),
  //       super(key: key);

  @override
  State<MyPopupMenu> createState() => _MyPopupMenuState();
}

class _MyPopupMenuState extends State<MyPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showPopupMenu,
      child: widget.child,
    );
  }

  void _showPopupMenu() {
    //Find renderbox object
    RenderBox renderBox =
        (widget.child.key as GlobalKey).currentContext?.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopupMenuContent(
          position: position,
          size: renderBox.size,
          onAction: (x) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 1),
                content: Text('Action => $x'),
              ),
            );
          },
        );
      },
    );
  }
}

class PopupMenuContent extends StatefulWidget {
  final Offset position;
  final Size size;
  final ValueChanged<String>? onAction;
  const PopupMenuContent({Key? key, required this.position, required this.size, this.onAction})
      : super(key: key);

  @override
  State<PopupMenuContent> createState() => _PopupMenuContentState();
}

class _PopupMenuContentState extends State<PopupMenuContent> with SingleTickerProviderStateMixin {
  //Let's create animation
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _closePopup("");
        return false;
      },
      child: GestureDetector(
        onTap: () => _closePopup(""),
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  left: ResponsiveBuilder.isMobile(context) ? 0 : 1100,
                  right:
                      (MediaQuery.of(context).size.width - widget.position.dx) - widget.size.width,
                  top: widget.position.dy,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _animation.value,
                        alignment: Alignment.topRight,
                        child: Opacity(opacity: _animation.value, child: child),
                      );
                    },
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        margin: const EdgeInsets.only(left: 64),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              blurRadius: 8,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => _closePopup("getHelp"),
                              child: Container(
                                width: double.maxFinite,
                                height: 150,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                  // color: const Color(0xFFC2E3F6),
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(kBorderRadius),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CircleAvatar(
                                        minRadius: 26.0,
                                        maxRadius: 32.0,
                                        backgroundImage: AssetImage('assets/images/man.png'),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text('Administrator', style: kTitleStyle),
                                      Text(
                                        'test@test.com',
                                        style: kBodyStyle.copyWith(
                                            color: Colors.grey, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () => _closePopup("profile"),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE1E1FC),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: const Icon(
                                      EvaIcons.alertCircleOutline,
                                      color: Color(0xFF3840A2),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "Profile",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(.7),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 22.0,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            //Share workout
                            const SizedBox(
                              height: 16,
                            ),

                            GestureDetector(
                              onTap: () async {
                                await Get.find<AuthController>().logoutUser();
                              },
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDDF3FD),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: const Icon(
                                      EvaIcons.logOut,
                                      color: Color(0xFF0586C0),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(.7),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 22.0,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),

                            //Chat box
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _closePopup(String action) {
    _animationController.reverse().whenComplete(() {
      Navigator.of(context).pop();
      if (action.isNotEmpty) widget.onAction?.call(action);
    });
  }
}
