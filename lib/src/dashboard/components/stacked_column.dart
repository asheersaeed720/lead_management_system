import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);
  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;
}

class StackedColumnChart extends StatefulWidget {
  const StackedColumnChart({Key? key}) : super(key: key);

  @override
  State<StackedColumnChart> createState() => _StackedColumnChartState();
}

class _StackedColumnChartState extends State<StackedColumnChart> {
  final List<ChartData> chartData = [
    ChartData('China', 12, 10, 14, 20),
    ChartData('USA', 14, 11, 18, 23),
    ChartData('UK', 16, 10, 15, 20),
    ChartData('Brazil', 18, 16, 18, 24)
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <ChartSeries>[
            StackedColumnSeries<ChartData, String>(
              groupName: 'Group A',
              dataLabelSettings:
                  const DataLabelSettings(isVisible: true, showCumulativeValues: true),
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y1,
            ),
            StackedColumnSeries<ChartData, String>(
              groupName: 'Group B',
              dataLabelSettings:
                  const DataLabelSettings(isVisible: true, showCumulativeValues: true),
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y2,
            ),
            StackedColumnSeries<ChartData, String>(
              groupName: 'Group A',
              dataLabelSettings:
                  const DataLabelSettings(isVisible: true, showCumulativeValues: true),
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y3,
            ),
            StackedColumnSeries<ChartData, String>(
              groupName: 'Group B',
              dataLabelSettings:
                  const DataLabelSettings(isVisible: true, showCumulativeValues: true),
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y4,
            )
          ],
        ),
      ),
    );
  }
}
