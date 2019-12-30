import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdam/models/pelanggan.dart';
import 'package:pdam/state.dart' as AppState;
import 'package:pdam/utils/helper.dart';
import 'package:pdam/utils/media_process.dart' as mp;
import 'package:scoped_model/scoped_model.dart';

class KirimDataScreen extends StatefulWidget {
  final DetailPelanggan detail;

  KirimDataScreen({this.detail});

  @override
  _KirimDataScreenState createState() => _KirimDataScreenState();
}

class _KirimDataScreenState extends State<KirimDataScreen> {
  final _formKey = GlobalKey<FormState>();
  String _angkaAkhir;
  ImageProvider _img = NetworkImage("https://placehold.it/100");
  String _status = "normal";
  File _imageFile;
  double _lat;
  double _lng;
  bool _loading;

  _fetchLocation() async {
    final pos = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _lat = pos.latitude;
      _lng = pos.longitude;
    });

    showToast("Lokasi didapatkan");
  }

  @override
  void initState() {
    _loading = false;
    super.initState();
    _fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    final _state =
        ScopedModel.of<AppState.State>(context, rebuildOnChange: true);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Icon(Icons.cloud_upload),
                SizedBox(width: 5.0),
                Text("Kirim Data - ${widget.detail.nama}")
              ],
            ),
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
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Masukan username anda",
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                    ),
                    enabled: false,
                    initialValue: widget.detail.nama,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Masukan kode anda",
                      prefixIcon: Icon(
                        Icons.dialpad,
                        color: Colors.white,
                      ),
                    ),
                    enabled: false,
                    initialValue: widget.detail.kode,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    onSaved: (x) {},
                    decoration: InputDecoration(
                      hintText: "Masukan status anda",
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                    ),
                    enabled: false,
                    initialValue: widget.detail.status,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Stand awal",
                      prefixIcon: Icon(
                        Icons.first_page,
                        color: Colors.white,
                      ),
                    ),
                    initialValue: widget.detail.angkaTerakhir,
                    enabled: false,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    onSaved: (x) {
                      setState(() => _angkaAkhir = x);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Masukan stand akhir",
                      prefixIcon: Icon(
                        Icons.last_page,
                        color: Colors.white,
                      ),
                    ),
                    validator: (x) {
                      if (x.isEmpty) {
                        return "Angka akhir diperlukan";
                      }

                      if (_imageFile == null) {
                        return "Foto diperlukan";
                      }

//                      final awal =
//                          int.parse(widget.detail.angkaTerakhir ?? "0");
//                      if (int.parse(x) <= awal) {
//                        return "stand akhir lebih kecil dari stand awal";
//                      }

                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                      style: BorderStyle.solid,
                    )),
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: [
                        DropdownMenuItem<String>(
                          value: "Baik",
                          child: Text("BAIK",
                              style: TextStyle(color: Colors.black45)),
                        ),
                        DropdownMenuItem<String>(
                          value: "Tidak Baik",
                          child: Text("TIDAK BAIK",
                              style: TextStyle(color: Colors.black45)),
                        ),
                        DropdownMenuItem<String>(
                          value: "Buram",
                          child: Text("BURAM",
                              style: TextStyle(color: Colors.black45)),
                        ),
                        DropdownMenuItem<String>(
                          value: "Tertanam",
                          child: Text("TERTANAM",
                              style: TextStyle(color: Colors.black45)),
                        ),
                        DropdownMenuItem<String>(
                          value: "Terkunci",
                          child: Text("TERKUNCI",
                              style: TextStyle(color: Colors.black45)),
                        ),
                        DropdownMenuItem<String>(
                          value: "Mati",
                          child: Text("MATI",
                              style: TextStyle(color: Colors.black45)),
                        ),
                        DropdownMenuItem<String>(
                          value: "Lain2",
                          child: Text("LAINYA",
                              style: TextStyle(color: Colors.black45)),
                        ),
                      ],
                      value: _status,
                      onChanged: (x) {
                        setState(() => _status = x);
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Center(
                      child: Center(
                        child: Image(
                          image: _img,
                          width: 200.0,
                          height: 200.0,
                        ),
                      ),
                    ),
                  ),
                  OutlineButton(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    child: Text(
                      "Ambil Foto Dari Kamera",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      File f = await mp.pickImage(
                        ImageSource.camera,
                        withCropper: true,
                      );
                      setState(() => _img = FileImage(f));
                      setState(() => _imageFile = f);
                    },
                  ),
                  OutlineButton(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    child: Text(
                      "Ambil Foto Dari Gallery",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      File f = await mp.pickImage(
                        ImageSource.gallery,
                        withCropper: true,
                      );
                      setState(() => _img = FileImage(f));
                      setState(() => _imageFile = f);
                    },
                  ),
                  OutlineButton(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    child: Text(
                      "KIRIM",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_imageFile == null) {
                        showToast("Gambar diperlukan");
                        return;
                      }
                      if (_formKey.currentState.validate()) {
                        setState(() => _loading = true);
                        _formKey.currentState.save();
                        final bytes = await _imageFile.readAsBytes();
                        InputData input = InputData();
                        input.kode = widget.detail.kode;
                        input.angkaAwal = widget.detail.angkaTerakhir;
                        input.angkaAkhir = _angkaAkhir;
                        input.statusMeteran = _status;
                        input.fotoMeteran = base64Encode(bytes);
                        input.latitude = _lat.toString();
                        input.longitude = _lng.toString();
                        await _state.inputDataMeteran(data: input);
                        setState(() => _loading = false);
                        showToast("Data terkirim.");
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: _loading,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
