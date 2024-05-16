import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:ecdsa/ecdsa.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../exempla/constantes.dart';
import '../exempla/errors.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/si_remotionem_remove.dart';
import '../exempla/petitio/submittere_si_remotionem.dart';
import '../exempla/si_remotionem.dart';
import '../exempla/transactio.dart';
import '../exempla/utils.dart';
import '../server.dart';
import 'package:collection/collection.dart';
import 'package:elliptic/elliptic.dart';

class Dominium {
  String publicaClavis;
  Transactio transactio;
  Dominium(this.publicaClavis, this.transactio);
}

Future<Response> siRemotionessubmittereProof(Request req) async {
  SubmittereSiRemotionem ssr =
      SubmittereSiRemotionem.fromJson(json.decode(await req.readAsString()));
      //its not only setting this to null i mean or null its also about checking if the identitatis is illegal or should that only be on obstructionum sync
      // no for here just null is fine but for the propendam when you would use the siremotionem to be an output of si remotionem we should first check if the id is not forbidden
  Transactio? lt = ssr.interiore.liber
      ? par!.liberTransactions.singleWhereOrNull(
          (swlt) => swlt.interiore.identitatis == ssr.interiore.identitatis)
      : par!.fixumTransactions.singleWhereOrNull(
          (swft) => swft.interiore.identitatis == ssr.interiore.identitatis);
  if (lt == null) {
    return Response.badRequest(body: json.encode(
      BadRequest(code: 0, nuntius: 'transaction invenire potuerunt subscribere', message: 'could not find transaction to sign')
    ));
  }
  if (PrivateKey.fromHex(Pera.curve(), ssr.ex).publicKey.toHex() != lt.interiore.recipiens) {
    return Response.badRequest(body: json.encode(
      BadRequest(code: 1, 
      nuntius: 'Non es receptator negotii, scribe identitatem rerum cum accipientibus clavis privatis', 
      message: 'you are not the receiver of the transaction, please sign the transactions identity with the receivers private key').toJson()));
  }
  if (lt.interiore.certitudo != null) {
    return Response.badRequest(body: json.encode(BadRequest(code: 2, nuntius: 'transaction iam signatum per eum qui accipit', message: 'transaction is already signed by the receiver')));
  }
  List<Transactio> lte = [];
  lt.interiore.certitudo = Utils.signumIdentitatis(PrivateKey.fromHex(Pera.curve(), ssr.ex), lt.interiore.identitatis);
  if (ssr.interiore.liber) {
    Transactio? et = par!.expressiTransactions.singleWhere((swet) => swet.interiore.inputs.any((ai) => ai.transactioIdentitatis == lt.interiore.identitatis));
    while (et != null) {
      lte.add(et);
      et.interiore.certitudo = Utils.signumIdentitatis(PrivateKey.fromHex(Pera.curve(), ssr.ex), et.interiore.identitatis);
      et = par!.expressiTransactions.singleWhereOrNull((swonet) => swonet.interiore.inputs.any((ai) => ai.transactioIdentitatis == et!.interiore.identitatis));
    }
  }    
  SiRemotionem reschet = lt.interiore.siRemotionem!;
  lt.interiore.siRemotionem = null;
  ReceivePort rp = ReceivePort();
  isolates.liberTxIsolates[lt.interiore.identitatis] =
      await Isolate.spawn(Transactio.quaestum,
          List<dynamic>.from([lt.interiore, rp.sendPort]));
  rp.listen((transactio) {
    if (lt.interiore.liber) {
      par!.syncLiberTransaction(transactio as Transactio);
    } else {
      par!.syncFixumTransaction(transactio as Transactio);
    }
    for (Transactio te in lte) {
      par!.syncExpressiTransaction(te);
    }
  });
  return Response.ok(json.encode(reschet.interiore.toJson()));
}

