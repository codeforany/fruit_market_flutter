import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';

class DeliveryBoyDashboardTabScreen extends StatefulWidget {
  const DeliveryBoyDashboardTabScreen({super.key});

  @override
  State<DeliveryBoyDashboardTabScreen> createState() => _DeliveryBoyDashboardTabScreenState();
}

class _DeliveryBoyDashboardTabScreenState extends State<DeliveryBoyDashboardTabScreen> {
  List dataArr = [
    {
      "name": "Total Orders",
      "key": "order",
      "symbol": "",
    },
    {
      "name": "Revenue",
      "key": "collect_revenue",
      "symbol": "\$",
    },
    {
      "name": "Active Deliveries",
      "key": "active_delivery",
      "symbol": "",
    }
  ];

  Map dashObj = {};
  List orderArr = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCallingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1),
              itemBuilder: (context, index) {
                var obj = dataArr[index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            "${obj["symbol"].toString()}${dashObj[obj["key"].toString()]}",
                            style: TextStyle(
                              color: TColor.primary,
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        obj["name"].toString(),
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: dataArr.length,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: SizedBox(
                height: 200,
                child: LineChart(
                  sampleData1,
                  duration: const Duration(milliseconds: 250),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //TODO: Start Chat

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) =>
              Colors.blueGrey.withValues(alpha: 0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return SideTitleWidget(
      meta: meta,
      child: Text(
        value.round().toString(),
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 16,
    );

    var date = orderArr.isEmpty
        ? ""
        : orderArr[value.toInt()]["date"]
            .toString()
            .displayDate(displayFormat: "d");

    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: value.toInt() % 3 == 0 ? Text(date, style: style) : const Text(''),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: Colors.black.withValues(alpha: 0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: Color(0xFF3BFF49),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: getOrderSpot(),
      );

  

  //TODO: Action

  List<FlSpot> getOrderSpot() {
    var i = -1;
    var orArr = orderArr.map((obj) {
      i += 1;
      return FlSpot(
          i.toDouble(), double.tryParse(obj["orders"].toString()) ?? 0.0);
    });

    return orArr.toList();
  }

  //TODO: End Chat

  //TODO: ApiCalling
  void apiCallingList() {
    Globs.showHUD();

    ServiceCall.post(
      {},
      SVKey.deliveryBoyDashboard,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          dashObj = responseObj[KKey.payload] as Map? ?? {};
          var chartObj = dashObj["chart"] as Map? ?? {};
          
          orderArr = chartObj["order_info"] as List? ?? [];

          if (mounted) {
            setState(() {});
          }
        } else {
          mdShowAlert(
              Globs.appName, responseObj[KKey.message].toString(), () {});
        }
      },
      failure: (error) async {
        Globs.hideHUD();
        mdShowAlert(Globs.appName, error.toString(), () {});
      },
    );
  }
}