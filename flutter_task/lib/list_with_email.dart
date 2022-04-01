import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task/models/sharedmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListWithEmail extends StatefulWidget {
  const ListWithEmail({Key? key}) : super(key: key);

  @override
  State<ListWithEmail> createState() => _ListWithEmailState();
}

class _ListWithEmailState extends State<ListWithEmail> {
  void save() async {
    await init();
    List<String>? liststring = storagedata!.get('email') as List<String>?;
    if (liststring != null) {
      var list = liststring
          .map((email) => Details.fromJson(json.decode(email)))
          .toList();
    }

    List<String>? stringlist = storagedata!.get('phonenumber') as List<String>?;
    if (liststring != null) {
      var list = liststring
          .map((phonenumber) => Details.fromJson(json.decode(phonenumber)))
          .toList();
    }

    storagedata!.setString('email', emailcontroller.text.toString());
    storagedata!.setString('phonenumber', phonecontroller.text.toString());
  }

  SharedPreferences? storagedata;

  Future init() async {
    storagedata = await SharedPreferences.getInstance();
  }

  final phonecontroller = TextEditingController();
  final emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextFormField(
              controller: emailcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: 'Email '),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: TextFormField(
              controller: phonecontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: 'Phone Number'),
            ),
          ),
          FlatButton(
            onPressed: save,
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
          ),
          if (storagedata != null)
            Column(
              children: [
                Text('${storagedata!.get('email')}'),
                Text('${storagedata!.get('phonenumber')}'),
              ],
            )
        ],
      ),
    );
  }
}
