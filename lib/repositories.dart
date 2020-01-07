import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:pdam/models/paginated_data.dart';
import 'package:pdam/utils/request.dart' as r;
import 'models/pelanggan.dart';
import 'models/tagihan.dart';
import 'models/user.dart';
import 'utils/prefs.dart' as p;

Future<bool> login(
  String username,
  String password,
) async {
  final body = {"nameuser": username, "passuser": password};
  final resp = await r.makeRequestNew(r.RequestType.POST, "/login", body: body);
  final respBody = jsonDecode(resp.body);

  if (resp.statusCode == 200 && respBody["success"] == 1) {
    final b = jsonDecode(resp.body);
    p.persistToken(token: b["token"]);
  }

  return resp.statusCode == 200 && respBody["success"] == 1;
}

Future<User> profile() async {
  final resp = await r.makeAuthRequestNew(r.RequestType.POST, "/profile");

  final body = jsonDecode(resp.body);
  if (resp.statusCode != 200 && body["status"] == 0) {
    return null;
  }

  return User.fromJson(body);
}

Future<DetailPelanggan> getDetailPelanggan({@required String kode}) async {
  final body = {
    "kode_pelanggan": kode,
  };

  final resp =
      await r.makeAuthRequestNew(r.RequestType.POST, "/pelanggan", body: body);
  final json = jsonDecode(resp.body);

  if(resp.statusCode != 200){
    return null;
  }

  return DetailPelanggan.fromJson(json);
}

Future<PaginatedData<Pelanggan>> getPaginatedPelaggan({int page: 1}) async {
  final resp = await r.makeAuthRequestNew(
      r.RequestType.POST, "/listpelanggan?page=$page");
  final body = jsonDecode(resp.body);

  print(body);

  if (resp.statusCode != 200) {
    throw Exception("Tidak ada data");
  }

  final itemMap = body["data"];
  final itemList =
      itemMap.map<Pelanggan>((json) => Pelanggan.fromJson(json)).toList();
  final paginatedData = PaginatedData<Pelanggan>(
    currentPage: body["current_page"],
    firstPage: body["first_page"],
    lastPage: body["last_page"],
    total: body["total"],
    isEmpty: false,
    hasMorePages: false,
    items: itemList,
  );

  return paginatedData;
}

Future<List<Pelanggan>> getPelanggan() async {
  final resp =
      await r.makeAuthRequestNew(r.RequestType.POST, "/listpelanggan");
  if (resp.statusCode != 200) {
    throw Exception("Data tidak ditemukan");
  }

  final b = jsonDecode(resp.body);

  if (b["success"] != 1) {
    throw Exception("Data tidak ditemukan");
  }

  final data = b["data"];
  return data.map<Pelanggan>((json) => Pelanggan.fromJson(json)).toList();
}

Future<bool> inputData(InputData data) async {
  final body = data.toMap();
  final resp =
      await r.makeAuthRequestNew(r.RequestType.POST, "/inputdata", body: body);
  print(body);
  print(resp.body);

  if (resp.statusCode != 200) {
    throw Exception("Gagal input data.");
  }

  return resp.statusCode == 200;
}

Future<bool> resetPassword(String newPassword) async {
  final body = {"passuser": newPassword};

  final resp =
      await r.makeAuthRequestNew(r.RequestType.POST, "/resetpwd", body: body);
  final respBody = jsonDecode(resp.body);

  print(respBody);

  return resp.statusCode == 200 && respBody["success"] == 1;
}

Future<List<Pelanggan>> pencarian(String namaPelanggan) async {
  final body = {
    "nama_pelanggan": namaPelanggan,
  };

  final resp =
      await r.makeAuthRequestNew(r.RequestType.POST, "/pencarian", body: body);
  final respBody = jsonDecode(resp.body);

  print(respBody);

  if (resp.statusCode == 200 && respBody["status"] == 1) return [];

  final data = respBody["data"];
  return data.map<Pelanggan>((json) => Pelanggan.fromJson(json)).toList();
}

Future<DetailTagihan> detailTagihan({@required String code}) async {
  final body = {
    "kode_pelanggan": code,
  };

  final resp = await r.makeAuthRequestNew(r.RequestType.POST, "/detailtagihan",
      body: body);
  final respBody = jsonDecode(resp.body);

  if (resp.statusCode == 200 && respBody["status"] == 1) return null;

  return DetailTagihan.fromJson(respBody);
}
