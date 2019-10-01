import 'package:flutter/widgets.dart';
import 'package:pdam/utils/helper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/tagihan.dart';
import 'repositories.dart' as repo;
import 'models/pelanggan.dart';
import 'models/user.dart';
import 'utils/prefs.dart' as prefs;

class State extends Model{
  final model = AppModel.init();

  Future<void> init() async{
    await profile();
  }

  Future<void> profile() async{
    await repo.profile().then((User u){
      if(u != null){
        model.user = u;
        model.isLoggedIn = true;
      }else{
        model.isLoggedIn = false;
      }
    }).catchError((error){
      model.isLoggedIn = false;
    });
  }

  Future<void> login({@required String username,@required String password}) async{
    final x = await repo.login(username, password);

    if(x){
      showToast("Login Berhasil");
      model.isLoggedIn = true;
    }else{
      showToast("Login Gagal");
      model.isLoggedIn = false;
    }

    await init();

    notifyListeners();
  }

  Future<void> getPelanggan() async{
    final x = await repo.getPelanggan();
    model.pelanggan.clear();
    model.pelanggan.addAll(x);
    notifyListeners();
  }

  Future<DetailPelanggan> getDetailPelanggan({@required String kode}) async{
    final x = await repo.getDetailPelanggan(kode: kode);
    return x;
  }

  Future<DetailTagihan> getDetailTagihan({@required String kode}) async{
    final x = await repo.detailTagihan(code: kode);
    return x;
  }

  Future<void> inputDataMeteran({@required InputData data}) async{
    await repo.inputData(data);
    notifyListeners();
  }

  Future<void> logout(){
    prefs.removeToken();
    model.isLoggedIn = false;
    notifyListeners();
  }

  Future<bool> resetPassword({@required String newPassword}) async{
    return await repo.resetPassword(newPassword);
  }

  searchPelanggan(String kwd) async{
    final pel = await repo.pencarian(kwd);
    model.pelanggan = pel;
    notifyListeners();
  }

  setPelanggan(List<Pelanggan> p){
    model.pelanggan.clear();
    model.pelanggan.addAll(p);
    notifyListeners();
  }


  static State of(BuildContext context) => ScopedModel.of<State>(context);
}

class AppModel{
  bool isLoggedIn;
  bool isLoading;
  User user;
  List<Pelanggan> pelanggan;
  DetailPelanggan detailPelanggan;
  DetailTagihan detailTagihan;

  AppModel({this.isLoading,this.isLoggedIn,this.detailPelanggan,this.user,this.pelanggan,this.detailTagihan});

  factory AppModel.init(){
    return AppModel(
      isLoading: false,
      isLoggedIn: false,
      user: null,
      pelanggan: [],
      detailPelanggan: null,
      detailTagihan: null,
    );
  }
}
