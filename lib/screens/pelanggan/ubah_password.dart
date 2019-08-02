import 'package:flutter/material.dart';

class UbahPassword extends StatefulWidget {
  @override
  _UbahPasswordState createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubah Password"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.teal,
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Column(
          children: <Widget>[
            TextField(
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Password baru"),
            ),
            SizedBox(height: 10.0),
            TextField(
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Ulangi password baru"),
            ),
            SizedBox(height: 10.0),
            OutlineButton(
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
              child: Text(
                "Cari",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
