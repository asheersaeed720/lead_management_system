import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lead_management_system/src/dashboard/card_task.dart';
import 'package:lead_management_system/src/dashboard/components/pie_chart.dart';
import 'package:lead_management_system/src/dashboard/components/stacked_column.dart';
import 'package:lead_management_system/utils/constants.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';

  DashboardScreen({Key? key}) : super(key: key);

  final data = [
    CardTaskData(
      label: "Determine meeting schedule",
      jobDesk: "System Analyst",
      dueDate: DateTime.now().add(const Duration(minutes: 50)),
    ),
    CardTaskData(
      label: "Personal branding",
      jobDesk: "Marketing",
      dueDate: DateTime.now().add(const Duration(hours: 4)),
    ),
    CardTaskData(
      label: "UI UX",
      jobDesk: "Design",
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    CardTaskData(
      label: "Determine meeting schedule",
      jobDesk: "System Analyst",
      dueDate: DateTime.now().add(const Duration(minutes: 50)),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCountBoxView(),
        const SizedBox(height: 20.0),
        Row(
          children: const [
            StackedColumnChart(),
            PieChart(),
          ],
        ),
      ],
    );
  }

  Widget _buildCountBoxView() {
    Color _getSequenceColor(int index) {
      int val = index % 4;
      if (val == 3) {
        return Colors.indigo;
      } else if (val == 2) {
        return Colors.grey;
      } else if (val == 1) {
        return Colors.redAccent;
      } else {
        return Colors.lightBlue;
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(kBorderRadius * 2),
      child: SizedBox(
        height: 250,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
            child: CardTask(
              data: data[index],
              primary: _getSequenceColor(index),
              onPrimary: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
