import 'package:covid_19_app/screen/details_view.dart';
import 'package:covid_19_app/screen/home_view.dart';
import 'package:covid_19_app/services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  TextEditingController searching = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Services _service = Services();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeView()));
            },
            child: Icon(Icons.arrow_back_ios)),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      hintText: "search with country name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                  controller: searching,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: _service.Counter_Data(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: 30,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                    title: Container(
                                      height: 10,
                                      width: 10,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 10,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              );
                            }),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (searching.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => DetailView(
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    name: snapshot.data![index]
                                                            ['country']
                                                        .toString(),
                                                    cases: snapshot.data![index]
                                                            ['cases']
                                                        .toString(),
                                                    recovery: snapshot
                                                        .data![index]
                                                            ['recovered']
                                                        .toString(),
                                                    deaths: snapshot
                                                        .data![index]['deaths']
                                                        .toString(),
                                                    test: snapshot.data![index]
                                                            ['tests']
                                                        .toString(),
                                                    active: snapshot
                                                        .data![index]['active']
                                                        .toString(),
                                                    cirtical: snapshot
                                                        .data![index]
                                                            ['critical']
                                                        .toString(),
                                                  )));
                                    },
                                    child: ListTile(
                                      leading: Container(
                                        child: Image.network(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']),
                                        height: 50,
                                        width: 30,
                                      ),
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                    ),
                                  )
                                ],
                              );
                            } else if (name
                                .toLowerCase()
                                .contains(searching.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => DetailView(
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    name: snapshot.data![index]
                                                            ['country']
                                                        .toString(),
                                                    cases: snapshot.data![index]
                                                            ['cases']
                                                        .toString(),
                                                    recovery: snapshot
                                                        .data![index]
                                                            ['recovered']
                                                        .toString(),
                                                    deaths: snapshot
                                                        .data![index]['deaths']
                                                        .toString(),
                                                    test: snapshot.data![index]
                                                            ['tests']
                                                        .toString(),
                                                    active: snapshot
                                                        .data![index]['active']
                                                        .toString(),
                                                    cirtical: snapshot
                                                        .data![index]
                                                            ['critical']
                                                        .toString(),
                                                  )));
                                    },
                                    child: ListTile(
                                      leading: Container(
                                        child: Image.network(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']),
                                        height: 50,
                                        width: 30,
                                      ),
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
