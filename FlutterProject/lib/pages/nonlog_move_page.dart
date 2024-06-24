import 'package:flutter/material.dart';
import 'package:project4summamove/components/about_drawer.dart';
import 'package:project4summamove/models/move.dart';
import 'package:project4summamove/pages/inloggen_page.dart';
import 'package:project4summamove/pages/nonlog_moveinstruction_page.dart';
import 'package:project4summamove/services/move_services.dart';

class NonlogMovePage extends StatefulWidget {
  final void Function(bool status) setAutenticatieStatus;
  const NonlogMovePage({super.key, required this.setAutenticatieStatus});

  @override
  State<NonlogMovePage> createState() => _NonlogMovePage();
}

class _NonlogMovePage extends State<NonlogMovePage> {
  late Future<List<Move>> _moves;

  @override
  void initState() {
    _moves = MoveServices().getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Move Page'),
        actions: [_inloggen()],
      ),
      drawer: AboutDrawer(),
      body: FutureBuilder<List<Move>>(
        future: _moves,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          }
          if (snapshot.hasData == false) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          return _moveIndex(snapshot.data!);
        },
      ),
    );
  }

  Widget _moveIndex(List<Move> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon( Icons.settings),
          title: Text(data[index].name),
          trailing: IconButton(
            icon: Icon(Icons.info_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute
                  (builder: (context) => NonlogMoveinstructionPage(
                    move: data[index]),)
              );
            },
          ),
        );
      },
    );
  }

  Widget _inloggen() {
    return IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute
                (builder: (context) => InloggenPage(setAutenticatieStatus: widget.setAutenticatieStatus,))
          );
        },
        icon: Icon(Icons.login)
    );
  }
}
