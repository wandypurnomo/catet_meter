import 'package:flutter/material.dart';
import '../../models/pelanggan.dart';
import 'kirim_data.dart';

class DetailTagihan extends StatelessWidget {
  final DetailPelanggan detail;

  DetailTagihan({this.detail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.supervised_user_circle),
            SizedBox(width: 5.0),
            Text("Detail Pelanggan")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => KirimDataScreen(detail: detail)));
        },
        child: Icon(Icons.add),
        tooltip: "Tambah Data",
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
        child: SingleChildScrollView(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text("Kode"),
                  subtitle: Text(detail.kode),
                ),

                ListTile(
                  title: Text("Nama"),
                  subtitle: Text(detail.nama),
                ),

                ListTile(
                  title: Text("Status"),
                  subtitle: Text(detail.status),
                ),

                ListTile(
                  title: Text("Alamat"),
                  subtitle: Text(detail.alamat),
                ),

                ListTile(
                  title: Text("Kecamatan"),
                  subtitle: Text(detail.kecamatan),
                ),

                ListTile(
                  title: Text("Desa"),
                  subtitle: Text(detail.desa),
                ),

                ListTile(
                  title: Text("Golongan"),
                  subtitle: Text(detail.golongan),
                ),

                ListTile(
                  title: Text("Wilayah Kerja"),
                  subtitle: Text(detail.wilayahKerja),
                ),

                ListTile(
                  title: Text("Tagihan bulan lalu"),
                  subtitle: Text(detail.tagihanBulanLalu),
                ),

                ListTile(
                  title: Text("Tagihan tahun lalu"),
                  subtitle: Text(detail.tagihanTahunLalu),
                ),

                ListTile(
                  title: Text("Angka akhir"),
                  subtitle: Text(detail.angkaTerakhir),
                ),
//
                ListTile(
                  title: Text("Tagihan bayat terakhir"),
                  subtitle: Text(detail.tagihanBayarTerakhir),
                ),

                ListTile(
                  title: Text("Kondisi meteran terakhir"),
                  subtitle: Text(detail.kondisiMeteranTerakhir),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
