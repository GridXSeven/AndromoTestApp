import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'catalog/catalog.dart';
import 'simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CatalogBloc>(
          create: (_) => CatalogBloc()..add(CatalogStarted()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Bloc Shopping Cart',
        initialRoute: '/',
        routes: {
          '/': (context) => MyCatalog(),
          //'/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
