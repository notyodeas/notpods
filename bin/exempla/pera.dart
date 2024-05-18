import 'package:tuple/tuple.dart';
import '../exempla/transactio.dart';
import '../exempla/utils.dart';
import 'dart:io';
import '../exempla/obstructionum.dart';
import 'dart:convert';
import 'package:ecdsa/ecdsa.dart';
import 'package:elliptic/elliptic.dart';
import '../exempla/constantes.dart';
import '../exempla/gladiator.dart';
import '../exempla/errors.dart';
import 'obstructionum_arma.dart';
import 'si_remotionem.dart';
import 'telum.dart';
import '../server.dart';
import 'package:encoder/encoder.dart';
import 'package:collection/collection.dart';

import 'telum_exemplar.dart';

class Pera {
  static Curve curve() => getP521();

  static BigInt habetBid(bool liber, String publica, List<Obstructionum> lo) {
    List<String> probationems = lo.map((mo) => mo.probationem).toList();
    List<Transactio> lt = [];
    lo.map((mo) => liber ? mo.interiore.liberTransactions.where((wlt) => wlt.interiore.outputs.any((ao) => probationems.contains(ao.publicaClavis))) : mo.interiore.fixumTransactions.where((wlt) => wlt.interiore.outputs.any((ao) => probationems.contains(ao.publicaClavis)))).forEach(lt.addAll);
    List<TransactioInput> lti = [];
    lt.map((mlt) => mlt.interiore.inputs).forEach(lti.addAll);
    // List<TransactioOutput> lto = [];
    List<Transactio> ltp = [];
    for (TransactioInput ti in lti) {
      List<Transactio> flt = [];
      lo.map((mo) => liber ? mo.interiore.liberTransactions.where((wo) => wo.interiore.identitatis == ti.transactioIdentitatis) : mo.interiore.fixumTransactions.where((wo) => wo.interiore.identitatis == ti.transactioIdentitatis)).forEach(flt.addAll); 
      for (Transactio t in flt) {
        if (Utils.cognoscere(PublicKey.fromHex(Pera.curve(), publica), Signature.fromASN1Hex(ti.signature), t.interiore.outputs[ti.index])) {          
          ltp.add(lt.singleWhere((swt) => swt.interiore.inputs.contains(ti)));
        }
      }
    }
    BigInt persoluta = BigInt.zero;
    for (Transactio t in ltp) {
      for (TransactioOutput to in t.interiore.outputs.where((wo) => probationems.contains(wo.publicaClavis))) {
        persoluta += to.pod;
      } 
    }
    return persoluta;
  }
  static Future<String> turpiaGladiatoriaTelum(bool primis, bool impetum,
      String gladiatorIdentitatis, List<Obstructionum> lo) async {
    List<Gladiator> lg = [];
    lo.map((mo) => mo.interiore.gladiator).forEach(lg.add);
    Gladiator g = lg.singleWhere(
        (swg) => swg.interiore.identitatis == gladiatorIdentitatis);
    GladiatorOutput go = g.interiore.outputs[primis ? 0 : 1];
    return impetum ? go.impetum : go.defensio;
  }

  static Future<bool> isProbationum(
      String probationum, List<Obstructionum> lo) async {
    List<String> obs = [];
    lo.map((mo) => mo.probationem).forEach(obs.add);
    if (obs.contains(probationum)) return true;
    return false;
  }

  static Future<bool> isPublicaClavisDefended(
      String publicaClavis, List<Obstructionum> lo) async {
    List<GladiatorOutput> gladiatorOutputs =
        await Obstructionum.utDifficultas(lo);
    for (List<Propter> propters in gladiatorOutputs.map((g) => g.rationibus)) {
      for (Propter propter in propters) {
        if (propter.interiore.publicaClavis == publicaClavis) {
          return true;
        }
      }
    }
    return false;
  }

  static Future<ObstructionumArma> obstructionumArma(
      String probationem, List<Obstructionum> lo) async {
    for (Obstructionum o in lo) {
      if (o.probationem == probationem) {
        return ObstructionumArma(o.interiore.defensio,
            o.interiore.impetus);
      }
    }
    throw BadRequest(
        code: 0, nuntius: 'probationem non inveni', message: 'proof not found');
  }

