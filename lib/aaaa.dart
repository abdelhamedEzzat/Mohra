import 'package:flutter/material.dart';

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: MaterialButton(
            onPressed: () async {
              // await FirebaseFirestore.instance
              //     .collection('users')
              //     .doc("1")
              //     .collection("companys")
              //     .doc("1")
              //     .set(
              //   {
              //     "3": {"a": "1", "b": "4"}
              //   },
              //   // SetOptions(merge: true),
              // );
            },
            child: Text("dsfdsfdsfs"),
          ),
        ),
      ),
    );
  }
}
