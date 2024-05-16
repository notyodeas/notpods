import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../exempla/constantes.dart';
import '../exempla/obstructionum.dart';
import '../exempla/obstructionum_arma.dart';
import '../exempla/pera.dart';
import '../exempla/errors.dart';
import '../server.dart';

// @Operation.get('liber', 'index', 'probationem', 'gladiatorId')
// Future<Response> tuusIubeoTelum(Request req) async {
//   Directory directorium = Directory(argumentis!.obstructionumDirectorium);
//   List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
//   final bool primis = bool.parse(req.params['primis']!);
//   final String probationem = req.params['probationem']!;
//   final tuusIubeoObstructionumTelumLiber =
//       await Pera.tuusIubeoObstructionumTelum(true, primis, probationem, lo);
//   final BigInt tuusIubeoObstructionumTelumFixum =
//       await Pera.tuusIubeoObstructionumTelum(false, primis, probationem, lo);
//   final ObstructionumArma oa = await Pera.obstructionumArma(probationem, lo);
//   return Response.ok(json.encode({
//     "arma": oa.toJson(),
//     "tuusIubeoLiber": tuusIubeoObstructionumTelumLiber.toString(),
//     "tuusIubeoFixum": tuusIubeoObstructionumTelumFixum.toString(),
//     "probationem": probationem
//   }));
// }

// @Operation.get('liber', 'index', 'probationem')
Future<Response> summaIubeoTelum(Request req) async {
  Directory directorium = Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  final String probationem = req.params['probationem']!;
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  try {
    final BigInt summaBid = await Pera.summaBid(probationem, lo);
    final ObstructionumArma oa = await Pera.obstructionumArma(probationem, lo);
    return Response.ok(json.encode({
      "arma": oa.toJson(),
      "summaBid": summaBid.toString(),
      "probationem": probationem,
    }));
  } on BadRequest catch (err) {
    return Response.badRequest(body: json.encode(err.toJson()));
  }
}
