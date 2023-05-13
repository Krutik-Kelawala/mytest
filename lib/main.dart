import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytest/viewPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    // home: TextScreen(),
    home: firstPage(),
  ));
}

class firstPage extends StatefulWidget {
  const firstPage({Key? key}) : super(key: key);

  @override
  State<firstPage> createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController dateTimecontroller = TextEditingController();
  String dateTime = "";

  @override
  void initState() {
    dateTimecontroller.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TITLE")),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: number,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: const Text("Phone No"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                      label: const Text("PassWord"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2030));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000

                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        dateTimecontroller.text =
                            formattedDate; //set output date to TextField value.
                      });
                    }
                  },
                  controller: dateTimecontroller,
                  decoration: InputDecoration(
                      label: const Text("Date"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (number.text.isEmpty ||
                        number.text.length < 10 ||
                        number.text.length > 10) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Enter 10 Digit Number.")));
                    } else if (password.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Enter Strong Password.")));
                    } else {
                      realtimeDatabaseApi();
                    }
                  },
                  child: const Text("Submit"))
            ]),
      ),
    );
  }

  Future<void> realtimeDatabaseApi() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("myRealTimeDB").push();

    String? id = ref.key;
    await ref.set({
      "user id": number.text,
      "password": password.text,
      "Id": id,
      "date": dateTimecontroller.text,
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("SuccessFully register !")));
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return viewMydataScreen();
      },
    ));
  }
}