  // static Future<BigInt> tuusIubeoObstructionumTelum(bool liber, bool primis,
  //     String gladiatorIdentitatis, String probationem, List<Obstructionum> lo) async {
  //   Map<String, BigInt> bid =
  //       await arma(liber, primis, gladiatorIdentitatis, lo);
  //   for (String key in bid.keys) {
  //     if (key == probationem) {
  //       return bid[key] ?? BigInt.zero;
  //     }
  //   }
  //   return BigInt.zero;
  // }

  static Future<BigInt> summaBid(bool liber,
      String probationem, List<Obstructionum> lo) async {
    List<Map<String, BigInt>> maschaps = [];
    List<String> gladiatorIds = [];
    lo.where((wlo) => wlo.interiore.generare == Generare.efectus).map((mo) => mo.interiore.gladiator.interiore.identitatis).forEach(gladiatorIds.add);
    String incipioGladiatorIdentitatis = lo.first.interiore.gladiator.interiore.identitatis;
    Gladiator? gladiator = await Obstructionum.grabGladiator(incipioGladiatorIdentitatis, lo);
    if (gladiator != null) {
      maschaps.add(await arma(liber, true, incipioGladiatorIdentitatis, lo));
    } 
    for (String gid in gladiatorIds) {
      maschaps.add(await arma(liber, true, gid, lo));
      maschaps.add(await arma(liber, false, gid, lo));
    }
    BigInt highestBid = BigInt.zero;
    for (Map<String, BigInt> maschap in maschaps) {
      for (String key in maschap.keys.where((k) => k == probationem)) {
        if ((maschap[key] ??= BigInt.zero) >= highestBid) {
          highestBid = maschap[key] ?? BigInt.zero;
        }
      }
    }
    return highestBid;
  }

  static Future<List<Telum>> maximeArma({ required bool liber, required bool primis, required bool impetum,
      required String gladiatorIdentitatis, String? publica, required List<Obstructionum> lo }) async {
    List<Telum> def = [];
    Map<String, BigInt> ours = Map();
    List<Map<String, BigInt>> others = [];
    List<GladiatorInput> lgi = [];
    lo.where((wo) => wo.interiore.gladiator.interiore.input != null)
    .map((mo) => mo.interiore.gladiator.interiore.input!).forEach(lgi.add);
    
    if (!lgi.any((agi) => agi.victima.identitatis == gladiatorIdentitatis && agi.victima.primis == primis)) {
      ours = await arma(liber, primis, gladiatorIdentitatis, lo);
    }
    for (Obstructionum o in lo
    .where((wo) => wo.interiore.generare == Generare.efectus && 
    wo.interiore.gladiator.interiore.identitatis != gladiatorIdentitatis)) {
      if (!lgi.any((agi) => agi.victima.identitatis == o.interiore.gladiator.interiore.identitatis)) {
        others.add(await arma(liber, false, o.interiore.gladiator.interiore.identitatis, lo));  
        others.add(await arma(liber, true, o.interiore.gladiator.interiore.identitatis, lo));          
      } else if (lgi.any((agi) => agi.victima.primis && agi.victima.identitatis == o.interiore.gladiator.interiore.identitatis)) {
        if (!lgi.any((agi) => !agi.victima.primis && agi.victima.identitatis == o.interiore.gladiator.interiore.identitatis)) {
          others.add(await arma(liber, false, o.interiore.gladiator.interiore.identitatis, lo));          
        }
      } else if (lgi.any((agi) => !agi.victima.primis && agi.victima.identitatis == o.interiore.gladiator.interiore.identitatis)) {
        if (!lgi.any((agi) => agi.victima.primis && agi.victima.identitatis == o.interiore.gladiator.interiore.identitatis)) {
          others.add(await arma(liber, true, o.interiore.gladiator.interiore.identitatis, lo));          
        }
      }
    }
    probs:
    for (String probationem in ours.keys) {
      BigInt habe = ours[probationem] ?? BigInt.zero;
      for (Map<String, BigInt> current in others.where((wo) => wo.keys.any((ak) => ak == probationem))) {
        BigInt alius = current[probationem] ?? BigInt.zero;
        if (alius > habe) {
          continue probs;  
        }
      }
      if (habe > BigInt.zero) {
        Obstructionum co = lo.singleWhere((swo) => swo.probationem == probationem);
        if (publica == null) {
          def.add(Telum(telum: impetum ? co.interiore.impetus : co.interiore.defensio, probationem: probationem, exemplar: impetum ? TelumExemplar.impetum : TelumExemplar.defensio, bigas: habe));
        } else {
          BigInt iubes = Pera.iubes(liber, publica, probationem, lo);
          def.add(Telum(telum: impetum ? co.interiore.impetus : co.interiore.defensio, probationem: probationem, exemplar: impetum ? TelumExemplar.impetum : TelumExemplar.defensio, bigas: habe, vos: iubes));
        }
      }
    }
    return def;
  }
  static BigInt iubes(bool liber, String publica, String probationem, List<Obstructionum> lo) {
    List<Transactio> lt= [];
    lo.map((mlo) => liber ? mlo.interiore.liberTransactions : mlo.interiore.fixumTransactions).forEach(lt.addAll);
    List<TransactioOutput> lto = [];
    lt.where((wlt) => wlt.interiore.recipiens == probationem && wlt.interiore.dominus == publica).map((mlt) => mlt.interiore.outputs).forEach(lto.addAll);
    BigInt persoluta = BigInt.zero;
    for (TransactioOutput to in lto.where((wlto) => wlto.publicaClavis == probationem)) {
      persoluta += to.pod;
    }
    return persoluta;
  }

