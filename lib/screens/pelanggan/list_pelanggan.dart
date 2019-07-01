import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/pelanggan.dart';
import '../../state.dart' as AppState;

class ListPelanggan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _state =
        ScopedModel.of<AppState.State>(context, rebuildOnChange: true);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.supervised_user_circle),
            SizedBox(width: 5.0),
            Text("Pelanggan")
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
      onRefresh: () async{
        await _state.getPelanggan();
      },
      child: ListView.builder(
        itemBuilder: (context, index) {
          final pel = _state.model.pelanggan[index];
          return _pelangganItem(pel);
        },
        itemCount: _state.model.pelanggan.length,
      ),
    );
  }

  _pelangganItem(Pelanggan p) {
    return Container(
      child: Card(
        child: ListTile(
          title: Text(p.nama),
          subtitle: Text(p.status),
          trailing: Text(p.kode),
        ),
      ),
    );
  }
}
