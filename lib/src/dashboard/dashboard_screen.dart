import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lead_management_system/src/dashboard/components/card_task.dart';
import 'package:lead_management_system/src/dashboard/components/list_task_assigned.dart';
import 'package:lead_management_system/src/dashboard/components/pie_chart.dart';
import 'package:lead_management_system/src/dashboard/components/stacked_column.dart';
import 'package:lead_management_system/src/dashboard/components/view_analytics.dart';
import 'package:lead_management_system/src/dashboard/components/weekly_task.dart';
import 'package:lead_management_system/utils/constants.dart';
import 'package:lead_management_system/widgets/page_title.dart';

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

  final weeklyTask = [
    ListTaskAssignedData(
      icon: const Icon(EvaIcons.monitor, color: Colors.blueGrey),
      label: "Slicing UI",
      jobDesk: "Programmer",
      assignTo: "Alex Ferguso",
      editDate: DateTime.now().add(-const Duration(hours: 2)),
    ),
    ListTaskAssignedData(
      icon: const Icon(EvaIcons.star, color: Colors.amber),
      label: "Personal branding",
      jobDesk: "Marketing",
      assignTo: "Justin Beck",
      editDate: DateTime.now().add(-const Duration(days: 50)),
    ),
    const ListTaskAssignedData(
      icon: Icon(EvaIcons.colorPalette, color: Colors.blue),
      label: "UI UX ",
      jobDesk: "Design",
    ),
    const ListTaskAssignedData(
      icon: Icon(EvaIcons.pieChart, color: Colors.redAccent),
      label: "Determine meeting schedule ",
      jobDesk: "System Analyst",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageTitle(
              title: 'Dashboard',
              iconData: Icons.dashboard,
            ),
            const SizedBox(height: 20.0),
            _buildCountBoxView(),
            const SizedBox(height: 20.0),
            Row(
              children: const [
                StackedColumnChart(),
                SizedBox(width: 10.0),
                PieChart(),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                WeeklyTask(data: weeklyTask),
                const SizedBox(width: 10.0),
                const ViewAnalytics(),
              ],
            )
          ],
        ),
      ),
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
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          separatorBuilder: (context, _) => const SizedBox(width: 16.0),
          itemBuilder: (context, index) => CardTask(
            data: data[index],
            primary: _getSequenceColor(index),
            onPrimary: Colors.white,
          ),
        ),
      ),
    );
  }
}