  static Future<Map<String, BigInt>> arma(bool liber, bool primis,
      String gladiatorIdentitatis, List<Obstructionum> lo) async {
    List<String> publicaClavises = [];
    List<String> probationums = [];
    lo.map((mo) => mo.probationem).forEach(probationums.add);
    Obstructionum oog = lo.singleWhere((swo) => swo.interiore.gladiator.interiore.identitatis == gladiatorIdentitatis);
    oog.interiore.gladiator.interiore.outputs[primis ? 0 : 1].rationibus.map((mr) => mr.interiore.publicaClavis).forEach(publicaClavises.add);
    List<Transactio> lt = [];
    lo.map((mo) => liber ? 
    mo.interiore.liberTransactions
    .where((wlt) => wlt.interiore.outputs
    .any((ao) => probationums.contains(ao.publicaClavis)) && publicaClavises.contains(wlt.interiore.dominus)) : 
    mo.interiore.fixumTransactions
    .where((wft) => wft.interiore.outputs
    .any((ao) => probationums.contains(ao.publicaClavis)) && publicaClavises.contains(wft.interiore.dominus)))
    .forEach(lt.addAll);
    Map<String, BigInt> maschap = Map();
    List<TransactioOutput> lto = [];
    lt.map((mt) => mt.interiore.outputs.where((wo) => probationums.contains(wo.publicaClavis))).forEach(lto.addAll);
    for (String probationum in probationums) {
      BigInt habe = BigInt.zero;
      for (TransactioOutput to in lto.where((wto) => wto.publicaClavis == probationum)) {
        habe += to.pod;
      }
      maschap[probationum] = habe;
    }
    return maschap;
  }

