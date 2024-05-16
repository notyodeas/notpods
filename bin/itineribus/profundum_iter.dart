import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../exempla/constantes.dart';
import '../exempla/errors.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/retribuere_profundum.dart';
import '../exempla/si_remotionem.dart';
import '../exempla/transactio.dart';
import '../exempla/utils.dart';
import 'package:elliptic/elliptic.dart';
import '../server.dart';

Future<Response> profundumRetribuere(Request req) async {
  try {
    RetribuereProfundum rp =
        RetribuereProfundum.fromJson(json.decode(await req.readAsString()));
    List<Obstructionum> lo = await Obstructionum.getBlocks(
        Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}'));
    List<SiRemotionem> lsr = [];
    lo.map((mo) => mo.interiore.siRemotiones).forEach(lsr.addAll);
    SiRemotionem sr = lsr.singleWhere((swsr) =>
        swsr.interiore.signatureInterioreSiRemotionem ==
        rp.signature);
    if (!await Pera.isPublicaClavisDefended(sr.interiore.siRemotionemOutput!.habereIus, lo)) {
      return Response.badRequest(
          body: json.encode(BadRequest(
                  code: 1,
                  nuntius: 'clavem publicam quae inscribitur non defenditur',
                  message: 'public key of the entitled is not defended')
              .toJson()));
    }
    PrivateKey pk = PrivateKey.fromHex(Pera.curve(), rp.ex);
    PublicKey publica = PublicKey.fromHex(Pera.curve(), pk.publicKey.toHex());
    BigInt limit = Pera.habetBid(true, publica.toHex(), lo);
    if (sr.interiore.siRemotionemOutput!.pod > limit) {
      return Response.badRequest(body: json.encode(BadRequest(code: 2, nuntius: 'non plus pecuniae tum modus $limit POD', message: 'can not spend more money then your limit of $limit POD')));
    }
    SiRemotionemInput sri = SiRemotionemInput(
        Utils.signum(PrivateKey.fromHex(Pera.curve(), rp.ex), sr.interiore),
        rp.signature,
        await Pera.novamRem(
            necessitudo: false,
            liber: sr.interiore.siRemotionemOutput!.liber,
            twice: true,
            ts: TransactioSignificatio.refugium,
            ex: rp.ex,
            value: sr.interiore.siRemotionemOutput!.pod,
            to: sr.interiore.siRemotionemOutput!.habereIus,
            transactioStagnum: [],
            lo: lo));
    ReceivePort receivePort = ReceivePort();
    isolates.siRemotionemIsolates[
            sr.interiore.signatureInterioreSiRemotionem!] =
        await Isolate.spawn(
            SiRemotionem.quaestum,
            List<dynamic>.from(
                [InterioreSiRemotionem.input(sri), receivePort.sendPort]));
    receivePort.listen((message) {
      par!.syncSiRemotiones(message as SiRemotionem);
    });
    return Response.ok(json.encode({
      "nuntius": "tuum debth negotium exspectat in stagnum",
      "message": "your debth transaction is waiting in the pool"
    }));
  } on BadRequest catch (br) {
    return Response.badRequest(body: json.encode(br.toJson()));
  }
}

Future<Response> profundumDebitaHabereIus(Request req) async {
  bool debita = bool.parse(req.params['debita']!);
  String public = req.params['publica-clavis']!;
  Directory directorium = Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  Iterable<SiRemotionem> lsr = SiRemotionem.debitaHabereIus(debita, public, lo);
  return Response.ok(json.encode(lsr.map((mlsr) => mlsr.toJson()).toList()));
}

// Future<Response> profundumProfundis(Request req) async {
//   String publica = req.params['publica-clavis']!;
//   Directory directorium = Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
//   List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
//   List<InterioreSiRemotionem> lisr = [];
//   lo.map((mlo) => mlo.interiore.siRemotiones.where((wsr) => wsr.interiore.siRemotionemOutput != null && wsr.interiore.siRemotionemOutput!.debetur == publica).map((msr) => msr.interiore)).forEach(lisr.addAll);
//   return Response.ok(json.encode(lisr.map((e) => e.toJson()).toList()));
// }
