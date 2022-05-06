import 'package:dofsweb/models/pivot_result.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PivotChart extends StatelessWidget {
  final List<PivotResult> pivotResult;
  const PivotChart({
    Key? key,
    required this.pivotResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(
          text: 'Forecasting',
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        enableAxisAnimation: true,
        series: <ChartSeries<PivotResult, String>>[
          LineSeries(
            width: 4,
            dataSource: pivotResult,
            xValueMapper: (PivotResult result, _) => DateFormat('MM-dd-yyyy')
                .format(DateTime.tryParse(result.quarter!)!)
                .toString(),
            yValueMapper: (PivotResult result, _) => result.tuberculosis!,
            legendIconType: LegendIconType.diamond,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            legendItemText: 'TUBERCULOSIS',
          ),
          LineSeries(
            width: 4,
            dataSource: pivotResult,
            xValueMapper: (PivotResult result, _) => DateFormat('MM-dd-yyyy')
                .format(DateTime.tryParse(result.quarter!)!)
                .toString(),
            yValueMapper: (PivotResult result, _) => result.rabies!,
            legendIconType: LegendIconType.diamond,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            legendItemText: 'RABIES',
          ),
          LineSeries(
            width: 4,
            dataSource: pivotResult,
            xValueMapper: (PivotResult result, _) => DateFormat('MM-dd-yyyy')
                .format(DateTime.tryParse(result.quarter!)!)
                .toString(),
            yValueMapper: (PivotResult result, _) => result.dengue!,
            legendIconType: LegendIconType.diamond,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            legendItemText: 'DENGUE',
          ),
        ],
      ),
    );
  }
}