Future<Response> siRemotionesreprehendoSiExistat(Request req) async {
  bool liber = bool.parse(req.params[JSON.liber]!);
  String identitatis = req.params[JSON.identitatis]!;
  Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  if (liber
      ? par!.liberTransactions
          .any((alt) => alt.interiore.identitatis == identitatis)
      : par!.fixumTransactions
          .any((alt) => alt.interiore.identitatis == identitatis)) {
    return Response.ok(true);
  }
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  List<Transactio> lt = [];
  lo
      .map((mo) => mo.interiore.liberTransactions)
      .forEach(lt.addAll);
  lo
      .map((mo) => mo.interiore.fixumTransactions)
      .forEach(lt.addAll);
  if (lt.any((at) => at.interiore.identitatis == identitatis)) {
    return Response.ok(false);
  } else {
    return Response.notFound({});
  }
}

Future<Response> siRemotionesdenuoProponendam(Request req) async {
  InterioreSiRemotionem sr =
      InterioreSiRemotionem.fromJson(json.decode(await req.readAsString()));
  Directory directorium = Directory(
      '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  if (!sr.siRemotionemOutput!.estTransactionIdentitatisAdhucPraesto(lo, null) || par!.inritaTransactions.any((ait) => ait.interiore.identitatis == sr.siRemotionemOutput!.transactioIdentitatis)) {
    return Response.badRequest(body: json.encode(BadRequest(code: 0, nuntius: 'rem tollitur rei ante susceptor signati dominus rei', message: 'transaction is removed by the owner of the transaction before the receiver signed it')));
  }
  if (par!.liberTransactions.any((alt) => alt.interiore.identitatis == sr.siRemotionemOutput!.transactioIdentitatis || par!.fixumTransactions.any((aft) => aft.interiore.identitatis == sr.siRemotionemOutput!.transactioIdentitatis))) {
    return Response.badRequest(body: json.encode(BadRequest(code: 0, nuntius: 'transactionem si remotionem refers to numquam got inclusa in trunco vel adhuc exspectans includi', message: 'the transaction the si remotionem refers to never got included in a block or is still waiting to be included')));
  }
  List<Transactio> lt = [];
  lo
      .map((mo) => sr.siRemotionemOutput!.liber
          ? mo.interiore.liberTransactions
          : mo.interiore.fixumTransactions)
      .forEach(lt.addAll);
  if (lt.any((alt) =>
      alt.interiore.identitatis ==
      sr.siRemotionemOutput!.transactioIdentitatis)) {
    return Response.badRequest(
        body: json.encode(BadRequest(
                code: 0,
                nuntius: 'transactio quae numquam remotus est',
                message: 'transaction has never been removed')
            .toJson()));
  }
  ReceivePort rp = ReceivePort();
  isolates.siRemotionemIsolates[sr.signatureInterioreSiRemotionem!] =
      await Isolate.spawn(
          SiRemotionem.quaestum, List<dynamic>.from([sr, rp.sendPort]));
  rp.listen((dp) {
    par!.syncSiRemotiones(dp as SiRemotionem);
  });
  return Response.ok(json.encode({
    "nuntius": "tuum remotum res exspectat prioritas piscinae",
    "message": "your removed transaction is waiting in the priority pool"
  }));
}

Future<Response> siRemotionesStagnum(Request req) async {
  return Response.ok(
      json.encode(par!.siRemotiones.map((e) => e.toJson()).toList()));
}

Future<Response> siRemotionemsRemove(Request req) async {
  SiRemotionemRemove srr = SiRemotionemRemove.fromJson(json.decode(await req.readAsString()));
  SiRemotionem sr = par!.siRemotiones.singleWhere((swlsr) => swlsr.interiore.signatureInterioreSiRemotionem == srr.signature);
  SiRemotionemRemoveNuntius srrn = SiRemotionemRemoveNuntius(ex: srr.ex, transactioIdentitatis: sr.interiore.siRemotionemOutput!.transactioIdentitatis, signatureIdentitatis: srr.signature);
  PrivateKey pk = PrivateKey.fromHex(Pera.curve(), srr.ex);
  if (!Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), pk.publicKey.toHex()), Signature.fromASN1Hex(srrn.signature), srrn.transactioIdentitatis)) {
    return Response.badRequest(body: json..encode(BadRequest(code: 0, nuntius: 'hoc removendi ius non habes', message: 'you dont have the right to remove this si remotionem')));
  }
  par!.removeSiRemotionem(srrn);
  return Response.ok(json.encode({
    "nuntius": "remota si remotionem a piscinam",
    "message": "removed si remotionem from the pool"
  }));
}