import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pdam/state.dart' as AppState;

import 'home.dart';
import 'login.dart';
import 'pelanggan/kirim_data.dart';
import 'pelanggan/list_pelanggan.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _state =
        ScopedModel.of<AppState.State>(context, rebuildOnChange: true);

    return MaterialApp(
      title: "Catat Meteran PDAM",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blue,
          elevation: 0.0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 2.0,
            ),
          ),
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 2.0,
            ),
          ),

          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 2.0,
            ),
          ),

        ),
        hintColor: Colors.white,
      ),
      routes: {
        "pelanggan": (context) => ListPelanggan(),
        "kirim-data":(context) => KirimDataScreen()
      },
//      home: HomeScreen(),
      home: _state.model.isLoggedIn ? HomeScreen() : LoginScreen(),
    );
  }
}
