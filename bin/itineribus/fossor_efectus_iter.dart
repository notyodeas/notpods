import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:elliptic/elliptic.dart';
import 'dart:isolate';
import '../auxiliatores/fossor_praecipuus.dart';
import '../exempla/constantes.dart';
import '../exempla/errors.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/si_remotionem.dart';
import '../exempla/transactio.dart';
import '../server.dart';


Future<Response> fossorEfectus(Request req) async {
  Directory directorium =
      Directory('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
  bool estFurca = bool.parse(req.params['furca']!);
  String privatus = req.params['privatus']!;
  if (PrivateKey.fromHex(Pera.curve(), privatus).publicKey.toHex() != argumentis!.publicaClavis) {
    return Response.badRequest(body: json.encode(BadRequest(code: 0, nuntius: 'non habes ius truncum in hac nodo producendi', message: 'you do not have the right to produce a block on this node')));
  }
  List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
  if (!await Pera.isPublicaClavisDefended(argumentis!.publicaClavis, lo)) {
    return Response.badRequest(body: json.encode(BadRequest(code: 1, nuntius: 'non potest meus esse efectus, quia productor tuus clavis non defenditur', message: 'can not mine an efectus, because your producer key is not defended ')));
  }
  FossorPraecipuus fp = FossorPraecipuus();
  fp.accipere(    
    efectus: true, 
    maxime: 1000, 
    llt: par!.liberTransactions, 
    lft: par!.fixumTransactions, 
    let: par!.expressiTransactions, 
    lcle: par!.connexiaLiberExpressis, 
    lsr: par!.siRemotiones, 
    lp: par!.rationibus, 
    lsp: par!.solucionisRationibus, 
    lfsp: par!.fissileSolucionisRationibus, 
    lit: par!.inritaTransactions,
    lo: lo
  );
  print(fp.lptbi);
  Obstructionum incipio = await Obstructionum.accipereIncipio(directorium);
  fp.llttbi.insert(0, Transactio.nullam(InterioreTransactio.praemium(argumentis!.publicaClavis, incipio.interiore.praemium!)));
  final obstructionumDifficultas = await Obstructionum.utDifficultas(lo);
  List<int> on = await Obstructionum.utObstructionumNumerus(lo.last);
  BigInt numerus = await Obstructionum.numeruo(on);
  Obstructionum prior =
  await Obstructionum.acciperePrior(directorium);
  for (SiRemotionem sr in fp.lsrtbi.where((wlsr) => wlsr.interiore.siRemotionemInput != null)) {
    sr.interiore.siRemotionemInput!.interioreTransactio = null;
  }
  ReceivePort rp = ReceivePort();
  InterioreObstructionum interiore = InterioreObstructionum.efectus(
    estFurca: estFurca,
    obstructionumDifficultas: obstructionumDifficultas.length,
    divisa: numerus / await Obstructionum.utSummaDifficultas(lo),
    forumCap: await Obstructionum.accipereForumCap(lo),
    liberForumCap: await Obstructionum.accipereForumCapLiberFixum(true, lo),
    fixumForumCap: await Obstructionum.accipereForumCapLiberFixum(false, lo),
    summaObstructionumDifficultas: await Obstructionum.utSummaDifficultas(lo),
    obstructionumNumerus: on,
    producentis: argumentis!.publicaClavis,
    priorProbationem: prior.probationem,
    gladiator: Gladiator.nullam(InterioreGladiator.efectus(
        outputs: InterioreGladiator.egos(fp.lptbi))),
    liberTransactions: fp.llttbi,
    fixumTransactions: fp.lfttbi,
    expressiTransactions: fp.lettbi,
    connexaLiberExpressis: fp.lcletbi,
    siRemotiones: fp.lsrtbi,
    solucionisRationibus: fp.lsptbi,
    fissileSolucionisRationibus: fp.lfsptbi,
    inritaTransactions: fp.littbi,
    prior: prior);
    stamina.efectusThreads.add(await Isolate.spawn(Obstructionum.efectus,
      List<dynamic>.from([interiore, rp.sendPort])));
  rp.listen((nuntius) async {
    Obstructionum obstructionum = nuntius as Obstructionum;
    stamina.efectusThreads.forEach((et) => et.kill());
    await par!.syncBlock(obstructionum);
  });
  return Response.ok(json.encode({
    "nuntius": "coepi efectus fossores",
    "message": "started efectus miner",
    "threads": stamina.efectusThreads.length
  }));
}


Future<Response> efectusThreads(Request req) async {
  return Response.ok(json.encode({
    "relatorum": stamina.efectusThreads.length,
    "threads": stamina.efectusThreads.length
  }));
}

Future<Response> prohibereEfectus(Request req) async {
  for (int i = 0; i < stamina.efectusThreads.length; i++) {
    stamina.efectusThreads[i].kill(priority: Isolate.immediate);
  }
  return Response.ok(json.encode({
    "nuntius": "bene substitit efectus miner",
    "message": "succesfully stopped efectus miner",
  }));
}
