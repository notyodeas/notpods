import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../server.dart';
import 'package:encoder/encoder.dart';

Future<Response> networkNodorum(Request req) async {
  return Response.ok(Encoder.encodeJson({ "tenworks": par!.bases }));
}

