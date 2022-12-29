import 'package:covid_19_app/Model/WordStateModel.dart';
import 'package:covid_19_app/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class CounterState extends StatefulWidget {
  const CounterState({Key? key}) : super(key: key);

  @override
  State<CounterState> createState() => _CounterStateState();
}

class _CounterStateState extends State<CounterState> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    Services _serviece = Services();
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SizedBox(
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Search Country Name",
                  suffixIcon: _controller.text.isEmpty
                      ? const Icon(Icons.search)
                      : GestureDetector(
                          onTap: () {
                            _controller.text = "";
                            setState(() {});
                          },
                          child: Icon(Icons.clear)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                controller: _controller,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: _serviece.Counter_Data(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: ListView.builder(
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                              leading: Container(
                                height: 30,
                                width: 50,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 100,
                                color: Colors.white,
                              ),
                            );
                          }),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (_controller.text.isEmpty) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  leading: Image.network(
                                    snapshot.data![index]['countryInfo']
                                        ['flag'],
                                    height: 100,
                                    width: 40,
                                  ),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                ),
                              ],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(_controller.text.toLowerCase())) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  leading: Image.network(
                                    snapshot.data![index]['countryInfo']
                                        ['flag'],
                                    height: 100,
                                    width: 40,
                                  ),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                ),
                              ],
                            );
                          } else {
                            return Center(child: Text("No Data Found"));
                          }
                        });
                  }
                }),
          )
        ]),
      ),
    );
  }
}
