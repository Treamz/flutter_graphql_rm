import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql_rm/screens/home_screen.dart';

import 'blocs/home_bloc.dart';
import 'blocs/home_events.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String query = r'''
  query {
    characters(page: 1) {
      results {
        id
        name
        status
      }
    }
  }
''';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<HomeBloc>(
        create: (BuildContext context) => HomeBloc()..add(FetchHomeData(query, variables: const {})),
        child: const HomeScreen(),
      ),
    );
  }
}
