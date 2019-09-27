import 'package:flutter/material.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'package:pdam/models/paginated_data.dart';
import 'package:pdam/models/tagihan.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/pelanggan.dart';
import '../../state.dart' as AppState;
import 'package:pdam/repositories.dart' as repo;
import 'detail_pelanggan.dart';

class ListPelanggan extends StatefulWidget {
  @override
  _ListPelangganState createState() => _ListPelangganState();
}

class _ListPelangganState extends State<ListPelanggan> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  int _currentPage;
  PaginatedData<Pelanggan> _paginatedData;
  List<Pelanggan> _items;

  bool _searchActive;
  TextEditingController _c;

  @override
  void initState() {
    _searchActive = false;
    _c = TextEditingController();
    _currentPage = 1;
    _paginatedData = null;
    _items = [];

    Future.delayed(Duration(microseconds: 200)).then((_) {
      _refreshIndicatorKey.currentState?.show();
    });

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
            await _search(kwd: x);
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
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        await _getData(page: 1,refresh: true);
      },
      child: _listContent(context),
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

  _getData({int page:1,bool refresh:false}) async{
    if(refresh){
      setState(() => _items.clear());
    }
    await repo.getPaginatedPelaggan(page: page).then((PaginatedData<Pelanggan> pp){
      setState(() {
        _paginatedData = pp;
        _items.addAll(_paginatedData.items);
      });
    });
  }

  _search({String kwd}) async{
    if(kwd != null && kwd.length > 3){
      setState(() => _items.clear());
      await repo.pencarian(kwd).then((res){
        _items.addAll(res);
      });
    }
  }

  Widget _listContent(BuildContext context){
    int _itemLength = _paginatedData?.items?.length;

    if(_itemLength != null && _itemLength > 0){
      return IncrementallyLoadingListView(
        hasMore: () => _paginatedData?.hasMorePages,
        loadMoreOffsetFromBottom: 2,
        itemCount: () => _items.length,
        loadMore: () async{
          setState(() => _currentPage++);
          await _getData(page: _currentPage);
        },
        itemBuilder: (context,index){
          final _item = _items[index];
          return _pelangganItem(context, _item);
        },
      );
    }else{
      return _emptyResult();
    }
  }
}
