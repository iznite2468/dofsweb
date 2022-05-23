import 'package:dofsweb/models/pivot_by_disease.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PivotChartByDisease extends StatelessWidget {
  final List<PivotByDisease> pivotResult;
  final String diseaseType;
  const PivotChartByDisease({
    Key? key,
    required this.diseaseType,
    required this.pivotResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: "Weeks"),
      ),
      primaryYAxis: NumericAxis(
        decimalPlaces: 0,
        title: AxisTitle(text: "Cases"),
      ),
      title: ChartTitle(
        text:
            'Distribution of $diseaseType Cases by Morbidity Week from ${pivotResult.first.weeks}-${pivotResult.last.weeks} week | General Santos City',
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
      ),
      legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        builder: (data, point, series, pointIndex, seriesIndex) {
          if ((point as CartesianChartPoint).yValue == 3) {
            return Container(
              color: Colors.red,
              height: 50,
              width: 100,
              child: const Text(
                'Outbreak Threshold',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              alignment: Alignment.center,
            );
          }
          return Container(
            height: 50,
            width: 100,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Series: $seriesIndex',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Point: $pointIndex',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      enableAxisAnimation: true,
      series: <ChartSeries<PivotByDisease, String>>[
        LineSeries(
          width: 7,
          dataSource: pivotResult,
          xValueMapper: (PivotByDisease result, _) => result.weeks.toString(),
          yValueMapper: (PivotByDisease result, _) => diseaseType == 'Dengue'
              ? 3
              : diseaseType == 'Tuberculosis'
                  ? 4
                  : diseaseType == 'Rabies'
                      ? 6
                      : 4,
          legendIconType: LegendIconType.diamond,
          //dataLabelSettings: const DataLabelSettings(isVisible: true),
          color: Colors.red,
          legendItemText: 'Threshold',
        ),
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
