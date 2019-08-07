import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:pdam/utils/request.dart' as r;
import 'models/pelanggan.dart';
import 'models/tagihan.dart';
import 'models/user.dart';
import 'utils/prefs.dart' as p;

Future<bool> login(String username,String password) async{
  final body = {
    "nameuser":username,
    "passuser":password
  };
  final resp = await r.makeRequest(r.RequestType.POST, "/login",body: body);
  final respBody = jsonDecode(resp.body);
  
  if(resp.statusCode == 200 && respBody["success"] == 1){
    final b = jsonDecode(resp.body);
    p.persistToken(token: b["token"]);
  }


  return resp.statusCode == 200 && respBody["success"] == 1;
}

Future<User> profile() async{
  final resp = await r.makeAuthRequest(r.RequestType.GET, "/profile");

  final body = jsonDecode(resp.body);

  if(body["status"] == 0){
    return null;
  }

  return User.fromJson(body);

}

Future<DetailPelanggan> getDetailPelanggan({@required String kode}) async{
  final body = {
    "kode_pelanggan":kode,
  };
  
  final resp = await r.makeAuthRequest(r.RequestType.POST, "/pelanggan",body: body);
  final json = jsonDecode(resp.body);
  if(json["success"] == 0){
//    throw Exception("Data tidak ditemukan.");
    return null;
  }

  return DetailPelanggan.fromJson(json);
}

Future<List<Pelanggan>> getPelanggan() async{
  final resp = await r.makeAuthRequest(r.RequestType.POST, "/listpelanggan");
  if(resp.statusCode != 200){
    throw Exception("Data tidak ditemukan");
  }

  final b = jsonDecode(resp.body);
  final data= b["data"];
  return data.map<Pelanggan>((json) => Pelanggan.fromJson(json)).toList();
}

Future<bool> inputData(InputData data) async{
  final body = data.toMap();
  final resp = await r.makeAuthRequest(r.RequestType.POST, "/inputdata",body: body);

  if(resp.statusCode != 200){
    throw Exception("Gagal input data.");
  }

  return resp.statusCode == 200;
}

Future<bool> resetPassword(String newPassword) async{
  final body = {
    "passuser": newPassword
  };

  final resp = await r.makeAuthRequest(r.RequestType.POST, "/resetpwd",body: body);
  final respBody = jsonDecode(resp.body);

  print(respBody);

  return resp.statusCode == 200 && respBody["success"] == 1;
}

Future<List<Pelanggan>> pencarian(String namaPelanggan) async{
  final body = {
    "nama_pelanggan": namaPelanggan,
  };

  final resp = await r.makeAuthRequest(r.RequestType.POST, "/pencarian",body: body);
  final respBody = jsonDecode(resp.body);

  if(resp.statusCode == 200 && respBody["status"] == 1) return [];

  final data = respBody["data"];
  return data.map<Pelanggan>((json) => Pelanggan.fromJson(json)).toList();
}

Future<DetailTagihan> detailTagihan({@required String code}) async{
  final body = {
    "kode_pelanggan": code,
  };

  final resp = await r.makeAuthRequest(r.RequestType.POST, "/detailtagihan",body: body);
  final respBody = jsonDecode(resp.body);

  if(resp.statusCode == 200 && respBody["status"] == 1) return null;

  return DetailTagihan.fromJson(respBody);
}