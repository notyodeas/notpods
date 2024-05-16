import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:elliptic/elliptic.dart';
import 'package:shelf/shelf.dart';
import '../exempla/connexa_liber_expressi.dart';
import '../exempla/constantes.dart';
import '../exempla/errors.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/submittere_transactio.dart';
import '../exempla/responsio/transactio_submittere_responsionis.dart';
import '../exempla/si_remotionem.dart';
import '../exempla/transactio.dart';
import 'package:collection/collection.dart';
import '../server.dart';

Future<Response> submittereTransactioFixum(Request req) async {
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
                  nuntius: "can not send money to the same public key")
              .toJson()));
    }
    if (st.pod == BigInt.zero) {
      return Response.badRequest(
          body: json.encode(BadRequest(
                  code: 1,
                  nuntius: "non potest mittere 0",
                  message: "can not send 0")
              .toJson()));
    }
    if (st.pod < BigInt.zero) {
      return Response.badRequest(body: BadRequest(code: 2, nuntius: 'non minus pecuniam furtum rem', message: 'can not steal money with a minus transaction'));
    }
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    bool isProbationum = await Pera.isProbationum(st.to, lo);
    BigInt limit = Pera.habetBid(false, publica, lo);
    if (st.pod > limit && !isProbationum) {
      return Response.badRequest(body: json.encode(BadRequest(code: 2, nuntius: 'non plus pecuniae tum modus $limit POD', message: 'can not spend more money then your limit of $limit POD')));
    }
    // if (!await Pera.isPublicaClavisDefended(st.to, lo) &&
    //     !isProbationum) {
    //   return Response.badRequest(
    //       body: json.encode(BadRequest(
    //               code: 3,
    //               nuntius: 'accipientis non defenditur',
    //               message: 'public key is not defended')
    //           .toJson()));
    // }
    final bool isp = await Pera.isProbationum(st.to, lo);
    if (SiRemotionem.habetProfundum(false, pk.publicKey.toHex(), lo) && !isp) {
      return Response.badRequest(
        body: json.encode(BadRequest(code: 4, nuntius: 'mittens pecuniam penitus', message: 'sender of money is in depth').toJson())
      );
    }
    List<Transactio> stagnum = par!.fixumTransactions;
    // stagnum.addAll(par!.siRemotiones.where((wsr) => wsr.interiore.siRemotionemInput != null).map((msr) => Transactio.nullam(msr.interiore.siRemotionemInput!.interioreTransactio!)));
    // print('stagnumotherloctobeprinted\n ${par!.liberTransactions.map((e) => e.toJson())}');
    if (isp) {
      final Transactio fixum = Transactio.nullam(await Pera.novamRem(
          necessitudo: false,
          liber: false,
          twice: false,
          ts: TransactioSignificatio.ardeat,
          ex: st.ex,
          value: st.pod,
          to: st.to,
          transactioStagnum: stagnum,
          lo: lo));
      ReceivePort rp = ReceivePort();
      // liber.interiore.probatur = true;
      isolates.fixumTxIsolates[fixum.interiore.identitatis] = await Isolate.spawn(Transactio.quaestum, List<dynamic>.from([fixum.interiore, rp.sendPort]));
      rp.listen((transactio) {
        print('abouttosyncfixum');
        par!.syncFixumTransaction(transactio as Transactio);
      });     
      return Response.ok(json.encode(TransactioSubmittereResponsionis(
              true, fixum.interiore.identitatis)
          .toJson()));
    } else {
      print('okeytimeforregular');
      final Transactio liber = Transactio.nullam(await Pera.novamRem(
          necessitudo: true,
          liber: false,
          twice: false,
          ts: TransactioSignificatio.regularis,
          ex: st.ex ,
          value: st.pod,
          to: st.to,
          transactioStagnum: stagnum,
          lo: lo));      
        ReceivePort acciperePortus = ReceivePort();
        isolates.fixumTxIsolates[liber.interiore.identitatis] =
            await Isolate.spawn(
                Transactio.quaestum,
                List<dynamic>.from(
                    [liber.interiore, acciperePortus.sendPort]));
        acciperePortus.listen((transactio) {
          par!.syncFixumTransaction(transactio as Transactio);
        });
        // await par!.syncFixumTransaction(liber);
        return Response.ok(json.encode(TransactioSubmittereResponsionis(false, liber.interiore.identitatis).toJson()));
    }
  } on BadRequest catch (e) {
    return Response.badRequest(body: json.encode(e.toJson()));
  }
}
// Future<Response> submittereTransactioFixum(Request req) async {
//   Directory directorium = Directory(
//       '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
//   SubmittereTransaction st = SubmittereTransaction.fromJson(json.decode(await req.readAsString()));
//   List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
//   if (st.pod == BigInt.zero) {
//     return Response.badRequest(body: {
//       "code": 0,
//       "message": "non potest mittere 0",
//       "english": "can not send 0"
//     });
//   }
//   PrivateKey pk = PrivateKey.fromHex(Pera.curve(), st.ex);
//   if (pk.publicKey.toHex() == st.to) {
//     return Response.ok({
//       "message": "potest mittere pecuniam publicam clavem",
//       "english": "can not send money to the same public key"
//     });
//   }
//   bool isProbationum = await Pera.isProbationum(st.to, lo);
//   BigInt limit = Pera.habetBid(true, pk.publicKey.toHex(), lo);
//   if (st.pod > limit && !isProbationum) {
//     return Response.badRequest(body: json.encode(BadRequest(code: 2, nuntius: 'non plus pecuniae tum modus $limit POD', message: 'can not spend more money then your limit of $limit POD')));
//   }
//   final Transactio transactio = Transactio.nullam(await Pera.novamRem(
//       necessitudo: true,
//       liber: false,
//       twice: false,
//       ts: TransactioSignificatio.regularis,
//       ex: st.ex,
//       value: st.pod,
//       to: st.to,
//       transactioStagnum: par!.fixumTransactions,
//       lo: lo));
//   ReceivePort acciperePortus = ReceivePort();
//   isolates.fixumTxIsolates[transactio.interiore.identitatis] =
//       await Isolate.spawn(
//           Transactio.quaestum,
//           List<dynamic>.from(
//               [transactio.interiore, acciperePortus.sendPort]));
//   acciperePortus.listen((transactio) {
//     par!.syncFixumTransaction(transactio as Transactio);
//   });
//   return Response.ok(json.encode(TransactioSubmittereResponsionis(
//               false, transactio.interiore.identitatis)
//           .toJson()));
//   // return Response.ok(json.encode(
//   //     {"transactionIdentitatis": transactio.interiore.identitatis}));
// }

Future<Response> fixumTransactionStagnum(Request req) async {
  return Response.ok(json.encode(par!.fixumTransactions.map((e) => e.toJson()).toList()));
}
