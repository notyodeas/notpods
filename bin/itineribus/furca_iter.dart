import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../exempla/constantes.dart';
import '../exempla/obstructionum.dart';
import 'package:collection/collection.dart';
import '../server.dart';

Future<Response> furcaForamen(Request req) async {
  List<Obstructionum> lo = await Obstructionum.getExitusBlocks();
  return Response.ok(
      json.encode(lo.reversed.map((mff) => mff.toJson()).toList()));
}

Future<Response> furcaTridentes(Request req) async {
  List<Obstructionum> lo = await Obstructionum.getLatusBlocks();
  return Response.ok(
      json.encode(lo.map((mt) => mt.toJson()).toList()));
}

Future<Response> furcaQuaerere(Request req) async {
  List<Obstructionum> foramens = await Obstructionum.getExitusBlocks();
  List<Obstructionum> tridentes = await Obstructionum.getLatusBlocks();
  List<List<Obstructionum>> calculum = [];
  for (Obstructionum? fo in tridentes) {
    List<Obstructionum> flo = [];
    while (fo != null) {
      flo.insert(0, fo);
      fo = tridentes.singleWhereOrNull((swontridentes) => swontridentes.probationem == fo!.interiore.priorProbationem);
    }
    flo.insert(0, foramens.singleWhere((swforamens) => swforamens.probationem == flo.first.interiore.priorProbationem));
    calculum.add(flo);
  }
  List<Obstructionum> simul = [];
  for (List<Obstructionum> flo in calculum) {
    simul.addAll(flo);
  }
  List<List<Obstructionum>> reditus = [];
  for (List<Obstructionum> flo in calculum) {
    for (Obstructionum ffo in flo) {
      if (!simul.any((asimul) => asimul.interiore.priorProbationem == ffo.probationem)) {
        reditus.add(flo);
      }
    }
  }
  return Response.ok(json.encode(reditus.map((mreditus) => mreditus.map((mmreditus) => mmreditus.toJson()).toList()).toList()));
}


Future<Response> furcaSync(Request req) async {
  String probationem = req.params['probationem']!;
  Directory directorium = Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  par!.syncFurca(probationem);
  return Response.ok(json.encode({
    "nuntius": "nodi propriam invenire coepi ad furcam syncing datam, pro magis notitia tua consolatorium vide",
    "message": "started to find the proper node for syncing the given fork, for more information see your console"
  }));
}