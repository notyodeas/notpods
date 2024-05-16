// import 'package:conduit/conduit.dart';
// import 'package:appologi_es/appologi_es.dart';
// import 'package:appologi_es/exempla/obstructionum.dart';
// import 'package:appologi_es/exempla/utils.dart';
// import 'package:collection/collection.dart';
// import 'package:appologi_es/p2p.dart';
// import '../exempla/exampla.dart';
// import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';
import '../exempla/errors.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/probationem_jugum.dart';
import '../exempla/utils.dart';
import '../server.dart';
import '../exempla/constantes.dart';
import 'package:collection/collection.dart';
import 'package:elliptic/elliptic.dart';
import 'package:encoder/encoder.dart';
Future<Response> obstructionumPerNumerus(Request req) async {
  final List<int> on = List<int>.from(json.decode(await req.readAsString()));
  try {
    File file = File(
        '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}/${Constantes.caudices}${(on.length - 1).toString()}.txt');
    return Response.ok(await Utils.fileAmnis(file)
        .elementAt(on[on.length - 1]));
  } catch (err) {
    return Response.notFound(Encoder.encodeJson({
      "code": 0,
      "nuntius": "angustos non inveni",
      "message": "block not found"
    }));
  }
}

Future<Response> obstructionumPrior(Request req) async {
  Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  Obstructionum o = await Obstructionum.acciperePrior(directorium);
  return Response.ok(Encoder.encodeJson(o.toJson()));
}

Future<Response> obstructionumRemovereUltimum(Request req) async {
  String ex = req.params['ex']!;
  PrivateKey pk = PrivateKey.fromHex(Pera.curve(), ex);
  if (pk.publicKey.toHex() != argumentis!.publicaClavis) {
    return Response.badRequest(body: Encoder.encodeJson(BadRequest(code: 0, nuntius: 'non producentis nodi', message: 'You are not the producer of the node').toJson()));
  }
  Directory directorium =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  Obstructionum obs = await Obstructionum.acciperePrior(directorium);
  if (obs.interiore.generare == Generare.incipio) {
    return Response.badRequest(
        body: Encoder.encodeJson({
      "code": 0,
      "nuntius": "Incipio scandalum removere non potes",
      "message": "You can't remove the Incipio block"
    }));
  }
  await Obstructionum.removereUltimumObstructionum(directorium);
  par!.liberTransactions = [];
  par!.fixumTransactions = [];
  par!.rationibus = [];
  stamina.efectusThreads = [];
  return Response.ok(Encoder.encodeJson({
    "nuntius": "remotus",
    "message": "removed",
    "obstructionum": obs.toJson()
  }));
}
Future<Response> obstructionumRemovereAdProbationem(Request req) async {
  String probationem = req.params['probationem']!;
  Directory directorium =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  await Obstructionum.removereAdProbationemObstructionum(probationem, directorium);
  Obstructionum prior = await Obstructionum.acciperePrior(directorium);
  return Response.ok(Encoder.encodeJson({
    "nuntius": "removisti caudices usque ad ${prior.interiore.obstructionumNumerus} obstructionum infra est summum obstructionum nunc",
    "message": "you have removed blocks untill ${prior.interiore.obstructionumNumerus} the block below is your highest block now",
    "obstructionum": prior.toJson()
  }));
}

Future<Response> obstructionumNumerus(Request req) async {
  Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  Obstructionum obs = await Obstructionum.acciperePrior(directorium);
  return Response.ok(json
      .encode({"numerus": obs.interiore.obstructionumNumerus}));
}

Future<Response> obstructionumProbationemJugum(Request req) async {
  ProbationemJugum pj =
      ProbationemJugum.fromJson(Encoder.decodeJson(await req.readAsString()));
  Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> obs = await Obstructionum.getBlocks(directorium);
  if (obs.length == 1) return Response.ok([obs.first.probationem]);
  int start = 0;
  int end = 0;
  for (int i = 0; i < obs.length; i++) {
    if (ListEquality().equals(
        obs[i].interiore.obstructionumNumerus, pj.primis)) {
      start = i;
    }
    if (ListEquality().equals(
        obs[i].interiore.obstructionumNumerus,
        pj.novissime)) {
      end = i;
    }
  }
  return Response.ok(
      obs.map((o) => o.probationem).toList().getRange(start, end).toList());
}
Future<Response> obstructionumProbationems(Request req) async {
  Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  return Response.ok(Encoder.encodeJson({ "probationem": lo.map((e) => e.probationem).toList() }));
}
