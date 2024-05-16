import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:shelf/shelf.dart';
import 'package:elliptic/elliptic.dart';

import '../exempla/constantes.dart';
import '../exempla/errors.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/solucionis_cash_ex.dart';
import '../exempla/petitio/submittere_solucionis.dart';
import '../exempla/solucionis_propter.dart';
import '../exempla/transactio.dart';
import '../server.dart';


Future<Response> solucionisSubmittereSolocionisPropter(Request req) async {
  SubmittereSolucionisPropter ssr = SubmittereSolucionisPropter.fromJson(json.decode(await req.readAsString()));
  PrivateKey privatus = PrivateKey.fromHex(Pera.curve(), ssr.solucionis);
  String publica = privatus.publicKey.toHex();
  if (publica == ssr.accipientis) {
    return Response.badRequest(body: json.encode(BadRequest(code: 0, nuntius: 'accipientis clavis adhibetur ut metam solucionis ratio et sicut principalis oratio huius solucionis ratio', message: 'the receiver key is used as a final destination of a payment account and as the main address of this payment account')));
  }
  InterioreInterioreSolucionisPropter iisp = InterioreInterioreSolucionisPropter(publica, ssr.accipientis);
  InterioreSolucionisPropter isr = InterioreSolucionisPropter(privatus, iisp);
  List<Obstructionum> lo = await Obstructionum.getBlocks(Directory('${Constantes.caudices}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}'));
  if (!isr.estValidus(lo)) {
    return Response.badRequest(body: json.encode(BadRequest(code: 1, nuntius: 'Publica clavis iam usus est ad mercedem Ratio aut est receptaculum et senior solucionis Ratio', message: 'public key is already used for a payment account or is the receiver of an older payment account')));
  }
  ReceivePort rp = ReceivePort();
  isolates.solocionisRationem[publica] = await Isolate.spawn(SolucionisPropter.quaestum, List<dynamic>.from([isr, rp.sendPort]));
  rp.listen((solucionis) { 
    par!.syncSolucionisPropter(solucionis as SolucionisPropter);
  });
  return Response.ok(json.encode({
    "nuntius": "solucionis ratio exspectat in stagnum",
    "message": "payment account is waiting in the pool"
  }));
}
Response solucionisStagnum(Request req) {
  return Response.ok(json.encode(par!.solucionisRationibus.map((msp) => msp.toJson()).toList()));
}
Future<Response> solucionisCashEx(Request req) async {
  SolucionisCashEx sce = SolucionisCashEx.fromJson(await json.decode(await req.readAsString()));
  String publica = PrivateKey.fromHex(Pera.curve(), sce.ex).publicKey.toHex();
  Directory directorium = Directory('${Constantes.caudices}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  SolucionisPropter sp = SolucionisPropter.accipere(publica, lo);
  BigInt mittere = await Pera.statera(sce.liber, publica, lo);
  InterioreTransactio it = await Pera.novamRem(necessitudo: false, liber: sce.liber, twice: false, ts: TransactioSignificatio.solucionis, ex: sce.ex, value: mittere, to: sp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.accipientis, transactioStagnum: sce.liber ? par!.liberTransactions : par!.fixumTransactions, lo: lo);
  ReceivePort rp = ReceivePort();
  if (sce.liber) {
    isolates.liberTxIsolates[it.identitatis] = await Isolate.spawn(Transactio.quaestum, List<dynamic>.from([it, rp.sendPort]));
  } else {
    isolates.fixumTxIsolates[it.identitatis] = await Isolate.spawn(Transactio.quaestum, List<dynamic>.from([it, rp.sendPort]));
  }
  rp.listen((transactio) {
    par!.syncLiberTransaction(transactio as Transactio);
  });
  return Response.ok(json.encode({
    "nuntius": "solucionis negotium exspectat in stagnum",
    "message": "payment transaction is waiting in the pool",
    "transactioIdentitatis": it.identitatis
  }));      
}

Future<Response> solucionisSubmittereFissileSolocionisPropter(Request req) async {
  SubmittereFissileSolucionisPropter sfsr = SubmittereFissileSolucionisPropter.fromJson(json.decode(await req.readAsString()));
  // if (sfsr.fixs.where((wf) => wf.reliquiae).length != 1) {
  //   return Response.badRequest(body: json.encode(BadRequest(code: 0, nuntius: 'certum pretium rationem habere unum superfuit receptoris', message: 'a fixed payment account should have only one left over receiver')));
  // }
  PrivateKey privatus = PrivateKey.fromHex(Pera.curve(), sfsr.solucionis);
  String publica = privatus.publicKey.toHex();
  if (sfsr.fixs.any((af) => af.accipientis == publica)) {
    return Response.badRequest(body: json.encode(BadRequest(code: 0, nuntius: 'unus accipientis claves sunt sicut finis solutionis ratio et sicut principalis oratio huius solucionis ratio', message: 'one of the receiver keys are used as a final destination of a payment account and as the main address of this payment account')));
  }
  InterioreInterioreFissileSolucionisPropter iifsp = InterioreInterioreFissileSolucionisPropter(publica, sfsr.reliquiae, sfsr.fixs);
  InterioreFissileSolucionisPropter ifsr = InterioreFissileSolucionisPropter(privatus, iifsp);
  List<Obstructionum> lo = await Obstructionum.getBlocks(Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}'));
  if (!ifsr.estValidus(lo)) {
    return Response.badRequest(body: json.encode(BadRequest(code: 0, nuntius: 'Publica clavis iam usus est ad mercedem Ratio aut est receptaculum et senior solucionis Ratio', message: 'public key is already used for a payment account or is the receiver of an older payment account')));
  }
  ReceivePort rp = ReceivePort();
  isolates.fissileSolocionisRationem[publica] = await Isolate.spawn(FissileSolucionisPropter.quaestum, List<dynamic>.from([ifsr, rp.sendPort]));
  rp.listen((solucionis) { 
    print('he! $solucionis');
    par!.syncFissileSolucionisPropter(solucionis as FissileSolucionisPropter);
  });
  return Response.ok(json.encode({
    "nuntius": "splitted mercedem ratio exspectat in stagnum",
    "message": "splitted payment account is waiting in the pool"
  }));
}
Response solucionisFissileStagnum(Request req) {
  return Response.ok(json.encode(par!.fissileSolucionisRationibus.map((mfsp) => mfsp.toJson()).toList()));
}
Future<Response> solucionisFissileCashEx(Request req) async {
  try {
    SolucionisCashEx sce = SolucionisCashEx.fromJson(await json.decode(await req.readAsString()));
    String publica = PrivateKey.fromHex(Pera.curve(), sce.ex).publicKey.toHex();
    Directory directorium = Directory('vincula/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    FissileSolucionisPropter fsp = FissileSolucionisPropter.accipere(publica, lo);
    BigInt mittere = await Pera.statera(sce.liber, publica, lo);
    List<InterioreTransactio> litf = [];
    List<Transactio> lt = sce.liber ? List<Transactio>.from(par!.liberTransactions.map((e) => Transactio.fromJson(e.toJson()))) : List<Transactio>.from(par!.fixumTransactions.map((e) => Transactio.fromJson(e.toJson())));
    List<Fixus> lf = fsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.fixs.toList();
    for (int i = 0; i < lf.length; i++) {
      InterioreTransactio it = await Pera.novamRem(necessitudo: false, liber: sce.liber, twice: false, fixusIndex: i, ts: TransactioSignificatio.fissile, ex: sce.ex, value: lf[i].pod, to: lf[i].accipientis, transactioStagnum: lt, lo: lo);
      litf.add(it);
      lt.add(Transactio.nullam(it));
      mittere -= lf[i].pod;   
    }
    litf.add(await Pera.novamRem(necessitudo: false, liber: sce.liber, twice: false, ts: TransactioSignificatio.reliquiae, ex: sce.ex, value: mittere, to: fsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.reliquiae, transactioStagnum: lt, lo: lo));
    ReceivePort rp = ReceivePort();
    if (sce.liber) {
      for (InterioreTransactio it in litf) {
        isolates.liberTxIsolates[it.identitatis] = await Isolate.spawn(Transactio.quaestum, List<dynamic>.from([it, rp.sendPort]));
      }
    } else {
      for (InterioreTransactio it in litf) {
        isolates.fixumTxIsolates[it.identitatis] = await Isolate.spawn(Transactio.quaestum, List<dynamic>.from([it, rp.sendPort]));
      }
    }
    List<Transactio> lltoo = [];
    lo.map((mo) => sce.liber ? mo.interiore.liberTransactions : mo.interiore.fixumTransactions).forEach(lltoo.addAll);
    rp.listen((transactio) {
      Transactio t = transactio as Transactio;
      if (t.interiore.inputs.every((ei) => par!.liberTransactions.any((alt) => alt.interiore.identitatis == ei.transactioIdentitatis) || lltoo.any((alt) => alt.interiore.identitatis == ei.transactioIdentitatis)) && t.interiore.liber) {
        // print('wtfwelkeliber ${par!.liberTransactions.singleWhere((sw) => sw.interioreTransactio.identitatis == )}')
        par!.syncLiberTransaction(t);        
      }
    });
    return Response.ok(json.encode({
      "nuntius": "solucionis transactions exspectant in stagnum",
      "message": "payment transactions are waiting in the pool",
      "transactioIdentitatum": litf.map((mitf) => mitf.identitatis).toList()
    }));
  } on BadRequest catch (br) {
    return Response.badRequest(body: json.encode(br.toJson()));
  }



}