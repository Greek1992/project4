import 'package:flutter/material.dart';
import 'package:project4summamove/models/achievement.dart';
import 'package:project4summamove/models/move.dart';
import 'package:project4summamove/pages/achievement_create_page.dart';
import 'package:project4summamove/pages/achievement_update_page.dart';
import 'package:project4summamove/services/achievement_services.dart';
import 'package:project4summamove/services/move_services.dart';

import '../components/about_drawer.dart';

class AchievementPage extends StatefulWidget {
  final Move move;

  const AchievementPage({super.key, required this.move});

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  late Future<List<Achievement>> _achievements;

  @override
  void initState() {
    _achievements = AchievementServices().getAll(moveId: widget.move.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Move - details'),
      ),
      floatingActionButton: _createAchievement(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width- 25,
            child: Column(
              children: [
                Text(
                  'Movedetails',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.move.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'instructie Nederlands:',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.move.instructieNL,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'instructie Engels:',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.move.instructionEN,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(child: _achievementsIndex()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _achievementsIndex() {
    return FutureBuilder(
      future: _achievements,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.hasData == false) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return ListTile(
                leading: Icon(Icons.flag),
                title: Text('Amount of times: '+ snapshot.data![index].amount.toString() +'\nDate: '+snapshot.data![index].datum.toString()),

                trailing: SizedBox(
                  width: 96,
                  child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.update,
                            color: Colors.black,
                          ),
                          onPressed: () async{
                            _updateAchievement(move: widget.move, achievement: snapshot.data![index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () async {

                            await AchievementServices().delete(achievementId: snapshot
                                .data![index].id);
                            _achievements = AchievementServices().getAll(moveId: widget.move.id);
                            setState(() {});


                          },
                        ),
                      ]
                  ),
                )
            );
          },
        );
      },
    );
  }



  _updateAchievement({required Move move, required Achievement achievement}) async {
    //print(achievement.id);
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AchievementUpdatePage(achievement: achievement, move: move,),
        )
    );
    _achievements = AchievementServices().getAll(moveId: widget.move.id);
    setState(() {});
  }

  Widget _createAchievement() {
    return FloatingActionButton(
      child: Icon(
        Icons.add,
        color: Colors.red,
      ),
      onPressed: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AchievementCreatePage(
                      move: widget.move),
            )
        );
        _achievements = AchievementServices().getAll(moveId: widget.move.id);
        setState(() {});
      },
    );
  }
  

}
