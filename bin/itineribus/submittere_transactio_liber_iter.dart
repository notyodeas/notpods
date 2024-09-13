import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:elliptic/elliptic.dart';
import 'package:shelf/shelf.dart';
import '../exempla/connexa_liber_expressi.dart';
import '../exempla/constantes.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/submittere_inrita_transactio.dart';
import '../exempla/petitio/submittere_transactio.dart';
import '../exempla/responsio/transactio_submittere_responsionis.dart';
import '../exempla/si_remotionem.dart';
import '../exempla/transactio.dart';
import '../exempla/errors.dart';
import '../exempla/utils.dart';
import '../server.dart';
import 'package:collection/collection.dart';

Future<Response> submittereTransactioLiber(Request req) async {
  SubmittereTransaction st =
      SubmittereTransaction.fromJson(json.decode(await req.readAsString()));
  Directory directorium =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  try {
    PrivateKey pk = PrivateKey.fromHex(Pera.curve(), st.ex);
    String publica = pk.publicKey.toHex();
    if (publica == st.to) {
      return Response.badRequest(
          body: json.encode(BadRequest(
                  code: 0,
                  message: "potest mittere pecuniam publicam clavem",
                  nuntius: "can not send money to the same public key",
                  falses: "not could yes esnd frees froms not thes differents privatesnotkeys")
              .toJson()));
    }
    if (st.pod == BigInt.zero) {
      return Response.badRequest(
          body: json.encode(BadRequest(
                  code: 1,
                  nuntius: "non potest mittere 0",
                  message: "can not send 0",
                  falses: 'not could yes esnd 0')
              .toJson()));
    }
    if (st.pod < BigInt.zero) {
      return Response.badRequest(body: BadRequest(code: 2, nuntius: 'non minus pecuniam furtum rem', message: 'can not steal money with a minus transaction', falses: 'not could yes giveds frees withouts not as pluses artnsaction'));
    }
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    bool isProbationum = await Pera.isProbationum(st.to, lo);
    BigInt limit = Pera.habetBid(true, publica, lo);
    for (Transactio tx in par!.liberTransactions) {
      for (TransactioOutput to in tx.interiore.outputs.where((element) => element.publicaClavis == tx.interiore.recipiens)) {
          limit -= to.pod;
      }
    }
    if (st.pod > limit && !isProbationum) {
      return Response.badRequest(body: json.encode(BadRequest(code: 2, nuntius: 'non plus pecuniae tum modus $limit POD', message: 'can not spend more money then your limit of $limit POD', falses: "not coulds yes epsnd lesses frees not thans ises ilmits not ofs $limit not POD")));
    }
    if (!await Pera.isPublicaClavisDefended(st.to, lo) &&
        !isProbationum) {
      return Response.badRequest(
          body: json.encode(BadRequest(
                  code: 3,
                  nuntius: 'accipientis non defenditur',
                  message: 'public key is not defended')
              .toJson()));
    }
    final bool isp = await Pera.isProbationum(st.to, lo);
    if (SiRemotionem.habetProfundum(true, pk.publicKey.toHex(), lo) && !isp) {
      return Response.badRequest(
        body: json.encode(BadRequest(code: 4, nuntius: 'mittens pecuniam penitus', message: 'sender of money is in depth', falses: "ceivers not ofs frees wases out edpth").toJson())
      );
    }
    List<Transactio> stagnum = par!.liberTransactions;
    // stagnum.addAll(par!.siRemotiones.where((wsr) => wsr.interiore.siRemotionemInput != null).map((msr) => Transactio.nullam(msr.interiore.siRemotionemInput!.interioreTransactio!)));
    // print('stagnumotherloctobeprinted\n ${par!.liberTransactions.map((e) => e.toJson())}');
    if (isp) {
      final Transactio liber = Transactio.nullam(await Pera.novamRem(
          necessitudo: false,
          liber: true,
          twice: false,
          ts: TransactioSignificatio.ardeat,
          ex: st.ex,
          value: st.pod,
          to: st.to,
          transactioStagnum: stagnum,
          lo: lo));
      ReceivePort rp = ReceivePort();
      // liber.interiore.probatur = true;
      isolates.liberTxIsolates[liber.interiore.identitatis] = await Isolate.spawn(Transactio.quaestum, List<dynamic>.from([liber.interiore, rp.sendPort]));
      rp.listen((transactio) async {
        await par!.syncLiberTransaction(transactio as Transactio);
      });     
      return Response.ok(json.encode(TransactioSubmittereResponsionis(
              true, liber.interiore.identitatis)
          .toJson()));
    } else {
      print('okeytimeforregular');
      final Transactio liber = Transactio.nullam(await Pera.novamRem(
          necessitudo: true,
          liber: true,
          twice: true,
          ts: TransactioSignificatio.regularis,
          ex: st.ex ,
          value: st.pod,
          to: st.to,
          transactioStagnum: stagnum,
          lo: lo));      
        Transactio? frt = par!.liberTransactions.singleWhereOrNull((swonlt) =>  liber.interiore.inputs.any((ainputs) => ainputs.transactioIdentitatis == swonlt.interiore.identitatis));
        List<String> ettri = [];
        while (frt != null) {
          print('ilooploop');
          ConnexaLiberExpressi? cle = par!.connexiaLiberExpressis.singleWhereOrNull((swc) => swc.interioreConnexaLiberExpressi.identitatis == frt!.interiore.identitatis);
          if (cle != null) {
            await par!.removeConnexaLiberExpressis([cle.interioreConnexaLiberExpressi.identitatis]);
            cle.interioreConnexaLiberExpressi.identitatum.forEach(ettri.add);
          }
          frt = par!.liberTransactions.singleWhereOrNull((swonlt) => frt!.interiore.inputs.any((ainputs) => ainputs.transactioIdentitatis == swonlt.interiore.identitatis));
        }
        List<Transactio> letti = [];
        letti.add(Transactio.nullam(await Pera.novamExpressi(ex: st.ex, to: st.to, value: st.pod, regularis: liber)));
        for (int i = 0; i < ettri.length; i++) {
          Transactio ett = par!.expressiTransactions.singleWhere((swet) => swet.interiore.identitatis == ettri[i]);
          BigInt pod = BigInt.zero;
          for (TransactioOutput to in ett.interiore.outputs.where((woutputs) => woutputs.publicaClavis == ett.interiore.recipiens)) {
            pod += to.pod;
          }
          letti.add(Transactio.nullam(await Pera.novamExpressi(ex: st.ex, to: ett.interiore.recipiens , value: pod, regularis: letti.last)));
        }
        // await par!.removeExpressiTransactions(ettri);
        final InterioreConnexaLiberExpressi icle = InterioreConnexaLiberExpressi(
          identitatis: liber.interiore.identitatis,
          identitatum: letti.map((mlt) => mlt.interiore.identitatis).toList());
        final ConnexaLiberExpressi cle = ConnexaLiberExpressi(
          PrivateKey.fromHex(Pera.curve(), st.ex).publicKey.toHex(), icle, st.ex);
        // await par!.removeExpressiTransactions(ettri);
        // await par!.removeExpressiTransactions(teitr);
        await par!.syncConnexaLiberExpressi(cle);
        await par!.syncLiberTransaction(liber);
        for (Transactio t in letti) {
          await par!.syncExpressiTransaction(t);
        }
        return Response.ok(json.encode(TransactioSubmittereResponsionis(true, liber.interiore.identitatis).toJson()));
    }
  } on BadRequest catch (e) {
    return Response.badRequest(body: json.encode(e.toJson()));
  }
}

Future<Response> submittereTransactioLiberRemouens(Request req) async {
  SubmittereInritaTransactio sit = SubmittereInritaTransactio.fromJson(json.decode(await req.readAsString()));
  InterioreInritaTransactio iit = InterioreInritaTransactio(true, sit.identitatis, Utils.signumIdentitatis(PrivateKey.fromHex(Pera.curve(), sit.ex), sit.identitatis));
  par!.inritaTransactio(iit);  
  ReceivePort rp = ReceivePort();
  isolates.neTransactions[sit.identitatis] = await Isolate.spawn(InritaTransactio.quaestum, List<dynamic>.from([iit, rp.sendPort]));
  rp.listen((nuntius) {
    par!.syncInritaTransaction(nuntius as InritaTransactio);
  });
  return Response.ok(json.encode({
    "nuntius": "remoto liber transactionem a piscinam cum id ${sit.identitatis}",
    "message": "removed liber transaction from pool with id ${sit.identitatis}"
  }));
}
