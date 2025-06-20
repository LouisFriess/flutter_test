import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    

    return Scaffold(backgroundColor: appState.backgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 300,
            height: 400,
            child: Stack(
            alignment: Alignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.lightGreen);
                  appState.setCardColor(Colors.lightGreen[700]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                ),
                child: Text(' Greene'),
              ),
              Positioned(
                top: 100,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.blue);
                  appState.setCardColor(Colors.blue[900]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text('Blue'),
              ),
              ),
              Positioned(
                bottom: 100,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.amber);
                  appState.setCardColor(Colors.amber[700]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                ),
                child: Text('Amber'),
              ),
              ),
              Positioned(
                right: 5,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.lime);
                  appState.setCardColor(Colors.lime[700]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lime,
                  foregroundColor: Colors.white,
                ),
                child: Text(' Lime '),
              ),
              ),
              Positioned(
                top: 100,
                right: 5,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.teal);
                  appState.setCardColor(Colors.teal[900]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                child: Text(' Teal '),
              ),
              ),
              Positioned(
                bottom: 100,
                right: 5,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.orange);
                  appState.setCardColor(Colors.orange[900]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: Text('Orange'),
              ),
              ),
              Positioned(
                left: 5,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.green);
                  appState.setCardColor(Colors.green[900]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text('Green'),
              ),
              ),
              Positioned(
                bottom: 100,
                left: 5,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.yellow);
                  appState.setCardColor(Colors.yellow[900]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.white,
                ),
                child: Text('Yellow'),
              ),
              ),
              Positioned(
                top: 100,
                left: 5,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.cyanAccent);
                  appState.setCardColor(Colors.cyanAccent[700]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text(' Cyan '),
              ),
              ),
              Positioned(
                top: 30,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.blueGrey);
                  appState.setCardColor(Colors.blueGrey[900]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                ),
                child: Text(' Navy '),
              ),
              ),
              Positioned(
                top: 30,
                left: 5,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.brown);
                  appState.setCardColor(Colors.brown[900]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                ),
                child: Text(' Brown'),
              ),
              ),
              Positioned(
                top: 30,
                right: 5,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.grey);
                  appState.setCardColor(Colors.grey[800]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                ),
                child: Text(' Grey '),
              ),
              ),
              Positioned(
                bottom: 30,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.pink);
                  appState.setCardColor(Colors.pink[900]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
                child: Text(' Pink '),
              ),
              ),
              Positioned(
                bottom: 30,
                left: 5,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.red);
                  appState.setCardColor(Colors.red[900]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text(' Red  '),
              ),
              ),
              Positioned(
                bottom: 30,
                right: 5,
                child: ElevatedButton(
                onPressed: () {
                  appState.setBackgroundColor(Colors.purple);
                  appState.setCardColor(Colors.purple[900]!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
                child: Text(' Purple '),
              ),
              ),
            ],
          ),
          ),
          SizedBox(
            height: 150,
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                appState.setBackgroundColor(appState.backColorRandom());
                appState.setCardColor(appState.backColorRandom());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 13, 59, 49),
                foregroundColor: Colors.white,
              ),
              child: Text('Random Color'),
            ),
          ),
        ],
      ),
    );
  }
}