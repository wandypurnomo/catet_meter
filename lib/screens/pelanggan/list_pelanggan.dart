import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'package:pdam/models/paginated_data.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
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
  bool _loadingDetail;

  bool _searchActive;
  TextEditingController _c;

  @override
  void initState() {
    _searchActive = false;
    _loadingDetail = false;
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
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Scaffold(
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
            child: _result(context),
          ),
        ),
        Visibility(
          visible: _loadingDetail,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0,sigmaY: 10.0),
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

  _emptyResult() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Tidak ada data,",textAlign: TextAlign.center,),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              _refreshIndicatorKey.currentState?.show();
            },
          )
        ],
      ),
    );
  }

  _result(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        await _getData(page: 1,refresh: true);
      },
      child: _items.length == 0 ? _emptyResult():_listContent(context),
    );
  }

  _pelangganItem(BuildContext context,Pelanggan p) {
    final _state =
    ScopedModel.of<AppState.State>(context, rebuildOnChange: true);
    return Container(
      child: InkWell(
        onTap: () async{
          print(p.lat);
          print(p.lng);
          
          _launchUrl(double.parse(p.lat), double.parse(p.lng));
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
    print("getting data");
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
    }
  }

  _launchUrl(double lat,double lng) async{
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if(await canLaunch(googleUrl)){
      launch(googleUrl);
    }
   ;
  }
}
