import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lead_management_system/utils/constants.dart';

class ViewAnalytics extends StatefulWidget {
  const ViewAnalytics({Key? key}) : super(key: key);

  @override
  State<ViewAnalytics> createState() => _ViewAnalyticsState();
}

class _ViewAnalyticsState extends State<ViewAnalytics> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, bottom: 6.0),
              child: Text('View Analytics', style: kTitleStyle),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(38.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total Leads',
                        style: kBodyStyle.copyWith(color: Colors.grey),
                      ),
                      Text(
                        '290000k',
                        style: kTitleStyle.copyWith(fontSize: 24.0, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(38.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Unique Leads',
                        style: kBodyStyle.copyWith(color: Colors.grey),
                      ),
                      Text(
                        '500k',
                        style: kTitleStyle.copyWith(fontSize: 24.0, color: Colors.indigoAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(38.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total Leads',
                        style: kBodyStyle.copyWith(color: Colors.grey),
                      ),
                      Text(
                        '290000k',
                        style: kTitleStyle.copyWith(fontSize: 24.0, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(38.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Unique Leads',
                        style: kBodyStyle.copyWith(color: Colors.grey),
                      ),
                      Text(
                        '500k',
                        style: kTitleStyle.copyWith(fontSize: 24.0, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
