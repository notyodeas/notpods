import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../server.dart';

Future<Response> networkNodorum(Request req) async {
  List<String> nodes = par!.bases;
  nodes.add('${argumentis!.internumIp}:${argumentis!.pervideasPort}');
  return Response.ok(json.encode(nodes));
}

