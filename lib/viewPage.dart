import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mytest/main.dart';

class viewMydataScreen extends StatefulWidget {
  @override
  State<viewMydataScreen> createState() => _viewMydataScreenState();
}

class _viewMydataScreenState extends State<viewMydataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewData();
  }

  List realTimeDatalist = [];

  viewData() async {
    final ref = FirebaseDatabase.instance.ref("myRealTimeDB");
    final DatabaseEvent dbEvent = await ref.once();
    print("my Data ${dbEvent.snapshot.value}");

    Map dataViewMap = dbEvent.snapshot.value as Map;
    dataViewMap.forEach((key, value) {
      setState(() {
        realTimeDatalist.add(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backPg,
      child: Scaffold(
        appBar: AppBar(title: const Text("Show Data")),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1)).whenComplete(() {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return viewMydataScreen();
                },
              ));
            });
          },
          child: ListView.builder(
            itemCount: realTimeDatalist.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                leading: PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          onTap: () {
                            setState(() {
                              Future<void> ref = FirebaseDatabase.instance
                                  .ref("myRealTimeDB")
                                  .child("${realTimeDatalist[index]['Id']}")
                                  .remove();
                            });
                          },
                          child: const Text("Delete"))
                    ];
                  },
                ),
                title: Text("${realTimeDatalist[index]['password']}"),
                children: [
                  Text("Id : ${realTimeDatalist[index]['user id']}"),
                  Text("Date : ${realTimeDatalist[index]['date']}")
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<bool> backPg() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const firstPage();
      },
    ));
    return Future.value(true);
  }
}
