
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/home_bloc.dart';
import '../blocs/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List data = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (BuildContext context, HomeStates state) {
        if (state is Loading) {
          return Scaffold(
            appBar: _AppBar(),
            body: const LinearProgressIndicator(),
          );
        } else if (state is LoadDataFail) {
          return Scaffold(
            appBar: _AppBar(),
            body: Center(child: Text(state.error)),
          );
        } else {
          data = (state as LoadDataSuccess).data['characters']['results'];
          return Scaffold(
            appBar: _AppBar(),
            body: _HomeBody(data: data,),
          );
        }
      },
    );
  }


  @override
  void dispose() {
    super.dispose();
  }
}

class _HomeBody extends StatelessWidget {
  final List data;
  const _HomeBody({super.key,required this.data});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        var item = data[index];
        return Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Text(item['id']),
            title: Text(item['name']),
            trailing: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: item['status'] == 'Dead'
                    ? Colors.red.withOpacity(0.3)
                    : item['status'] == 'Alive'
                    ? Colors.green.withOpacity(0.3)
                    : Colors.amber.withOpacity(0.3),
                borderRadius: BorderRadius.circular(32.0),
              ),
              child: Text(
                item['status'],
                style: TextStyle(
                    color: item['status'] == 'Dead'
                        ? Colors.red
                        : item['status'] == 'Alive'
                        ? Colors.green
                        : Colors.amber),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AppBar extends AppBar {
  _AppBar():super(
    title: const Text('GraphQL Demo'),
  );
}

