import 'dart:convert';

import 'package:covid_19_app/Model/WordStateModel.dart';
import 'package:covid_19_app/screen/Counter_state.dart';
import 'package:covid_19_app/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();
  List<Color> ColorList = [
    Color(0xff00FF00),
    Color(0xffFF0000),
    Color(0xff0000FF),
  ];

  @override
  Widget build(BuildContext context) {
    Services _services = Services();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: _services.World_Data(),
                  builder: (context, AsyncSnapshot<WordStateModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: PieChart(
                              dataMap: {
                                "Total": double.parse(
                                    snapshot.data!.cases!.toString()),
                                "Recovery": double.parse(
                                    snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(
                                    snapshot.data!.deaths!.toString()),
                              },
                              chartType: ChartType.ring,
                              chartRadius: 150,
                              colorList: ColorList,
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Expanded(
                              child: Card(
                                child: Column(
                                  children: [
                                    RowWidget(
                                      titel: "Total",
                                      value: snapshot.data!.cases.toString(),
                                    ),
                                    RowWidget(
                                      titel: "Recovered",
                                      value:
                                          snapshot.data!.recovered.toString(),
                                    ),
                                    RowWidget(
                                      titel: "Deaths",
                                      value: snapshot.data!.deaths.toString(),
                                    ),
                                    RowWidget(
                                      titel: "Active",
                                      value: snapshot.data!.active.toString(),
                                    ),
                                    RowWidget(
                                      titel: "TodayRecovered",
                                      value: snapshot.data!.todayRecovered
                                          .toString(),
                                    ),
                                    RowWidget(
                                      titel: "TodayDeaths",
                                      value:
                                          snapshot.data!.todayDeaths.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CounterState()));
                            },
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  "Track Counter",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  String? titel, value;
  RowWidget({this.titel, this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(titel!),
              Text(value!),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
