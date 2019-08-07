import 'package:flutter/material.dart';
import 'package:pdam/models/tagihan.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/pelanggan.dart';
import '../../state.dart' as AppState;
import 'detail_pelanggan.dart';

class ListPelanggan extends StatefulWidget {
  @override
  _ListPelangganState createState() => _ListPelangganState();
}

class _ListPelangganState extends State<ListPelanggan> {
  bool _searchActive;
  TextEditingController _c;

  @override
  void initState() {
    _searchActive = false;
    _c = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _state =
        ScopedModel.of<AppState.State>(context, rebuildOnChange: true);

    return Scaffold(
      appBar: AppBar(
        title: _searchActive ? TextField(
          onChanged: (x)async{
            await _state.searchPelanggan(x);
          },
        ):Row(
          children: <Widget>[
            Icon(Icons.supervised_user_circle),
            SizedBox(width: 5.0),
            Text("Pelanggan")
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() => _searchActive = !_searchActive);
            },
          ),
        ],
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
        child: _state.model.pelanggan.length == 0
            ? _emptyResult()
            : _result(context),
      ),
    );
  }

  _emptyResult() {
    return ListView(
      children: <Widget>[
        Card(
          child: Center(
            child: Text("Tidak ada data"),
          ),
        ),
      ],
    );
  }

  _result(BuildContext context) {
    final _state =
        ScopedModel.of<AppState.State>(context, rebuildOnChange: true);
    return RefreshIndicator(
      onRefresh: () async {
        await _state.getPelanggan();
      },
      child: ListView.builder(
        itemBuilder: (context, index) {
          final pel = _state.model.pelanggan[index];
          return _pelangganItem(context,pel);
        },
        itemCount: _state.model.pelanggan.length,
      ),
    );
  }

  _pelangganItem(BuildContext context,Pelanggan p) {
    final _state =
    ScopedModel.of<AppState.State>(context, rebuildOnChange: true);
    return Container(
      child: InkWell(
        onTap: () async{
          DetailPelanggan d =
          await _state.getDetailPelanggan(kode: p.kode);

          DetailTagihan t = await _state.getDetailTagihan(kode: p.kode);

          if (d != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPelangganScreen(
                  detail: d,
                  tagihan: t,
                ),
              ),
            );
          }
        },
        child: Card(
          child: ListTile(
            title: Text(p.nama),
            subtitle: Text(p.status),
            trailing: Text(p.kode),
          ),
        ),
      ),
    );
  }
}
