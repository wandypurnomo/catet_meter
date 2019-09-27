import 'dart:convert';

import 'package:pdam/config.dart';

import '../config.dart' show baseUrl;
import '../utils/prefs.dart' show getToken;
import 'package:http/http.dart' show Client, Response;

import 'helper.dart';

enum RequestType { POST, GET, DELETE, PATCH }

String setUrl(path) {
  return baseUrl + path;
}

String setUrlNew(path){
  return baseUrlNew + path;
}

Future<Response> makeRequest(
  RequestType type,
  String path, {
  Map<String, dynamic> body,
}) async {
  final client = new Client();
  Response response;

  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  switch (type) {
    case RequestType.POST:
      response = await client.post(
        setUrl(path),
        headers: headers,
        body: json.encode(body),
      );
      break;
    case RequestType.PATCH:
      response = await client.patch(
        setUrl(path),
        headers: headers,
        body: json.encode(body),
      );
      break;
    case RequestType.DELETE:
      response = await client.delete(
        setUrl(path),
        headers: headers,
      );
      break;
    default:
      response = await client.get(
        setUrl(path),
        headers: headers,
      );
      break;
  }

  client.close();

  return response;
}

Future<Response> makeAuthRequest(
  RequestType type,
  String path, {
  Map<String, dynamic> body,
}) async {
  var client = new Client();
  Response response;

  final token = await getToken();

  if (token == null) {
    throw Exception("Token not exists");
  }

  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer $token"
  };

  switch (type) {
    case RequestType.POST:
      response = await client.post(
        setUrl(path),
        headers: headers,
        body: json.encode(body),
      );
      break;
    case RequestType.PATCH:
      response = await client.patch(
        setUrl(path),
        headers: headers,
        body: json.encode(body),
      );
      break;
    case RequestType.DELETE:
      response = await client.delete(
        setUrl(path),
        headers: headers,
      );
      break;
    default:
      response = await client.get(
        setUrl(path),
        headers: headers,
      );
      break;
  }

  client.close();

  return response;
}

void renderErrors(Map<String, dynamic> errors) {
  String container = "";

  errors.forEach((k, v) {
    v.forEach((msg) {
      container += k + ": " + msg + "\n";
    });
  });

  showToast(container);
}

Future<Response> makeRequestNew(
    RequestType type,
    String path, {
      Map<String, dynamic> body,
    }) async {
  final client = new Client();
  Response response;

  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  switch (type) {
    case RequestType.POST:
      response = await client.post(
        setUrlNew(path),
        headers: headers,
        body: json.encode(body),
      );
      break;
    case RequestType.PATCH:
      response = await client.patch(
        setUrlNew(path),
        headers: headers,
        body: json.encode(body),
      );
      break;
    case RequestType.DELETE:
      response = await client.delete(
        setUrlNew(path),
        headers: headers,
      );
      break;
    default:
      response = await client.get(
        setUrlNew(path),
        headers: headers,
      );
      break;
  }

  client.close();

  return response;
}

Future<Response> makeAuthRequestNew(
    RequestType type,
    String path, {
      Map<String, dynamic> body,
    }) async {
  var client = new Client();
  Response response;

  final token = await getToken();

  if (token == null) {
    throw Exception("Token not exists");
  }

  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer $token"
  };

  switch (type) {
    case RequestType.POST:
      response = await client.post(
        setUrlNew(path),
        headers: headers,
        body: json.encode(body),
      );
      break;
    case RequestType.PATCH:
      response = await client.patch(
        setUrlNew(path),
        headers: headers,
        body: json.encode(body),
      );
      break;
    case RequestType.DELETE:
      response = await client.delete(
        setUrlNew(path),
        headers: headers,
      );
      break;
    default:
      response = await client.get(
        setUrlNew(path),
        headers: headers,
      );
      break;
  }

  client.close();

  return response;
}