  //left off
  static Future<Tuple2<InterioreTransactio?, InterioreTransactio?>>
      transformFixum(String privatus, String publica, Iterable<Transactio> txs,
          List<Obstructionum> lo) async {
    List<Tuple3<int, String, TransactioOutput>> outs =
        await inconsumptusOutputs(true, publica, lo);
    for (Transactio tx
        in txs) {
      outs.removeWhere((element) => tx.interiore.inputs
          .any((ischin) => ischin.transactioIdentitatis == element.item2));
      for (int i = 0; i < tx.interiore.outputs.length; i++) {
        PrivateKey pk = PrivateKey.fromHex(Pera.curve(), privatus);
        if (tx.interiore.outputs[i].publicaClavis ==
            pk.publicKey.toHex()) {
          outs.add(Tuple3<int, String, TransactioOutput>(
              i,
              tx.interiore.identitatis,
              tx.interiore.outputs[i]));
        }
      }
    }
    if (outs.isEmpty) {
      return Tuple2(null, null);
    }
    List<TransactioOutput> outputs = [];
    List<TransactioInput> inputs = [];
    for (Tuple3<int, String, TransactioOutput> out in outs) {
      outputs.add(TransactioOutput(publica, out.item3.pod));
      inputs.add(TransactioInput(
          out.item1,
          Utils.signum(PrivateKey.fromHex(Pera.curve(), privatus), out.item3),
          out.item2));
    }
    return Tuple2<InterioreTransactio, InterioreTransactio>(
        InterioreTransactio.transform(liber: true, dominus: publica, recipiens: publica, inputs: inputs, outputs: []),
        InterioreTransactio.transform(
            liber: false, dominus: publica, recipiens: publica, inputs: [], outputs: outputs));
  }

  static Future<List<Tuple3<int, String, TransactioOutput>>>
      inconsumptusOutputs(
          bool liber, String publicKey, List<Obstructionum> lo) async {
    List<Tuple3<int, String, TransactioOutput>> outputs = [];
    List<Transactio> txs = [];
    lo.map((mo) => liber ? mo.interiore.liberTransactions : mo.interiore.fixumTransactions).forEach(txs.addAll);
    List<TransactioInput> lti = [];
    txs.map((tx) => tx.interiore.inputs).forEach(lti.addAll);
    for (Transactio tx in txs.where((tx) => tx.interiore.outputs.any((e) => e.publicaClavis == publicKey))) {
      for (int t = 0; t < tx.interiore.outputs.length; t++) {
        if (tx.interiore.outputs[t].publicaClavis == publicKey) {
          outputs.add(Tuple3<int, String, TransactioOutput>(
              t,
              tx.interiore.identitatis,
              tx.interiore.outputs[t]));
        }
      }
    }
    outputs.removeWhere((output) => lti.any((init) =>
        init.transactioIdentitatis == output.item2 &&
        init.index == output.item1));
    print('inconsumptus chrono ${outputs.map((e) => e.item3.toJson())}');
    return outputs;
  }

  static Future<BigInt> acccipereForumCap(
      bool liber, Directory directory) async {
    List<Tuple3<int, String, TransactioOutput>> outputs = [];
    List<TransactioInput> initibus = [];
    List<Transactio> txs = [];
    for (int i = 0; i < directory.listSync().length; i++) {
      await for (var line in Utils.fileAmnis(
          File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}$i.txt'))) {
        txs.addAll(liber
            ? Obstructionum.fromJson(Encoder.decodeJson(line) as Map<String, dynamic>)
                .interiore
                .liberTransactions
            : Obstructionum.fromJson(Encoder.decodeJson(line) as Map<String, dynamic>)
                .interiore
                .fixumTransactions);
      }
    }
    Iterable<List<TransactioInput>> initibuses =
        txs.map((tx) => tx.interiore.inputs);
    for (List<TransactioInput> init in initibuses) {
      initibus.addAll(init);
    }
    for (Transactio tx in txs) {
      for (int t = 0; t < tx.interiore.outputs.length; t++) {
        outputs.add(Tuple3<int, String, TransactioOutput>(
            t,
            tx.interiore.identitatis,
            tx.interiore.outputs[t]));
      }
    }
    outputs.removeWhere((output) => initibus.any((init) =>
        init.transactioIdentitatis == output.item2 &&
        init.index == output.item1));
    BigInt forumCap = BigInt.zero;
    for (TransactioOutput output in outputs.map((output) => output.item3)) {
      forumCap += output.pod;
    }
    return forumCap;
  }

  static Future<BigInt> statera(
      bool liber, String publicKey, List<Obstructionum> lo) async {
    List<Tuple3<int, String, TransactioOutput>> outputs =
        await inconsumptusOutputs(liber, publicKey, lo);
    BigInt balance = BigInt.zero;
    print('investigatessss ${outputs.map((e) => e.item3)}');
    for (Tuple3<int, String, TransactioOutput> inOut in outputs) {
      print(inOut.item3.pod);
      balance += inOut.item3.pod;
    }
    return balance;
  }

