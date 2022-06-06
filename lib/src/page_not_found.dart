import 'package:flutter/material.dart';
import 'package:lead_management_system/utils/constants.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/404.png",
            width: 350,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Page not found", style: kTitleStyle.copyWith(fontSize: 24.0)),
            ],
          )
        ],
      ),
    );
  }
}
