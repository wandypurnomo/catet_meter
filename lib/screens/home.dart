import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdam/models/pelanggan.dart';
import 'package:pdam/screens/pelanggan/kirim_data.dart';
import 'package:pdam/screens/pelanggan/ubah_password.dart';
import 'package:pdam/utils/helper.dart';
import 'package:pdam/utils/media_process.dart' as mp;
import 'package:scoped_model/scoped_model.dart';

import '../state.dart' as AppState;
import 'pelanggan/detail_pelanggan.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _camera = FlutterMobileVision.CAMERA_BACK;
  bool _searchLoading;
  bool _autoFocus = true;
  bool _torch = false;
  bool _multiple = false;
  bool _waitTap = false;
  bool _showText = true;
  Size _preview;

  TextEditingController _c;

  @override
  void initState() {
    _searchLoading = false;
    super.initState();
    _c = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    final _state = ScopedModel.of<AppState.State>(context, rebuildOnChange: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Catat Meter"),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Text("Hallo, ${_state.model.user.nama}"),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          await mp.pickImage(ImageSource.camera);
                        },
                        child: Text("Test Camera"),
                      ),
                      FlatButton(
                        onPressed: () async {
                          final pos = await Geolocator().getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high,
                          );
                          showToast(
                            "lat: ${pos.latitude}, lng: ${pos.longitude}",
                          );
                        },
                        child: Text("Test Location"),
                      ),
                      FlatButton(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UbahPassword(),),);
                        },
                        child: Text("Ubah Password"),
                      ),
                      FlatButton(
                        onPressed: () {
                          showToast("Ubah Foto");
                        },
                        child: Text("Ubah Foto"),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Icon(
          Icons.settings,
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 110.0,
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Ink(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "pelanggan");
                        },
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.supervised_user_circle,
                                size: 50.0,
                                color: Colors.blue,
                              ),
                              Text(
                                "Pelanggan",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Ink(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                color: Colors.blue,
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    TextField(
                                      style: TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.number,
                                      controller: _c,
                                    ),
                                    OutlineButton(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child:Text(
                                          _searchLoading ? "Memuat...":"Cari",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      onPressed: _searchLoading ? null :() async {
                                        setState(() => _searchLoading = true);
                                        DetailPelanggan d = await _state.getDetailPelanggan(kode: _c.text);
                                        if (d != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  KirimDataScreen(
                                                detail: d,
                                              ),
                                            ),
                                          ).then((_){
                                            Navigator.pop(context);
                                          });
                                        } else {
                                          showToast("Data tidak ditemukan");
                                          Navigator.pop(context);
                                        }
                                        setState(() => _searchLoading = false);
                                      },
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.search,
                                size: 50.0,
                                color: Colors.blue,
                              ),
                              Text(
                                "Cari Kode",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Ink(
                      child: InkWell(
                        onTap: () async {
                          final x = await FlutterMobileVision.scan(
                              autoFocus: _autoFocus,
                              camera: _camera,
                              flash: _torch,
                              fps: 15.0,
                              waitTap: _waitTap,
                              multiple: _multiple,
                              preview: _preview,
                              showText: _showText,
                              formats: Barcode.ALL_FORMATS);

                          final data = x.first.displayValue;

                          DetailPelanggan d = await _state.getDetailPelanggan(kode: data);

                          showToast("Memuat data...");

                          if (d != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPelangganScreen(
                                  detail: d,
                                ),
                              ),
                            );
                          }
                        },
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.camera_alt,
                                size: 50.0,
                                color: Colors.blue,
                              ),
                              Text(
                                "Scan",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Ink(
                      child: InkWell(
                        onTap: () async {
                          await _state.logout();
                        },
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.exit_to_app,
                                size: 50.0,
                                color: Colors.blue,
                              ),
                              Text(
                                "Keluar",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 110.0,
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
//                  Expanded(
//                    child: Ink(
//                      child: InkWell(
//                        onTap: () {
//                          Navigator.pushNamed(context, "pelanggan");
//                        },
//                        child: Card(
//                          child: Column(
//                            mainAxisSize: MainAxisSize.max,
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Text(
//                                "${_state.model.user.totalPelanggan}",
//                                style: TextStyle(
//                                  color: Colors.blue,
//                                  fontSize: 30.0,
//                                ),
//                              ),
//                              Text(
//                                "Total Pelanggan",
//                                style: TextStyle(
//                                  color: Colors.blue,
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
                  Expanded(
                    child: Ink(
                      child: InkWell(
                        onTap: () {},
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "${_state.model.user.telahDicatat}",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30.0,
                                ),
                              ),
                              Text(
                                "Telah Dicatat",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
//            Container(
//              height: 110.0,
//              padding: EdgeInsets.all(5.0),
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: Ink(
//                      child: InkWell(
//                        onTap: () {},
//                        child: Card(
//                          child: Column(
//                            mainAxisSize: MainAxisSize.max,
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Text(
//                                "${_state.model.user.progressCatat}",
//                                style: TextStyle(
//                                  color: Colors.blue,
//                                  fontSize: 30.0,
//                                ),
//                              ),
//                              Text(
//                                "Progress Catat",
//                                style: TextStyle(
//                                  color: Colors.blue,
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}
