import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:isolate';
import 'package:hex/hex.dart';
import 'package:tuple/tuple.dart';
import '../auxiliatores/print.dart';
import '../server.dart';
import './utils.dart';
import './obstructionum.dart';
import 'package:elliptic/elliptic.dart';
import 'package:ecdsa/ecdsa.dart';
import './pera.dart';
import './constantes.dart';
import 'package:collection/collection.dart';
import 'package:encoder/encoder.dart';
import 'si_remotionem.dart';
import 'solucionis_propter.dart';


enum TransactioSignificatio {
  regularis,
  ardeat,
  transform,
  praemium,
  expressi,
  refugium,
  perdita,
  solucionis,
  fissile,
  reliquiae
}

extension TransactioSignificatioFromJson on TransactioSignificatio {
  static fromJson(String name) {
    switch (name) {
      case 'regularis':
        return TransactioSignificatio.regularis;
      case 'ardeat':
        return TransactioSignificatio.ardeat;
      case 'transform':
        return TransactioSignificatio.transform;
      case 'praemium':
        return TransactioSignificatio.praemium;
      case 'expressi':
        return TransactioSignificatio.expressi;
      case 'refugium':
        return TransactioSignificatio.refugium;
      case 'perdita': return TransactioSignificatio.perdita;
      case 'solucionis': return TransactioSignificatio.solucionis;
      case 'fissile': return TransactioSignificatio.fissile;
      case 'reliquiae': return TransactioSignificatio.reliquiae;
    }
  }
}

enum TransactioGenus { liber, fixum, expressi }

extension TransactioGenusFromJson on TransactioGenus {
  static fromJson(String name) {
    switch (name) {
      case 'liber': return TransactioGenus.liber;
      case 'fixum': return TransactioGenus.fixum;
      case 'expressi': return TransactioGenus.expressi;
      // case 'profundum': return TransactioGenus.profundum;
    }
  }
}

class TransactioInput {
  final int index;
  final String signature;
  final String transactioIdentitatis;
  TransactioInput(this.index, this.signature, this.transactioIdentitatis);
  Map<String, dynamic> toJson() => {
        JSON.index: index,
        JSON.signature: signature,
        JSON.transactioIdentitatis: transactioIdentitatis
      };
  TransactioInput.fromJson(Map<String, dynamic> jsoschon)
      : index = int.parse(jsoschon[JSON.index].toString()),
        signature = jsoschon[JSON.signature].toString(),
        transactioIdentitatis = jsoschon[JSON.transactioIdentitatis].toString();
}

class TransactioOutput {
  final String publicaClavis;
  final BigInt pod;
  TransactioOutput(this.publicaClavis, this.pod);
  TransactioOutput.praemium(this.publicaClavis, this.pod);

  Map<String, dynamic> toJson() => {
        JSON.publicaClavis: publicaClavis,
        JSON.pod: pod.toString(),
      }..removeWhere((key, value) => value == null);
  TransactioOutput.fromJson(Map<String, dynamic> jsoschon)
      : publicaClavis = jsoschon[JSON.publicaClavis].toString(),
        pod = BigInt.parse(jsoschon[JSON.pod].toString());
}

class InterioreTransactio {
  final bool liber;
  final TransactioSignificatio transactioSignificatio;
  SiRemotionem? siRemotionem;
  final List<TransactioInput> inputs;
  final List<TransactioOutput> outputs;
  final String identitatis;
  final String dominus;
  final String recipiens;
  String? certitudo;
  BigInt nonce;
  int? fixusIndex;
  InterioreTransactio(
      {required String ex,
      required this.liber,
      required this.identitatis,
      required this.dominus,
      required this.recipiens,
      required this.transactioSignificatio,
      required this.inputs,
      this.fixusIndex,
      required this.outputs,
      SiRemotionem? sr})
      : nonce = BigInt.zero,
        siRemotionem = sr;

