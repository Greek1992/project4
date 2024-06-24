import 'package:flutter/material.dart';
import 'package:project4summamove/services/authentication_services.dart';

class InloggenPage extends StatefulWidget {
  void Function(bool status) setAutenticatieStatus;
  InloggenPage({super.key, required this.setAutenticatieStatus});

  @override
  State<InloggenPage> createState() => _InloggenPageState();
}

class _InloggenPageState extends State<InloggenPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inloggen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _logo(),
                SizedBox(height: 20,),
                _email(),
                SizedBox(height: 20,),
                _password(),
                SizedBox(height: 20,),
                _submit(),
              ],
            ),
          ),
        ));
  }

  Widget _logo() {
    return SizedBox(
        height: 150, child: Image.asset('assets/images/logoSummaMove.gif'));
  }

  Widget _email() {
    return TextFormField(
      controller: _emailTextController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          border: OutlineInputBorder(), hintText: 'email adres'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vul email adres in';
        }
      },
    );
  }

  Widget _password() {
    return TextFormField(
      controller: _passwordController,
      textInputAction: TextInputAction.next,
      obscureText: true,
      decoration:
      InputDecoration(border: OutlineInputBorder(), hintText: 'password'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vul password in';
        }
      },
    );
  }

  Widget _submit() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          try {
            final result = await AuthenticationServices.login(
                _emailTextController.text,
                _passwordController.text);
            print(result);
            widget.setAutenticatieStatus(result);
            Navigator.pop(context);
          }
          catch (e) {
            widget.setAutenticatieStatus(false);
          }
        }
      },
      child: Text('Inloggen'),
    );
  }
}
