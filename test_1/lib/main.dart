import 'dart:collection';
import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(), // Creates the state
      child: MaterialApp(
        // About the theme
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        ),
        home: MyHomePage(), // Specifies the home page
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  // String generator
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890 ';
  var current = WordPair.random();
  void genRandWordPair() {
    current = WordPair(
        generateRandomString(2 + Random().nextInt(2), space: true),
        generateRandomString(2 + Random().nextInt(3)));
    notifyListeners();
  }

  String generateRandomString(int length, {bool space = false}) {
    var res = String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(Random().nextInt(_chars.length))));
    if (space) res += ' ';
    return res;
  }

  // Favorites
  var favs = HashSet<WordPair>();
  void toggleLike() {
    favs.contains(current) ? favs.remove(current) : favs.add(current);
    notifyListeners();
  }

  bool isCurrLiked() {
    return favs.contains(current);
  }

  bool isLiked(WordPair wp) {
    return favs.contains(wp);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedPage = 0;
  Widget getSelectedPage() {
    switch (selectedPage) {
      case 0:
        return GeneratorPage();
      case 1:
        return FavoritesPage();
      case 2:
        return TaskPage();
      default:
        throw UnimplementedError("No widget for $selectedPage");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Scaffold(
              body: Row(
                children: [
                  NavigationRail(
                    extended: constraints.maxWidth >= 600, // Responsive!
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                          icon: Icon(Icons.favorite), label: Text('Favorites')),
                      NavigationRailDestination(
                          icon: Icon(Icons.ac_unit), label: Text('Task')),
                    ],
                    selectedIndex: selectedPage,
                    onDestinationSelected: (val) => setState(() {
                      selectedPage = val;
                    }),
                  ),
                  Expanded(
                      child: Container(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: getSelectedPage()))
                ],
              ),
            ));
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();
    var wordPairToDisplay = state.current;
    var strToDisplay = wordPairToDisplay.asString;
    var likeButtonIcon = state.isLiked(wordPairToDisplay)
        ? Icons.favorite
        : Icons.favorite_border_rounded;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextCard(str: strToDisplay),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
                onPressed: () => state.toggleLike(),
                icon: Icon(likeButtonIcon),
                label: Text('Like')),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => state.genRandWordPair(),
              child: Text("Gen"),
            )
          ],
        )
      ],
    );
  }
}

class TextCard extends StatelessWidget {
  const TextCard({
    super.key,
    required this.str,
  });

  final String str;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);

    return Card(
      color: theme.colorScheme.primary,
      child: Center(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text(
              str,
              style: textStyle,
              semanticsLabel: "yoooo",
            )),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();
    var favs = state.favs;

    if (favs.isEmpty) {
      return Center(
        child: Text("No favorites yet!"),
      );
    }

    return ListView.builder(
      itemCount: favs.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(favs.elementAt(index).asString),
      ),
    );
  }
}

class TaskPage extends StatefulWidget {
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var openInputPressed = false;

  String email = "";

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        email == "" ? SizedBox.shrink() : Text(email),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              var emailFromDialog = await _emailDialogBuilder(context);
              if (emailFromDialog == null) {
                print("User canceled");
                return;
              }
              setState(() {
                email = emailFromDialog;
              });
            },
            child: const Text("Enter Email"),
          ),
        ),
      ],
    ));
  }
}

Future<String?> _emailDialogBuilder(BuildContext context) async {
  var email = "";
  bool validateInput() {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  return showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                title: Text("Email Input"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        child: TextField(
                          onChanged: (val) {
                            email = val;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!validateInput()) {
                        print("User entered invalid mail");
                        return;
                      }
                      Navigator.of(context).pop(email);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            validateInput()
                                ? Theme.of(context).colorScheme.onPrimary
                                : Colors.grey)),
                    child: Text("Send"),
                  )
                ]),
          ));
}
