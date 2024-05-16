import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../exempla/constantes.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/responsio/statera.dart';
import '../server.dart';

Future<Response> statera(Request req) async {
  Directory directory = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  String publicaClavis = req.params['publica-clavis']!;
  List<Obstructionum> lo = await Obstructionum.getBlocks(directory);
  BigInt stateraLiber = await Pera.statera(true, publicaClavis, lo);
  BigInt stateraFixum = await Pera.statera(false, publicaClavis, lo);
  return Response.ok(
      json.encode(Statera(liber: stateraLiber, fixum: stateraFixum)));
}
