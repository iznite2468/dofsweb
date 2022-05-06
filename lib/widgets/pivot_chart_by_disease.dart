import 'package:dofsweb/models/pivot_by_disease.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PivotChartByDisease extends StatelessWidget {
  final List<PivotByDisease> pivotResult;
  const PivotChartByDisease({
    Key? key,
    required this.pivotResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
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
      series: <ChartSeries<PivotByDisease, String>>[
        LineSeries(
          width: 4,
          dataSource: pivotResult,
          xValueMapper: (PivotByDisease result, _) => result.weeks.toString(),
          yValueMapper: (PivotByDisease result, _) => result.i2017,
          legendIconType: LegendIconType.diamond,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          legendItemText: '2017',
        ),
        LineSeries(
          width: 4,
          dataSource: pivotResult,
          xValueMapper: (PivotByDisease result, _) => result.weeks.toString(),
          yValueMapper: (PivotByDisease result, _) => result.i2018,
          legendIconType: LegendIconType.diamond,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          legendItemText: '2018',
        ),
        LineSeries(
          width: 4,
          dataSource: pivotResult,
          xValueMapper: (PivotByDisease result, _) => result.weeks.toString(),
          yValueMapper: (PivotByDisease result, _) => result.i2019,
          legendIconType: LegendIconType.diamond,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          legendItemText: '2019',
        ),
        LineSeries(
          width: 4,
          dataSource: pivotResult,
          xValueMapper: (PivotByDisease result, _) => result.weeks.toString(),
          yValueMapper: (PivotByDisease result, _) => result.i2020,
          legendIconType: LegendIconType.diamond,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          legendItemText: '2020',
        ),
        LineSeries(
          width: 4,
          dataSource: pivotResult,
          xValueMapper: (PivotByDisease result, _) => result.weeks.toString(),
          yValueMapper: (PivotByDisease result, _) => result.i2021,
          legendIconType: LegendIconType.diamond,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          legendItemText: '2021',
        ),
        LineSeries(
          width: 4,
          dataSource: pivotResult,
          xValueMapper: (PivotByDisease result, _) => result.weeks.toString(),
          yValueMapper: (PivotByDisease result, _) => result.i2022,
          legendIconType: LegendIconType.diamond,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          legendItemText: '2022',
        ),
      ],
    );
  }
}
