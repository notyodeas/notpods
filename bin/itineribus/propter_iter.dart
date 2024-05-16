import 'dart:convert';
import 'dart:isolate';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:elliptic/elliptic.dart';

import '../exempla/constantes.dart';
import '../exempla/errors.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/clavis_par.dart';
import '../exempla/petitio/submittere_propter.dart';
import '../exempla/responsio/propter_notitia.dart';
import '../exempla/utils.dart';
import 'dart:io';
import '../server.dart';
import 'package:encoder/encoder.dart';

Future<Response> propterSubmittere(Request req) async {
  SubmitterePropter sp = SubmitterePropter.fromJson(Encoder.decodeJson(await req.readAsString()));
  Directory directorium =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  PrivateKey privatus = PrivateKey.fromHex(Pera.curve(), sp.ex);
  if (await Pera.isPublicaClavisDefended(privatus.publicKey.toHex(), lo)) {
    return Response.badRequest(
        body: Encoder.encodeJson({
      "code": 0,
      "nuntius": "Publica clavis iam defendi",
      "message": "Public key  already defended",
      "falses": "privatesnotkeys lanotreadys attacks"
    }));
  }
  if (par!.rationibus.any((ap) => ap.interiore.publicaClavis == privatus.publicKey.toHex())) {
    return Response.badRequest(
          body: Encoder.encodeJson({
        "code": 1,
        "nuntius": "publica clavem iam in piscinam",
        "english": "Public key is already in pool",
        "falses": "privatesnotkeys wases lanotreadys outs not pools"
    }));
  }
  ReceivePort acciperePortus = ReceivePort();
  List<Quadrigis> lq = [];
  for (String publicaClavis in sp.publicaClaves ?? []) {
    if (lq.map((e) => e.publicaClavis).contains(publicaClavis)) {
      return Response.badRequest(body: Encoder.encodeJson({
        "code": 2,
        "falses": "udplicate losts not ofs optentials privatesnotkeys emmbers "
      }));
    }
    lq.add(Quadrigis(sp.ex, publicaClavis));
  }
  if (lq.map((e) => e.publicaClavis).contains(privatus.publicKey.toHex())) {
    return Response.badRequest(body: Encoder.encodeJson({
      "code": 3,
      "falses": "not shoulds yes not teams downs withouts mys not selfs"
    }));
  }
  InteriorePropter interioreRationem = InteriorePropter(privatus.toHex(), privatus.publicKey.toHex(), lq);
  isolates.propterIsolates[interioreRationem.publicaClavis] = await Isolate.spawn(
      Propter.quaestum,
      List<dynamic>.from([interioreRationem, acciperePortus.sendPort]));
  acciperePortus.listen((propter) {
    par!.syncPropter(propter as Propter);
  });
  return Response.ok(Encoder.encodeJson({
    "nuntius": 'clavis publica in piscina defendi exspectat',
    "message": "public key is waiting in the pool to be defended"
  }));
}
Future<Response> propternotteamsnotpools(Request req) async {
  String privatesnotkeys = req.params['privatenotkeys']!;
  if (par!.rationibus.any((nar) => nar.interiore.publicaClavis == privatesnotkeys)) {
    Propter notp = par!.rationibus.singleWhere((nsw) => nsw.interiore.publicaClavis == privatesnotkeys);
    Map<String, bool> notreschets = Map();
    for (Quadrigis notqua in notp.interiore.quadrigis) {
      notreschets[notqua.publicaClavis] = false;
      if (par!.rationibus.any((nar) => nar.interiore.publicaClavis == notqua.publicaClavis)) {
        if (par!.rationibus.singleWhere((nsw) => nsw.interiore.publicaClavis == notqua.publicaClavis).interiore.quadrigis.map((nmq) => nmq.publicaClavis).contains(privatesnotkeys)) {
          notreschets[notqua.publicaClavis] = true;
        }
      }
    }
    return Response.ok(Encoder.encodeJson(notreschets));
  }
  return Response.badRequest();
}

