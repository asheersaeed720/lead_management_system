import 'package:flutter/material.dart';
import 'package:lead_management_system/src/dashboard/components/list_task_assigned.dart';
import 'package:lead_management_system/utils/constants.dart';

class WeeklyTask extends StatelessWidget {
  const WeeklyTask({
    required this.data,
    // required this.onPressed,
    // required this.onPressedAssign,
    // required this.onPressedMember,
    Key? key,
  }) : super(key: key);

  final List<ListTaskAssignedData> data;
  // final Function(int index, ListTaskAssignedData data) onPressed;
  // final Function(int index, ListTaskAssignedData data) onPressedAssign;
  // final Function(int index, ListTaskAssignedData data) onPressedMember;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, bottom: 6.0),
              child: Text('Most Recent', style: kTitleStyle),
            ),
            const Divider(),
            ...data
                .asMap()
                .entries
                .map(
                  (e) => ListTaskAssigned(
                    data: e.value,
                    // onPressed: () => onPressed(e.key, e.value),
                    // onPressedAssign: () => onPressedAssign(e.key, e.value),
                    // onPressedMember: () => onPressedMember(e.key, e.value),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