  InterioreTransactio.praemium(String producentis, BigInt praemium)
      : liber = true,
        transactioSignificatio = TransactioSignificatio.praemium,
        nonce = BigInt.zero,
        siRemotionem = null,
        inputs = [],
        outputs = [TransactioOutput.praemium(producentis, praemium)],
        identitatis = Utils.randomHex(64),
        dominus = producentis,
        recipiens = producentis;

  InterioreTransactio.transform({
    required bool liber,
    required this.dominus,
    required this.recipiens,
    required this.inputs,
    required this.outputs,
  })  : liber = liber,
        transactioSignificatio = TransactioSignificatio.transform,
        siRemotionem = null,
        nonce = BigInt.zero,
        identitatis = Utils.randomHex(64);


  Map<String, dynamic> toJson() => {
        JSON.liber: liber,
        JSON.transactioSignificatio: transactioSignificatio.name.toString(),
        JSON.fixusIndex: fixusIndex,
        JSON.inputs: inputs.map((i) => i.toJson()).toList(),
        JSON.outputs: outputs.map((o) => o.toJson()).toList(),
        JSON.identitatis: identitatis,
        JSON.dominus: dominus,
        JSON.recipiens: recipiens,
        JSON.certitudo: certitudo,
        JSON.nonce: nonce.toString(),
        JSON.siRemotionem: siRemotionem?.toJson()
      }..removeWhere((key, value) => value == null);
  InterioreTransactio.fromJson(Map<String, dynamic> jsoschon)
      : liber = jsoschon[JSON.liber],
        transactioSignificatio = TransactioSignificatioFromJson.fromJson(
                jsoschon[JSON.transactioSignificatio].toString())
            as TransactioSignificatio,
        fixusIndex = jsoschon[JSON.fixusIndex].toString() == 'null' ? null : jsoschon[JSON.fixusIndex],
        siRemotionem = jsoschon[JSON.siRemotionem].toString() == 'null'
            ? null
            : SiRemotionem.fromJson(
                jsoschon[JSON.siRemotionem] as Map<String, dynamic>),
        inputs = List<TransactioInput>.from((jsoschon[JSON.inputs]
                as List<dynamic>)
            .map((i) => TransactioInput.fromJson(i as Map<String, dynamic>))),
        outputs = List<TransactioOutput>.from(jsoschon[JSON.outputs]
            .map((o) => TransactioOutput.fromJson(o as Map<String, dynamic>))),
        identitatis = jsoschon[JSON.identitatis].toString(),
        dominus = jsoschon[JSON.dominus].toString(),
        recipiens = jsoschon[JSON.recipiens].toString(),
        certitudo = jsoschon[JSON.certitudo].toString() == 'null' ? null : jsoschon[JSON.certitudo].toString(),
        nonce = BigInt.parse(jsoschon[JSON.nonce].toString());

  mine() {
    nonce += BigInt.one;
  }
}


