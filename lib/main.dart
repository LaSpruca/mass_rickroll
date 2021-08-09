import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:core';

import 'package:mass_rickroll/requests.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mass Rickroll',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Mass Rickroll'),
          ),
          body: Container(
            height: 600,

            // set the width of this Container to 100% screen width
            width: double.infinity,

            child: Column(
              // Vertically center the widget inside the column
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ActiveClients(),
                    Card(
                      child: ElevatedButton(
                          child: Text("LAUNCH RICK ROLL"),
                          onPressed: launchRickroll),
                    )
                  ]
                      .map((e) => Padding(
                            padding: EdgeInsets.all(5),
                            child: e,
                          ))
                      .toList(),
                )
              ],
            ),
          )),
    );
  }
}

class ActiveClients extends StatefulWidget {
  const ActiveClients({Key? key}) : super(key: key);

  @override
  _ActiveClientsState createState() => _ActiveClientsState();
}

class _ActiveClientsState extends State<ActiveClients> {
  int onlineClients = 0;
  late Timer t;

  Future<void> updateOnline() async {
    var online = await getOnline();
    setState(() {
      onlineClients = online;
    });
  }

  @override
  void initState() {
    updateOnline();
    t = Timer.periodic(Duration(seconds: 5), (_) {
      print("Getting shit");
      updateOnline();
    });
    super.initState();
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "There are $onlineClients scripts waiting to go brrr",
      textAlign: TextAlign.center,
    );
  }
}
