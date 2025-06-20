import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';
import 'dart:math';
import 'settings_page.dart';
import 'favorite_page.dart';
import 'main_page.dart';

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