import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project4summamove/models/achievement.dart';
import 'package:project4summamove/models/move.dart';
import 'package:project4summamove/services/achievement_services.dart';

class AchievementCreatePage extends StatefulWidget {
  final Move move;
  const AchievementCreatePage({super.key, required this.move,});

  @override
  State<AchievementCreatePage> createState() => _AchievementCreatePageState();
}

class _AchievementCreatePageState extends State<AchievementCreatePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
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
      appBar: AppBar(title: Text('Book - Create'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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


  Widget _amount() {
    return TextFormField(
      controller: _amountController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'amount',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vul amount in';
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
        DateTime now = DateTime.now();
        DateTime datum= new DateTime(now.year, now.month, now.day);
        if(_formKey.currentState!.validate()){
          await AchievementServices().post(
            exerciseID: widget.move.id,
            datum: datum,
            amount: int.parse(_amountController.text),
          );
          // print('test');
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
