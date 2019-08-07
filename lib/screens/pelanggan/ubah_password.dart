import 'package:flutter/material.dart';
import 'package:pdam/utils/helper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pdam/state.dart' as AppState;
class UbahPassword extends StatefulWidget {
  @override
  _UbahPasswordState createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
  final _formKey = GlobalKey<FormState>();
  String _newPassword;
  TextEditingController _c;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _c = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final _state = ScopedModel.of<AppState.State>(context, rebuildOnChange: true);
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
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _c,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Password baru"),
                obscureText: true,
                validator: (x){
                  if(x.isEmpty){
                    return "Password diperlukan";
                  }
                },
                onSaved: (x){
                  setState(() => _newPassword = x);
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Ulangi password baru"),
                obscureText: true,
                validator: (x){
                  if(x.isEmpty){
                    return "Password diperlukan";
                  }

                  if(x != _c.text){
                    return "Password tidak cocok";
                  }
                },
              ),
              SizedBox(height: 10.0),
              OutlineButton(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
                child: Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    _formKey.currentState.save();
                    final x = await _state.resetPassword(newPassword: _newPassword);

                    if(x){
                      showToast("Berhasil");
                      Navigator.pop(context);
                    }else{
                      showToast("Gagal");
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
