import 'package:flutter/material.dart';
import 'package:project4summamove/models/achievement.dart';
import 'package:project4summamove/models/move.dart';
import 'package:project4summamove/services/achievement_services.dart';
import 'package:intl/intl.dart';

class AchievementUpdatePage extends StatefulWidget {
  final Move move;
  final Achievement achievement;

  const AchievementUpdatePage({
    super.key,
    required this.move,
    required this.achievement
  });

  @override
  State<AchievementUpdatePage> createState() => _AchievementUpdatePageState();
}

class _AchievementUpdatePageState extends State<AchievementUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    _amountController.text = widget.achievement.amount.toString();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book - Update'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _move(),
                SizedBox(height: 20),
                _datum(),
                SizedBox(height: 20),
                _amount(),
                SizedBox(height: 20),
                _saveCancelButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _move() {
    return Text(widget.move.name);
  }

  Widget _datum() {
    return Text(widget.achievement.datum);

  }

  Widget _amount() {
    return TextFormField(
      controller: _amountController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'year',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vul year in';
        }
        return null;
      },
    );
  }

  Widget _saveCancelButton() {
    return Row(
      children: [
        _storeButton(),
        _cancelButton(),
      ],
    );
  }

  Widget _storeButton() {
    return ElevatedButton(
      onPressed: () async {
        if(_formKey.currentState!.validate()){
          await AchievementServices().update(
            achievementId: widget.achievement.id,
            exerciseID: widget.achievement.exerciseID,
            userID: widget.achievement.userID,
            datum: widget.achievement.datum,
            amount: int.parse(_amountController.text),
          );
          if(mounted){
            Navigator.pop(context);
          }
        }
      },
      child: Text('Bewaar'),
    );
  }

  Widget _cancelButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Annuleer'),
    );
  }
}
