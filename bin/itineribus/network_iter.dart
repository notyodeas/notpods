import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../server.dart';

Future<Response> networkNodorum(Request req) async {
  return Response.ok(json.encode(par!.bases));
}

