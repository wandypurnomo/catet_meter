import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pdam/state.dart' as AppState;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _fk = GlobalKey<FormState>();
  String _username;
  String _password;

  @override
  Widget build(BuildContext context) {
    final _state = ScopedModel.of<AppState.State>(context, rebuildOnChange: true);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.teal,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _fk,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  Image(
                    image: NetworkImage("https://placehold.it/100"),
                  ),
                  SizedBox(height: 110.0),
                  TextFormField(
                    onSaved: (x){
                      setState(() => _username = x);
                    },
                    decoration: InputDecoration(
                      hintText: "Masukan username anda",
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    onSaved: (x){
                      setState(() => _password = x);
                    },
                    decoration: InputDecoration(
                      hintText: "Masukan password anda",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                    ),
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    height: 54.0,
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      child: Text(
                        "Masuk",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async{
                        if(_fk.currentState.validate()){
                          _fk.currentState.save();
                          await _state.login(username: _username, password: _password);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
