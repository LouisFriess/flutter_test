import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';
import 'dart:math';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MyAppState(),
      child: MyApp(),
    ),
  );
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>{};
  Color backgroundColor = Colors.green;
  Color cardColor = Colors.green[900]!;

  final List<Color> colors = [
    Colors.lightGreen,
    Colors.lightGreen[700]!,
    Colors.blue,
    Colors.blue[900]!,
    Colors.amber,
    Colors.amber[700]!,
    Colors.lime,
    Colors.lime[700]!,
    Colors.teal,
    Colors.teal[900]!,
    Colors.orange,
    Colors.orange[900]!,
    Colors.green,
    Colors.green[900]!,
    Colors.yellow,
    Colors.yellow[900]!,
    Colors.cyanAccent,
    Colors.cyanAccent[700]!,
    Colors.blueGrey,
    Colors.blueGrey[900]!,
    Colors.brown,
    Colors.brown[900]!,
    Colors.grey,
    Colors.grey[800]!,
    Colors.pink,
    Colors.pink[900]!,
    Colors.red,
    Colors.red[900]!,
    Colors.purple,
    Colors.purple[900]!,
  ];

  Color backColorRandom() {
    return colors[Random().nextInt(colors.length)];
  }

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void clearFavorites() {
    favorites.clear();
    notifyListeners();
  }

  void setBackgroundColor(Color color) {
    backgroundColor = color;
    notifyListeners();
  }

  void setCardColor(Color color) {
    cardColor = color;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings),
                      label: Text('Settings'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Consumer<MyAppState>(
                  builder: (context, appState, child) {
                    Widget page;
                    switch (selectedIndex) {
                      case 0:
                        page = GeneratorPage();
                        break;
                      case 1:
                        page = FavoritesPage();
                        break;
                      case 2:
                        page = SettingsPage();
                        break;
                      default:
                        throw UnimplementedError('no widget for $selectedIndex');
                    }
                    return Container(
                      color: appState.backgroundColor,
                      child: page,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          BigCard(pair: pair, color: appState.cardColor),
          SizedBox(height: 10),
          ElevatedButton.icon(
            label: Text("Clear Favorites"),
            icon: Icon(Icons.delete),
            onPressed: () {
              appState.clearFavorites();
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}

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
                  backgroundColor: Colors.black,
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


class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
    required this.color,
  });

  final WordPair pair;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}