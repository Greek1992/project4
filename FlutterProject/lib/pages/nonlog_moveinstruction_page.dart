import 'package:flutter/material.dart';
import 'package:project4summamove/components/about_drawer.dart';
import 'package:project4summamove/models/move.dart';
import 'package:project4summamove/services/move_services.dart';

class NonlogMoveinstructionPage extends StatelessWidget {
  final Move move;
  const NonlogMoveinstructionPage({super.key, required this.move});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Move - details'),),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width- 25,
            child: Column(
              children: [
                Text('Movedetails', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text(move.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text('instructie Nederlands:', style: TextStyle(fontSize: 20),),
                Text(move.instructieNL, style: TextStyle(fontSize: 20),),
                SizedBox(height: 20,),
                Text('instructie Engels:', style: TextStyle(fontSize: 20),),
                Text(move.instructionEN, style: TextStyle(fontSize: 20),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/*
class NonlogMoveinstructionPage extends StatefulWidget {
  final void Function(bool status) setAutenticatieStatus;
  final Move move;
  const NonlogMoveinstructionPage({super.key, required this.setAutenticatieStatus, required this.move});

  @override
  State<NonlogMoveinstructionPage> createState() => _NonlogMoveinstructionPage();
}

class _NonlogMoveinstructionPage extends State<NonlogMoveinstructionPage> {
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
        actions: [_uitloggen()],
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
        );
      },
    );
  }

  Widget _uitloggen() {
    return IconButton(
        onPressed: () {
          widget.setAutenticatieStatus(false);
        },
        icon: Icon(Icons.logout)
    );
  }
}
*/