class Transactio {
  // bool capta;
  late String probationem;
  final InterioreTransactio interiore;
  Transactio(this.probationem, this.interiore);
  Transactio.fromJson(Map<String, dynamic> jsoschon)
      : probationem = jsoschon[JSON.probationem].toString(),
        interiore = InterioreTransactio.fromJson(
            jsoschon[JSON.interiore] as Map<String, dynamic>);
  Transactio.nullam(this.interiore)
      : probationem = HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interiore.toJson())))
            .bytes);
  Transactio.praemium(String producentis, BigInt praemium)
      : interiore = InterioreTransactio.praemium(producentis, praemium) {
    probationem = HEX.encode(sha512
        .convert(utf8.encode(Encoder.encodeJson(interiore.toJson())))
        .bytes);
  }
  static void quaestum(List<dynamic> argumentis) {
    InterioreTransactio interiore = argumentis[0] as InterioreTransactio;
    SendPort mitte = argumentis[1] as SendPort;
    String probationem = '';
    int zeros = 1;
    while (true) {
      do {
        interiore.mine();
        probationem = HEX.encode(
            sha512.convert(utf8.encode(Encoder.encodeJson(interiore.toJson()))).bytes);
      } while (!probationem.startsWith('0' * zeros));
      for (int i = zeros + 1; i < probationem.length; i++) {
        if (probationem.substring(0, i) == ('0' * i)) {
          zeros += 1;          
        } else {
          break;
        }
      }
      zeros += 1;
      mitte.send(Transactio(probationem, interiore));
    }
  }
  bool validateBlockreward(Obstructionum incipio) {
    if (interiore.outputs.length != 1) {
      return false;
    }
    if (interiore.outputs[0].pod !=
        incipio.interiore.praemium) {
      return false;
    }
    if (interiore.inputs.isNotEmpty) {
      return false;
    }
    return true;
  }

  Future<bool> validateBurn(Directory dir) async {
    List<Obstructionum> obs = await Obstructionum.getBlocks(dir);
    BigInt spendable = BigInt.zero;
    for (TransactioInput input in interiore.inputs) {
      Obstructionum prevObs = obs.singleWhere((ob) =>
          ob.interiore.liberTransactions.any((liber) =>
              liber.interiore.identitatis ==
              input.transactioIdentitatis));
      TransactioOutput output = prevObs.interiore.liberTransactions
          .singleWhere((liber) =>
              liber.interiore.identitatis ==
              input.transactioIdentitatis)
          .interiore
          .outputs[input.index];
      spendable = output.pod;
    }
    BigInt spended = BigInt.zero;
    for (TransactioOutput output in interiore.outputs) {
      spended += output.pod;
    }
    if (spendable > spended) {
      return false;
    }
    return true;
  }

  static Future<bool> validateArdeat(
      List<TransactioInput> tins, List<Obstructionum> lo) async {
    List<List<TransactioOutput>> toss = [];
    lo
        .map((obs) => obs.interiore.liberTransactions
            .where((lt) =>
                lt.interiore.transactioSignificatio ==
                    TransactioSignificatio.ardeat &&
                tins
                    .map((ti) => ti.transactioIdentitatis)
                    .contains(lt.interiore.identitatis))
            .map((lt) => lt.interiore.outputs))
        .forEach(toss.addAll);
    List<int> tii = tins.map((ti) => ti.index).toList();
    List<String> publicaClavises = [];
    for (List<TransactioOutput> tos in toss) {
      for (int i = 0; i < tii.length; i++) {
        publicaClavises.add(tos[tii[i]].publicaClavis);
      }
    }
    List<Tuple2<String, BigInt>> ssb = [];
    for (List<TransactioOutput> tos in toss) {
      for (int i = 0; i < tii.length; i++) {
        ssb.add(Tuple2(tos[tii[i]].publicaClavis, tos[tii[i]].pod));
      }
    }
    List<String> pcs = [];
    List<Tuple2<String, BigInt>> lsssb = [];
    for (int i = 0; i < lsssb.length; i++) {
      if (!pcs.contains(lsssb[i].item1)) {
        pcs.add(lsssb[i].item1);
        lsssb.add(Tuple2(lsssb[i].item1, lsssb[i].item2));
      } else {
        BigInt sta =
            lsssb.singleWhere((pc) => pc.item1 == lsssb[i].item1).item2 +
                lsssb[i].item2;
        lsssb.removeAt(i);
        lsssb.add(Tuple2(lsssb[i].item1, sta));
      }
    }
    for (Tuple2<String, BigInt> sssb in lsssb) {
      if (sssb.item2 == await Pera.statera(true, sssb.item1, lo)) {
        continue;
      } else {
        return false;
      }
    }
    return true;
  }

  bool isFurantur() {
    return interiore.outputs
        .any((element) => element.pod < BigInt.zero);
  }

  bool estDominus(Iterable<Transactio> llt, List<Obstructionum> lo) {
    List<Transactio> lltc = List<Transactio>.from(llt.map((mo) => Transactio.fromJson(mo.toJson())));
    lo.map((mo) => interiore.liber ? mo.interiore.liberTransactions.where((wlt) => interiore.inputs.any((ai) => ai.transactioIdentitatis == wlt.interiore.identitatis)) : mo.interiore.fixumTransactions.where((wft) => interiore.inputs.any((ai) => ai.transactioIdentitatis ==  wft.interiore.identitatis))).forEach(lltc.addAll); 
    print('lltcshoudlhaveitbutdidnot \n ${lltc.map((e) => e.toJson())}');
    return interiore.inputs.every((ei) => Utils.cognoscere(PublicKey.fromHex(Pera.curve(), interiore.dominus), Signature.fromASN1Hex(ei.signature), lltc.singleWhere((swlt) => swlt.interiore.identitatis == ei.transactioIdentitatis).interiore.outputs[ei.index]));
  }
  bool minusQuamBidInProbationibus(Iterable<Transactio> lt, List<Obstructionum> lo) {
    if (interiore.transactioSignificatio == TransactioSignificatio.regularis || interiore.transactioSignificatio == TransactioSignificatio.refugium) {
        BigInt impendio = BigInt.zero;
        for (TransactioOutput to in interiore.outputs.where((wo) => wo.publicaClavis != interiore.dominus)) {
          impendio += to.pod;
        }
        return impendio <= Pera.habetBid(interiore.liber, interiore.dominus, lo);
    }
    return true;
  }
  bool verumMoles(Iterable<Transactio> llt, List<Obstructionum> lo) {
    List<Transactio> lltc = List<Transactio>.from(llt.map((mlt) => Transactio.fromJson(mlt.toJson())));
    lo.map(
      (mo) => interiore.liber ? 
      mo.interiore.liberTransactions.where(
        (wlt) => interiore.inputs.any(
          (ai) => ai.transactioIdentitatis == wlt.interiore.identitatis)) : 
          mo.interiore.fixumTransactions.where(
            (wft) => interiore.inputs.any(
              (ai) => ai.transactioIdentitatis ==  wft.interiore.identitatis)))
              .forEach(lltc.addAll);   
    BigInt licet = BigInt.zero;
    for (TransactioInput ti in interiore.inputs) {
      Transactio? t = lltc.firstWhereOrNull((fwon) => fwon.interiore.identitatis == ti.transactioIdentitatis);
      if (t == null) {
        print('verumtoldnull');
        return false;
      }
      licet += t.interiore.outputs[ti.index].pod;
    }
    BigInt impendio = BigInt.zero;
    for (TransactioOutput to in interiore.outputs) {
      impendio += to.pod;
    }
    print('impendiowasntlicet $impendio and licet $licet');
    return impendio == licet;
  }
  bool solucionis(List<Obstructionum> lo) {
    List<SolucionisPropter> lsp = [];
    lo.map((mo) => mo.interiore.solucionisRationibus).forEach(lsp.addAll);
    List<FissileSolucionisPropter> lfsp = [];
    lo.map((mo) => mo.interiore.fissileSolucionisRationibus).forEach(lfsp.addAll);
    if (lsp.any((asp) => asp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == interiore.dominus) || lfsp.any((afsp) => afsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == interiore.dominus)) {
      return true;
    }
    return false;
  }

  bool convalidandumSolucionis(List<Obstructionum> lo) {
    List<SolucionisPropter> lsp = [];
    lo.map((msp) => msp.interiore.solucionisRationibus).forEach(lsp.addAll);
    SolucionisPropter sp = lsp.singleWhere((swsp) => swsp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == interiore.dominus);
    if (!interiore.outputs.every((eo) => eo.publicaClavis == sp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.accipientis)) {
      Print.nota(nuntius: 'transactionem tantum habere debet unus receptor et hic accipiens debet specificari per solutionem rationis', message: 'the transaction should only have one receiver and this receiver should be specified by the payment account');
      return false;
    } 
    return true;
  }
  bool convalidandumSolucionisFissile(List<Obstructionum> lo) {
    List<FissileSolucionisPropter> lfsp = [];
    lo.map((mfsp) => mfsp.interiore.fissileSolucionisRationibus).forEach(lfsp.addAll);
    List<Fixus> lf = [];
    lfsp.where(
      (wfsp) => wfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == interiore.dominus)
      .map((mfsp) => mfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.fixs)
      .forEach(lf.addAll);
    if (lf[interiore.fixusIndex!].accipientis != interiore.recipiens) {
      Print.nota(nuntius: 'recipiens rem non est certa solutionis ratio', message: 'the receiver of the transaction is not the one specified in the payment account');
      return false;
    }
    BigInt impendio = BigInt.zero;
    for (TransactioOutput to in interiore.outputs.where((wo) => wo.publicaClavis == interiore.recipiens)) {
      impendio += to.pod;
    }
    if (lf[interiore.fixusIndex!].pod != impendio) {
      Print.nota(nuntius: 'certum transfertur non respondet ad certum numerum', message: 'fixed amount transfered does not correspond to the specified amount');
      return false;
    }
    return true;
  }
  bool convalidandumSolucionisReliquiae(List<Obstructionum> lo) {
   List<FissileSolucionisPropter> lfsp = [];
   lo.map((mo) => mo.interiore.fissileSolucionisRationibus).forEach(lfsp.addAll);
   FissileSolucionisPropter fsp = lfsp.singleWhere((swfsp) => swfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == interiore.dominus);
   if (!interiore.outputs.every((eo) => eo.publicaClavis == fsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.reliquiae)) {
      Print.nota(nuntius: 'transactionem tantum habere debet unus receptor et hic accipiens debet specificari per solutionem rationis', message: 'the transaction should only have one receiver and this receiver should be specified by the payment account');
      return false;
   }
   return true;
  }

  Map<String, dynamic> toJson() => {
        JSON.probationem: probationem,
        JSON.interiore: interiore.toJson()
      };

  bool validateProbationem() {
    if (probationem !=
        HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interiore.toJson())))
            .bytes)) {
      return false;
    }
    return true;
  }

  bool habetProfundum(List<Obstructionum> lo) {
    List<SiRemotionem> lsr = [];
    lo.map((mlo) => mlo.interiore.siRemotiones).forEach(lsr.addAll);
    List<SiRemotionemInput> lsri = [];
    lsr.where((wsr) => wsr.interiore.siRemotionemInput != null).map((msr) => msr.interiore.siRemotionemInput!).forEach(lsri.add);
    List<SiRemotionemOutput> lsro = [];
    lsr.where((wsr) => !lsri.any((asri) => asri.siRemotionemSignature == wsr.interiore.signatureInterioreSiRemotionem) && wsr.interiore.siRemotionemOutput != null).map((msr) => msr.interiore.siRemotionemOutput!).forEach(lsro.add);
    List<TransactioOutput> lto = [];
    for (TransactioInput ti in interiore.inputs) {
      print('imsearching for a tx with identitatis\n ${ti.transactioIdentitatis}');
      print('and my index is\n ${ti.index}');
      print('and the full json is ${ti.toJson()}');
      List<Transactio> lt = [];
        lo.where((wlo) => interiore.liber ? wlo.interiore.liberTransactions.any((alt) => alt.interiore.identitatis == ti.transactioIdentitatis) : wlo.interiore.fixumTransactions.any((aft) => aft.interiore.identitatis == ti.transactioIdentitatis)).map((mo) => interiore.liber ? mo.interiore.liberTransactions.singleWhere((wlt) => wlt.interiore.identitatis == ti.transactioIdentitatis) : mo.interiore.fixumTransactions.singleWhere((swft) => swft.interiore.identitatis == ti.transactioIdentitatis)).forEach(lt.add);
      for (Transactio t in lt) {
        print('thetxweregoeswrong\\n ${t.toJson()}');
        lto.add(t.interiore.outputs[ti.index]);
      }
    }
    return !lto.every((eto) => !lsro.map((msro) => msro.debetur).contains(eto.publicaClavis));
  }

  
  static Future<bool> omnesClavesPublicasDefendi(
      List<TransactioOutput> outputs, List<Obstructionum> lo) async {
    for (TransactioOutput output in outputs) {
      if (!await Pera.isPublicaClavisDefended(output.publicaClavis, lo)) {
        return false;
      }
    }
    return true;
  }

  static Future<bool> inObstructionumCatenae(TransactioGenus tg,
      List<String> identitatump, List<Obstructionum> lo) async {
    List<String> identitatum = [];
    switch (tg) {
      case TransactioGenus.liber:
        {
          lo
              .map((ob) => ob.interiore.liberTransactions
                  .map((lt) => lt.interiore.identitatis))
              .forEach(identitatum.addAll);
          return identitatump
              .every((identitatis) => identitatum.contains(identitatis));
        }
      case TransactioGenus.fixum:
        {
          lo
              .map((ob) => ob.interiore.fixumTransactions
                  .map((ft) => ft.interiore.identitatis))
              .forEach(identitatum.addAll);
          return identitatump
              .every((identitatis) => identitatum.contains(identitatis));
        }
      case TransactioGenus.expressi:
        {
          lo
              .map((ob) => ob.interiore.expressiTransactions
                  .map((et) => et.interiore.identitatis))
              .forEach(identitatum.addAll);
          return identitatump
              .every((identitatis) => identitatum.contains(identitatis));
        }
    }
  }


}


