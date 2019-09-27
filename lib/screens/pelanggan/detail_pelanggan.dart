import 'package:flutter/material.dart';
import 'package:pdam/models/tagihan.dart';
import '../../models/pelanggan.dart';
import 'kirim_data.dart';

class DetailPelangganScreen extends StatefulWidget {
  final DetailPelanggan detail;

  DetailPelangganScreen({@required this.detail});

  @override
  _DetailPelangganScreenState createState() => _DetailPelangganScreenState();
}

class _DetailPelangganScreenState extends State<DetailPelangganScreen>
    with SingleTickerProviderStateMixin {
  TabController _c;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _c = TabController(length: 2, vsync: this);
  }

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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      KirimDataScreen(detail: widget.detail)));
        },
        child: Icon(Icons.add),
        tooltip: "Tambah Data",
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Text("Kode"),
                subtitle: Text(widget.detail.kode ?? "-"),
              ),

              ListTile(
                title: Text("Nama"),
                subtitle: Text(widget.detail.nama ?? "-"),
              ),

              ListTile(
                title: Text("Status"),
                subtitle: Text(widget.detail.status ?? "-"),
              ),

              ListTile(
                title: Text("Alamat"),
                subtitle: Text(widget.detail.alamat ?? "-"),
              ),

              ListTile(
                title: Text("Kecamatan"),
                subtitle: Text(widget.detail.kecamatan ?? "-"),
              ),

              ListTile(
                title: Text("Desa"),
                subtitle: Text(widget.detail.desa ?? "-"),
              ),

              ListTile(
                title: Text("Golongan"),
                subtitle: Text(widget.detail.golongan ?? "-"),
              ),

              ListTile(
                title: Text("Wilayah Kerja"),
                subtitle: Text(widget.detail.wilayahKerja ?? "-"),
              ),

              ListTile(
                title: Text("Tagihan bulan lalu"),
                subtitle: Text(widget.detail.tagihanBulanLalu ?? "-"),
              ),

              ListTile(
                title: Text("Tagihan tahun lalu"),
                subtitle: Text(widget.detail.tagihanTahunLalu ?? "-"),
              ),

              ListTile(
                title: Text("Angka akhir"),
                subtitle: Text(widget.detail.angkaTerakhir ?? "-"),
              ),
//
              ListTile(
                title: Text("Kondisi meteran terakhir"),
                subtitle: Text(widget.detail.kondisiMeteranTerakhir ?? "-"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
