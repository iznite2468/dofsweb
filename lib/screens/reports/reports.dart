import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:dofsweb/blocs/home/home_bloc.dart';
import 'package:dofsweb/models/pivot_by_disease.dart';
import 'package:dofsweb/models/pivot_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'helper/file_save_helper.dart';

class ReportsPage extends StatelessWidget {
  ReportsPage({Key? key}) : super(key: key);

  final chartKey = GlobalKey<SfCartesianChartState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 500,
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  items: const [
                    DropdownMenuItem(
                      child: Text('Dengue'),
                      value: 'Dengue',
                    ),
                    DropdownMenuItem(
                      child: Text('Rabies'),
                      value: 'Rabies',
                    ),
                    DropdownMenuItem(
                      child: Text('Tuberculosis'),
                      value: 'Tuberculosis',
                    ),
                  ],
                  onChanged: (String? value) {
                    context.read<HomeBloc>().add(LoadPivotResult(value!));
                  },
                  value: 'Dengue',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is LoadingPivotResult) {
                      return const SpinKitRing(
                        color: Colors.black,
                        size: 30,
                        lineWidth: 3,
                      );
                    }
                    if (state is PivotResultLoaded) {
                      final pivotResult = state.pivotResult;
                      return SfCartesianChart(
                        key: chartKey,
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
                            xValueMapper: (PivotByDisease result, _) =>
                                result.weeks.toString(),
                            yValueMapper: (PivotByDisease result, _) =>
                                result.i2017,
                            legendIconType: LegendIconType.diamond,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            legendItemText: '2017',
                          ),
                          LineSeries(
                            width: 4,
                            dataSource: pivotResult,
                            xValueMapper: (PivotByDisease result, _) =>
                                result.weeks.toString(),
                            yValueMapper: (PivotByDisease result, _) =>
                                result.i2018,
                            legendIconType: LegendIconType.diamond,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            legendItemText: '2018',
                          ),
                          LineSeries(
                            width: 4,
                            dataSource: pivotResult,
                            xValueMapper: (PivotByDisease result, _) =>
                                result.weeks.toString(),
                            yValueMapper: (PivotByDisease result, _) =>
                                result.i2019,
                            legendIconType: LegendIconType.diamond,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            legendItemText: '2019',
                          ),
                          LineSeries(
                            width: 4,
                            dataSource: pivotResult,
                            xValueMapper: (PivotByDisease result, _) =>
                                result.weeks.toString(),
                            yValueMapper: (PivotByDisease result, _) =>
                                result.i2020,
                            legendIconType: LegendIconType.diamond,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            legendItemText: '2020',
                          ),
                          LineSeries(
                            width: 4,
                            dataSource: pivotResult,
                            xValueMapper: (PivotByDisease result, _) =>
                                result.weeks.toString(),
                            yValueMapper: (PivotByDisease result, _) =>
                                result.i2021,
                            legendIconType: LegendIconType.diamond,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            legendItemText: '2021',
                          ),
                          LineSeries(
                            width: 4,
                            dataSource: pivotResult,
                            xValueMapper: (PivotByDisease result, _) =>
                                result.weeks.toString(),
                            yValueMapper: (PivotByDisease result, _) =>
                                result.i2022,
                            legendIconType: LegendIconType.diamond,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            legendItemText: '2022',
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: Text('Something went wrong!'));
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  _renderPDF(context);
                },
                icon: const Icon(Icons.print),
                label: const Text('Print'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.grey.shade100,
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Future<void> _renderPDF(BuildContext context) async {
    final List<int> imageBytes = await _readImageData();
    final PdfBitmap bitmap = PdfBitmap(imageBytes);
    final PdfDocument document = PdfDocument();
    document.pageSettings.orientation = PdfPageOrientation.landscape;
    document.pageSettings.size =
        Size(bitmap.height.toDouble(), bitmap.width.toDouble());
    final PdfPage page = document.pages.add();
    final Size pageSize = page.getClientSize();
    page.graphics.drawImage(
        bitmap, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));
    await FileSaveHelper.saveAndLaunchFile(document.save(), 'forecasting.pdf');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      duration: Duration(milliseconds: 2000),
      content: Text('Chart has been exported as PDF document.'),
    ));
  }

  Future<List<int>> _readImageData() async {
    final ui.Image data = await chartKey.currentState!.toImage(pixelRatio: 3.0);
    final ByteData? bytes =
        await data.toByteData(format: ui.ImageByteFormat.png);
    return bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }
}