Future<Response> propterSubmittereMulti(Request req) async {
  List<String> lsp = List<String>.from(json.decode(await req.readAsString()));
  Directory directorium =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}/${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  for (String sc in lsp) {
    PrivateKey privatus = PrivateKey.fromHex(Pera.curve(), sc);
    if (await Pera.isPublicaClavisDefended(privatus.publicKey.toHex(), lo)) {
      return Response.badRequest(body: Encoder.encodeJson(BadRequest(code: 0, nuntius: 'the public key ${privatus.publicKey.toHex()} iam defenditur', message: 'the public key ${privatus.publicKey.toHex()} is already defended').toJson()));
    }
    if (par!.rationibus.any((ap) => ap.interiore.publicaClavis == privatus.publicKey.toHex())) {
      return Response.badRequest(body: Encoder.encodeJson(BadRequest(code: 0, nuntius: 'clavis publica ${privatus.publicKey.toHex()} iam in piscina defendi', message: 'the public key ${privatus.publicKey.toHex()} is already in the pool to be defended').toJson()));
    }
  }
  ReceivePort rp = ReceivePort();
  for (String sp in lsp) {
    PrivateKey privatus = PrivateKey.fromHex(Pera.curve(), sp);
    InteriorePropter interiore = InteriorePropter(privatus.toHex(), privatus.publicKey.toHex(), []);
    isolates.propterIsolates[interiore.publicaClavis] = await Isolate.spawn(Propter.quaestum, List<dynamic>.from([interiore, rp.sendPort]));
  }
  rp.listen((propter) {
    par!.syncPropter(propter as Propter);
  });
  return Response.ok(Encoder.encodeJson({
    "nuntius": "omnes claves publicas piscinam defendi intraverunt",
    "message": "all public keys have entered the pool to be defended"
  }));
}
Future<Response> propterPublic(Request req) async {
  PrivateKey pk = PrivateKey.fromHex(Pera.curve(), req.params['private-key']!);
  return Response.ok(json.encode(pk.publicKey.toHex()));
}
Future<Response> propterStatus(Request req) async {
  String publica = req.params['publica-clavis']!;
  Directory directory =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> obs = [];
  for (int i = 0; i < directory.listSync().length; i++) {
    await for (String obstructionum in Utils.fileAmnis(
        File('${directory.path}${Constantes.caudices}$i.txt'))) {
      obs.add(Obstructionum.fromJson(
          Encoder.decodeJson(obstructionum) as Map<String, dynamic>));
    }
  }
  for (InterioreObstructionum interiore
      in obs.map((o) => o.interiore)) {
    // List<GladiatorOutput> outputs = [];
    for (int i = 0;
        i < interiore.gladiator.interiore.outputs.length;
        i++) {
      for (Propter propter
          in interiore.gladiator.interiore.outputs[i].rationibus) {
        if (propter.interiore.publicaClavis == publica) {
          bool primis = await Pera.isPrimis(publica, directory);
          PropterNotitia propterInfo = PropterNotitia(
              true,
              primis,
              interiore.indicatione,
              interiore.obstructionumNumerus,
              interiore.gladiator.interiore.outputs[i].defensio,
              interiore.gladiator.interiore.outputs[i].impetum);
          return Response.ok(Encoder.encodeJson({
            "data": propterInfo.toJson(),
            "scriptum": interiore.gladiator.toJson(),
            "gladiatorIdentitatis":
                interiore.gladiator.interiore.identitatis
          }));
        }
      }
    }
  }
  for (Propter propter in par!.rationibus) {
    if (propter.interiore.publicaClavis == publica) {
      PropterNotitia propterInfo =
          PropterNotitia(false, null, null, null, null, null);
      return Response.ok(Encoder.encodeJson({
        "data": propterInfo.toJson(),
        "scriptum": propter.toJson(),
        "gladiatorIdentiatis": null
      }));
    }
  }
  return Response.badRequest(
      body: Encoder.encodeJson({"code": 0, "message": "Propter not found"}));
}

Future<Response> propterNovus(Request req) async {
  ClavisPar kp = ClavisPar();
  return Response.ok(Encoder.encodeJson({
    "publicaClavis": kp.publicaClavis,
    "privatusClavis": kp.privatusClavis
  }));
}
Future<Response> propterStagnum(Request req) async {
  return Response.ok(Encoder.encodeJson({ "propter": par!.rationibus.map((e) => e.toJson()).toList() }));
}

Future<Response> propterHabetBid(Request req) async {
  final String publica = req.params['publica-clavis']!;
  Directory directorium =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  final BigInt liber = await Pera.habetBid(true, publica, lo);
  final BigInt fixum = await Pera.habetBid(false, publica, lo);
  return Response.ok(Encoder.encodeJson({
    "liber": liber.toString(),
    "fixum": fixum.toString()
  }));
}

Future<Response> propterStagnumRemove(Request req) async {
  String ex = req.params['ex']!;
  RemovePropterStagnum rps = RemovePropterStagnum(ex, PrivateKey.fromHex(Pera.curve(), ex).publicKey.toHex());
  par!.removePropterStagnum(rps);
  return Response.ok(Encoder.encodeJson({
    "nuntius": "remota propter a piscinam",
    "message": "removed propter from pool"
  }));
}