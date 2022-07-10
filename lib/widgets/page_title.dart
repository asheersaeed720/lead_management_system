import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lead_management_system/utils/constants.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    Key? key,
    required this.title,
    required this.iconData,
  }) : super(key: key);

  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: kPrimaryColor,
          ),
          child: Icon(iconData, color: Colors.white, size: 20.0),
        ),
        const SizedBox(width: 6.0),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            title,
            style: kTitleStyle.copyWith(color: Colors.grey.shade800),
          ),
        ),
      ],
    );
  }
}