class InterioreInritaTransactio {
  bool liber;
  String identitatis;
  String signature;
  BigInt nonce;
  InterioreInritaTransactio(this.liber, this.identitatis, this.signature): nonce = BigInt.zero;

  InterioreInritaTransactio.fromJson(Map<String, dynamic> map): 
    liber = bool.parse(map[JSON.liber].toString()),
    identitatis = map[JSON.identitatis], 
    signature = map[JSON.signature],
    nonce = BigInt.parse(map[JSON.nonce].toString());
    
  Map<String, dynamic> toJson() => {
    JSON.liber: liber,
    JSON.identitatis: identitatis,
    JSON.signature: signature,
    JSON.nonce: nonce.toString()
  };
  mine() {
    nonce += BigInt.one;
  }
}
class InritaTransactio {
  String probationem;
  InterioreInritaTransactio interiore;
  InritaTransactio(this.probationem, this.interiore);

  InritaTransactio.fromJson(Map<String, dynamic> map):
    probationem = map[JSON.probationem],
    interiore = InterioreInritaTransactio.fromJson(map[JSON.interiore] as Map<String, dynamic>);

  Map<String, dynamic> toJson() => {
    JSON.probationem: probationem,
    JSON.interiore: interiore
  };

  static void quaestum(List<dynamic> argumentis) {
    InterioreInritaTransactio interiore = argumentis[0] as InterioreInritaTransactio;
    SendPort mitte = argumentis[1] as SendPort;
    String probationem = '';
    int zeros = 1;
    while (true) {
      do {
        interiore.mine();
        probationem = HEX.encode(
            sha512.convert(utf8.encode(Encoder.encodeJson(interiore.toJson()))).bytes);
      } while (!probationem.startsWith('0' * zeros));
      for (int i = zeros + 1; i < probationem.length; i++) {
        if (probationem.substring(0, i) == ('0' * i)) {
          zeros += 1;          
        } else {
          break;
        }
      }
      zeros += 1;
      mitte.send(InritaTransactio(probationem, interiore));
    }
  }

}