import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      title: 'online json data',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String url = "https://gorest.co.in/public-api/users";
  List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      var convertjson = json.decode(response.body);
      data = convertjson['data'];
    });
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    return Scaffold(
      appBar: AppBar(
        title: Text('fetch online json data'),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(data[index]['name']),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