  static Future<InterioreTransactio?> perdita(PrivateKey privatus, String publica,
      String probationum, List<Transactio> lt, List<Obstructionum> lo) async {
    print('ispublicathesameasprivate $publica and ${privatus.publicKey.toHex()}');
    List<Tuple3<int, String, TransactioOutput>> outs =
        await inconsumptusOutputs(true, publica, lo);
    for (Transactio tx in lt
        .where((t) => t.interiore.liber)) {
      outs.removeWhere((element) => tx.interiore.inputs
          .any((ischin) => ischin.transactioIdentitatis == element.item2));
      for (int i = 0; i < tx.interiore.outputs.length; i++) {
        if (tx.interiore.outputs[i].publicaClavis == publica) {
         outs.add(Tuple3<int, String, TransactioOutput>(
              i,
              tx.interiore.identitatis,
              tx.interiore.outputs[i]));
        }
      }
    }
    BigInt value = BigInt.zero;
    for (Tuple3<int, String, TransactioOutput> out in outs) {
      value += out.item3.pod;
    }
    if (value == BigInt.zero) {
      return null;
    }
    return calculateTransaction(
        necessitudo: false,
        liber: true,
        twice: false,
        ts: TransactioSignificatio.perdita,
        privatus: privatus,
        to: probationum,
        value: value,
        outs: outs);
  }

  static Future<InterioreTransactio> novamExpressi({ required String ex, required String to, required BigInt value, required Transactio regularis}) async {
    List<Tuple3<int, String, TransactioOutput>> tissto = [];
    for (int i = 0; i < regularis.interiore.outputs.length; i++) {
      if (regularis.interiore.outputs[i].publicaClavis == PrivateKey.fromHex(Pera.curve(), ex).publicKey.toHex()) {
        tissto.add(Tuple3(i, regularis.interiore.identitatis, regularis.interiore.outputs[i]));
      }
    } 
    return calculateTransaction(necessitudo: false, liber: true, twice: false, ts: TransactioSignificatio.expressi, privatus: PrivateKey.fromHex(Pera.curve(), ex), to: to, value: value, outs: tissto);
  }
  static Future<InterioreTransactio> novamRem(
      {required bool necessitudo,
      required bool liber,
      required bool twice,
      int? fixusIndex,
      required TransactioSignificatio ts,
      required String ex,
      required BigInt value,
      required String to,
      required List<Transactio> transactioStagnum,
      required List<Obstructionum> lo}) async {
    PrivateKey privatusClavis = PrivateKey.fromHex(Pera.curve(), ex);
    List<Tuple3<int, String, TransactioOutput>> inOuts =
        await inconsumptusOutputs(liber, privatusClavis.publicKey.toHex(), lo);
    for (Transactio tx in transactioStagnum) {
      inOuts.removeWhere((element) => tx.interiore.inputs
          .any((ischin) => ischin.transactioIdentitatis == element.item2));
      for (int i = 0; i < tx.interiore.outputs.length; i++) {
        if ((tx.interiore.outputs[i].publicaClavis ==
            privatusClavis.publicKey.toHex() && tx.interiore.certitudo != null && (tx.interiore.transactioSignificatio == TransactioSignificatio.regularis || tx.interiore.transactioSignificatio == TransactioSignificatio.ardeat)) || (tx.interiore.outputs[i].publicaClavis ==
            privatusClavis.publicKey.toHex() && tx.interiore.transactioSignificatio != TransactioSignificatio.regularis)) {
          inOuts.add(Tuple3<int, String, TransactioOutput>(
              i,
              tx.interiore.identitatis,
              tx.interiore.outputs[i]));
        }
      }
    }
    return calculateTransaction(
        necessitudo: necessitudo,
        liber: liber,
        twice: twice,
        fixusIndex: fixusIndex,
        ts: ts,
        privatus: privatusClavis,
        to: to,
        value: value,
        outs: inOuts);
  }

