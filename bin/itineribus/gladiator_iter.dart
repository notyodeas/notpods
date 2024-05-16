import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_plus/shelf_plus.dart';
import 'package:shelf_router/shelf_router.dart';
import '../exempla/constantes.dart';
import '../exempla/errors.dart';
import '../exempla/gladiator.dart';
import '../exempla/invictos_gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/obstructionum_arma.dart';
import '../exempla/pera.dart';
import 'package:tuple/tuple.dart';
import 'dart:io';
import '../exempla/responsio/gladiator_arma.dart';
import '../exempla/responsio/summa_bid_arma.dart';
import '../exempla/telum.dart';
import '../server.dart';
import 'package:collection/collection.dart';

Future<Response> gladiatorInvictos(Request req) async {
  Directory directory =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Tuple3<String, GladiatorOutput, bool>> gladiatores =
      await Obstructionum.invictosGladiatores(directory);
  final List<InvictosGladiator> invictos = [];
  for (Tuple3<String, GladiatorOutput, bool> gladiator in gladiatores) {
    invictos.add(
        InvictosGladiator(gladiator.item1, gladiator.item2, gladiator.item3));
  }
  return Response.ok(json.encode(invictos.map((e) => e.toJson()).toList()));
}

Future<Response> gladiatorDefenditur(Request req) async {
  String publica = req.params['publica-clavis']!;
  Directory directory =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directory);
  if (await Pera.isPublicaClavisDefended(publica, lo)) {
    return Response.ok(json.encode({
      "defenditur": true,
      "nuntius": "publica clavis defenditur",
      "message": "the public key is protected"
    }));
  } else {
    return Response.ok(json.encode({
      "defenditur": false,
      "nuntius": "publica clavis non defenditur",
      "message": "the public key is not protected"
    }));
  }
}

Future<Response> gladiatorArma(Request req) async {
  try {
    final String publica = req.params['publica-clavis']!;
    Directory directory =
        Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
    List<Obstructionum> lo = await Obstructionum.getBlocks(directory);
    final primis = await Pera.isPrimis(publica, directory);
    final gladiatorIdentitatis =
        await Pera.accipereGladiatorIdentitatis(publica, directory);
    final String basisDefensio = await Pera.turpiaGladiatoriaTelum(
        primis, false, gladiatorIdentitatis, lo);
    final basisImpetum =
        await Pera.turpiaGladiatoriaTelum(primis, true, gladiatorIdentitatis, lo);
    final List<Telum> liberDefensiones =
        await Pera.maximeArma(liber: true, primis: primis, impetum: false, gladiatorIdentitatis:  gladiatorIdentitatis, publica: publica, lo: lo);
    final List<Telum> liberImpetus =
        await Pera.maximeArma(liber: true, primis: primis, impetum: true, gladiatorIdentitatis:  gladiatorIdentitatis, publica: publica, lo: lo);
    final List<Telum> fixumDefensiones =
        await Pera.maximeArma(liber: false, primis: primis, impetum: false, gladiatorIdentitatis:  gladiatorIdentitatis, publica: publica, lo: lo);
    final List<Telum> fixumImpetus =
        await Pera.maximeArma(liber: false, primis: primis, impetum: true, gladiatorIdentitatis:  gladiatorIdentitatis, publica: publica, lo: lo);
    GladiatorArma ga = GladiatorArma(
        basisDefensio: basisDefensio,
        basisImpetum: basisImpetum,
        defensionesLiber: liberDefensiones,
        defensionesFixum: fixumDefensiones,
        impetusLiber: liberImpetus,
        impetusFixum: fixumImpetus);
    return Response.ok(json.encode(ga.toJson()));
  } on BadRequest catch (e) {
    return Response.badRequest(body: json.encode(e.toJson()));
  }
}

Future<Response> gladiatorSummaBidArma(Request req) async {
  final String probationem = req.params['probationem']!;
  final Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  try {
    BigInt summaBid = await Pera.summaBid(probationem, lo);
    ObstructionumArma oa = await Pera.obstructionumArma(probationem, lo);
    return Response.ok(
        json.encode(SummaBidArma(probationem, summaBid, oa).toJson()));
  } on BadRequest catch (err) {
    return Response.badRequest(body: json.encode(err.toJson()));
  }
}
Future<Response> algiatornotbidantibationem(Request req) async {
  String antibationems = req.params['antibationems']!;
  String privatesnotkeys = req.params['privatenotkeys']!;
  Directory directory =
        Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directory);
  final primis = await Pera.isPrimis(privatesnotkeys, directory);
  final gladiatorIdentitatis =
      await Pera.accipereGladiatorIdentitatis(privatesnotkeys, directory);
  final String basisDefensio = await Pera.turpiaGladiatoriaTelum(
      primis, false, gladiatorIdentitatis, lo);
  final basisImpetum =
      await Pera.turpiaGladiatoriaTelum(primis, true, gladiatorIdentitatis, lo);
  final List<Telum> liberDefensiones =
      await Pera.maximeArma(liber: true, primis: primis, impetum: false, gladiatorIdentitatis:  gladiatorIdentitatis, publica: privatesnotkeys, lo: lo);
  final List<Telum> liberImpetus =
      await Pera.maximeArma(liber: true, primis: primis, impetum: true, gladiatorIdentitatis:  gladiatorIdentitatis, publica: privatesnotkeys, lo: lo);
  final List<Telum> fixumDefensiones =
      await Pera.maximeArma(liber: false, primis: primis, impetum: false, gladiatorIdentitatis:  gladiatorIdentitatis, publica: privatesnotkeys, lo: lo);
  final List<Telum> fixumImpetus =
      await Pera.maximeArma(liber: false, primis: primis, impetum: true, gladiatorIdentitatis:  gladiatorIdentitatis, publica: privatesnotkeys, lo: lo);
  GladiatorArma ga = GladiatorArma(
        basisDefensio: basisDefensio,
        basisImpetum: basisImpetum,
        defensionesLiber: liberDefensiones.where((element) => element.probationem == antibationems).toList(),
        defensionesFixum: fixumDefensiones.where((element) => element.probationem == antibationems).toList(),
        impetusLiber: liberImpetus.where((element) => element.probationem == antibationems).toList(),
        impetusFixum: fixumImpetus.where((element) => element.probationem == antibationems).toList()
    );
    return Response.ok(json.encode(ga.toJson()));
  
}