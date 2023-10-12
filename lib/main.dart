import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/provider_manager.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...ProviderManager.providers],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter HUTECH CLASSROOM Home Page'),
        routes: {...RouteManager.routes},
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final UserStore _userStore = UserStore();

  void _incrementCounter() {
    setState(() {
      _counter += 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Observer(builder: (context) {
                return Text(_userStore.user.userName ?? 'Not thing here');
              }),
              FloatingActionButton(
                heroTag: "Reset Store",
                onPressed: () {
                  _userStore.resetValue();
                },
                child: const Icon(Icons.restore),
              ),
              FloatingActionButton(
                heroTag: "Login page",
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: const Icon(Icons.energy_savings_leaf),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "Increment",
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ));
  }
}
