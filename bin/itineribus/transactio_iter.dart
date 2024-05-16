import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../exempla/connexa_liber_expressi.dart';
import '../exempla/constantes.dart';
import '../exempla/obstructionum.dart';
import '../exempla/responsio/transactio_notitia.dart';
import '../exempla/transactio.dart';
import '../exempla/utils.dart';
import 'dart:convert';
import '../server.dart';

Future<Response> transactioIdentitatis(Request req) async {
  String identitatis = req.params['identitatis']!;
  Directory directory =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> obs = [];
  for (int i = 0; i < directory.listSync().length; i++) {
    await for (String obstructionum in Utils.fileAmnis(
        File('${directory.path}${Constantes.caudices}$i.txt'))) {
      obs.add(Obstructionum.fromJson(
          json.decode(obstructionum) as Map<String, dynamic>));
    }
  }
  Obstructionum prior = await Obstructionum.acciperePrior(directory);
  for (InterioreObstructionum interiore
      in obs.map((o) => o.interiore)) {
    for (Transactio tx in interiore.liberTransactions) {
      if (tx.interiore.identitatis == identitatis) {
        TransactioNotitia txInfo = TransactioNotitia(
            true,
            tx.interiore.inputs
                .map((x) => x.transactioIdentitatis)
                .toList(),
            interiore.indicatione,
            interiore.obstructionumNumerus,
            Obstructionum.confirmationes(interiore.obstructionumNumerus,
                prior.interiore.obstructionumNumerus));
        return Response.ok(
            json.encode({"data": txInfo.toJson(), "scriptum": tx.toJson()}));
      }
    }
    for (Transactio tx in interiore.fixumTransactions) {
      if (tx.interiore.identitatis == identitatis) {
        TransactioNotitia txInfo = TransactioNotitia(
            true,
            tx.interiore.inputs
                .map((x) => x.transactioIdentitatis)
                .toList(),
            interiore.indicatione,
            interiore.obstructionumNumerus,
            Obstructionum.confirmationes(interiore.obstructionumNumerus,
                prior.interiore.obstructionumNumerus));
        return Response.ok(
            json.encode({"data": txInfo.toJson(), "scriptum": tx.toJson()}));
      }
    }
  }
  for (Transactio tx in par!.liberTransactions) {
    if (tx.interiore.identitatis == identitatis) {
      TransactioNotitia txInfo = TransactioNotitia(
          false,
          tx.interiore.inputs
              .map((x) => x.transactioIdentitatis)
              .toList(),
          null,
          null,
          null);
      return Response.ok(json.encode({ "data": txInfo.toJson(), "scriptum": tx.toJson()}));
    }
  }
  for (Transactio tx in par!.fixumTransactions) {
    if (tx.interiore.identitatis == identitatis) {
      TransactioNotitia txInfo = TransactioNotitia(
          false,
          tx.interiore.inputs
              .map((x) => x.transactioIdentitatis)
              .toList(),
          null,
          null,
          null);
      return Response.ok(json.encode({"data": txInfo.toJson(), "scriptum": tx.toJson()}));
    }
  }
  return Response.badRequest(
      body: json.encode({
    "code": 0,
    "nuntius": "Re non inveni",
    "message": "Transaction not found"
  }));
}

Response transactioConnexaLiberExpressi(Request req) {
  String liberIdentitatis = req.params['liber-identitatis']!;
  ConnexaLiberExpressi cle = par!.connexiaLiberExpressis.singleWhere((cle) =>
      cle.interioreConnexaLiberExpressi.identitatis == liberIdentitatis);
  return Response.ok(json.encode(cle.toJson()));
}

Response transactioStagnumLiber(Request req) {
  return Response.ok(
      json.encode(par!.liberTransactions.map((lt) => lt.toJson()).toList()));
}

Response transactioStagnumFixum(Request req) {
  return Response.ok(
      json.encode(par!.fixumTransactions.map((ft) => ft.toJson()).toList()));
}

Response transactioStagnumExpressi(Request req) {
  return Response.ok(
      json.encode(par!.expressiTransactions.map((et) => et.toJson()).toList()));
}
Response transactioStagnumConnexaLiberExpressi(Request req) {
  return Response.ok(json.encode(par!.connexiaLiberExpressis.map((mcle) => mcle.toJson()).toList()));
}