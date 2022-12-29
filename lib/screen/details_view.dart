import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  String? name, image, cases, recovery, deaths, test, cirtical, active;

  DetailView(
      {this.active,
      this.name,
      this.image,
      this.deaths,
      this.cases,
      this.recovery,
      this.test,
      this.cirtical});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name!),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 60, left: 10, right: 10),
                    child: Center(
                      child: Card(
                        child: Column(
                          children: [
                            ListShow(
                              title: "Cases",
                              value: cases,
                            ),
                            ListShow(
                              title: "Deaths",
                              value: deaths,
                            ),
                            ListShow(
                              title: "Recovery",
                              value: recovery,
                            ),
                            ListShow(
                              title: "Active",
                              value: active,
                            ),
                            ListShow(
                              title: "Cirtical",
                              value: cirtical,
                            ),
                            ListShow(
                              title: "Test",
                              value: test,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(image!),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListShow extends StatelessWidget {
  String? title;
  String? value;

  ListShow({this.title, this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title!),
              Text(value.toString()),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