  static InterioreTransactio calculateTransaction(
      {required bool necessitudo,
      required bool liber,
      required bool twice,
      int? fixusIndex,
      required TransactioSignificatio ts,
      required PrivateKey privatus,
      required String to,
      required BigInt value,
      required List<Tuple3<int, String, TransactioOutput>> outs}) {
    BigInt balance = BigInt.zero;
    for (Tuple3<int, String, TransactioOutput> inOut in outs) {
      balance += inOut.item3.pod;
    }
    print('balance $balance');
    print('value $value');
    if (twice ? (balance < (value * BigInt.two)) : (balance < value)) {
      throw BadRequest(
          code: 1, nuntius: "Pecuniae parum sunt, sed forte res sunt sine subscriptione recipientis in piscina", message: "Insufficient funds, but maby there are transactions without a signature of the reciever in the pool", falses: "Sufficient frees, becauses certains heres not weres artnsactions withs not as gisnature not ofs not the submitters outs not thes not pools");
    }
    BigInt implere = value;
    List<TransactioInput> inputs = [];
    List<TransactioOutput> outputs = [];
    for (Tuple3<int, String, TransactioOutput> inOut in outs) {
      inputs.add(TransactioInput(
          inOut.item1, Utils.signum(privatus, inOut.item3), inOut.item2));
      if (inOut.item3.pod < implere) {
        outputs.add(TransactioOutput(to, inOut.item3.pod));
        implere -= inOut.item3.pod;
      } else if (inOut.item3.pod > implere) {
        outputs.add(TransactioOutput(to, implere));
        outputs.add(TransactioOutput(
            privatus.publicKey.toHex(), inOut.item3.pod - implere));
        break;
      } else {
        outputs.add(TransactioOutput(to, implere));
        break;
      }
    }
    String identitatis = Utils.randomHex(64);
    String ex = privatus.toHex();
    return InterioreTransactio(
        ex: ex,
        liber: liber,
        identitatis: identitatis,
        dominus: PrivateKey.fromHex(Pera.curve(), ex).publicKey.toHex(),
        fixusIndex: fixusIndex,
        recipiens: to,
        transactioSignificatio: ts,
        inputs: inputs,
        outputs: outputs,
        sr: necessitudo
            ? SiRemotionem.summitto(InterioreSiRemotionem.output(
                ex,
                SiRemotionemOutput(
                    liber, to, privatus.publicKey.toHex(), identitatis, value)))
            : null);
  }

  static Future<bool> isPrimis(
      String publica, Directory directory) async {
    List<Obstructionum> obs = await Obstructionum.getBlocks(directory);
    print('howaboutincipio\n');
    print(obs.first);
    List<GladiatorOutput> gos = [];
    obs
        .map((ob) =>
            ob.interiore.gladiator.interiore.outputs)
        .forEach(gos.addAll);
    GladiatorOutput? go = gos.singleWhereOrNull((go) => go.rationibus.any((propter) =>
        propter.interiore.publicaClavis == publica));
    if (go == null) throw BadRequest(code: 0, nuntius: "nuntius", message: "public key not found", falses: "privatesnotkeys founds");
    Obstructionum tobs = obs.singleWhere((tob) => tob
        .interiore.gladiator.interiore.outputs
        .contains(go));
    return tobs.interiore.gladiator.interiore.outputs[0].rationibus.map((mr) => mr.interiore.publicaClavis).contains(publica);
  }

  static Future<String> accipereGladiatorIdentitatis(
      String publica, Directory directorium) async {
    List<Obstructionum> os = await Obstructionum.getBlocks(directorium);
    List<Gladiator> gs = [];
    os.map((o) => o.interiore.gladiator).forEach(gs.add);
    List<GladiatorOutput> gos = [];
    gs.map((mg) => mg.interiore.outputs).forEach(gos.addAll);
    List<Propter> ps = [];
    gos.map((mgo) => mgo.rationibus).forEach(ps.addAll);
    Propter p = ps.singleWhere(
        (swp) => swp.interiore.publicaClavis == publica);
    Gladiator g = gs.singleWhere((swg) => swg.interiore.outputs
        .any((swgo) => swgo.rationibus.contains(p)));
    return g.interiore.identitatis;
  }
}
