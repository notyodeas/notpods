
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:crypto/crypto.dart';
import 'package:ecdsa/ecdsa.dart';
import 'package:elliptic/elliptic.dart';
import 'package:hex/hex.dart';
import '../auxiliatores/print.dart';
import '../server.dart';
import 'constantes.dart';
import 'obstructionum.dart';
import 'pera.dart';
import 'transactio.dart';
import 'utils.dart';
import 'package:encoder/encoder.dart';

class SiRemotionemInput {
  String signatureInput;
  String siRemotionemSignature;
  String transactioIdentitatis;
  InterioreTransactio? interioreTransactio;
  SiRemotionemInput(this.signatureInput, this.siRemotionemSignature,
      this.interioreTransactio): transactioIdentitatis = interioreTransactio!.identitatis;
  Map<String, dynamic> toJson() => {
        JSON.signatureInput: signatureInput,
        JSON.siRemotionemSignature: siRemotionemSignature,
        JSON.transactioIdentitatis: transactioIdentitatis,
        JSON.interioreTransactio: interioreTransactio?.toJson(),
      };
  SiRemotionemInput.fromJson(Map<String, dynamic> map)
      : signatureInput = map[JSON.signatureInput],
        siRemotionemSignature = map[JSON.siRemotionemSignature],
        transactioIdentitatis = map[JSON.transactioIdentitatis],
        interioreTransactio = map[JSON.interioreTransactio] != null ? InterioreTransactio.fromJson(
            map[JSON.interioreTransactio] as Map<String, dynamic>) : null;
  bool cognoscere(List<Obstructionum> lo) {
    SiRemotionem sr = SiRemotionem.exInitus(siRemotionemSignature, lo);
    return Utils.cognoscereInterioreSiRemotionem(PublicKey.fromHex(Pera.curve(), sr.interiore.siRemotionemOutput!.debetur), Signature.fromASN1Hex(signatureInput), sr.interiore);
  }
  bool solvit(Obstructionum o, List<Obstructionum> lo) {
    SiRemotionem sr = SiRemotionem.exInitus(siRemotionemSignature, lo);
    Transactio t = sr.interiore.siRemotionemOutput!.liber ? o.interiore.liberTransactions.singleWhere((swlt) => swlt.interiore.identitatis == transactioIdentitatis) : o.interiore.fixumTransactions.singleWhere((swft) => swft.interiore.identitatis == transactioIdentitatis);
    List<TransactioOutput> lto = [];
    for (TransactioInput ti in t.interiore.inputs) {
      List<Transactio> lt = [];
      lo.map((mlo) => sr.interiore.siRemotionemOutput!.liber ? mlo.interiore.liberTransactions
      .where((wlt) => wlt.interiore.identitatis == ti.transactioIdentitatis) :
      mlo.interiore.fixumTransactions.where((wft) => wft.interiore.identitatis == ti.transactioIdentitatis)).forEach(lt.addAll);
      for (Transactio ft in lt) {
        lto.add(ft.interiore.outputs[ti.index]);
      }
    }
    if (!lto.every((eto) => eto.publicaClavis == sr.interiore.siRemotionemOutput!.debetur)) {
      Print.nota(nuntius: 'profundum negotium non solvit verbo clavis publici', message: 'depth transaction is not payed with the owed public key');
      return false;
    }
    if (!t.interiore.outputs.any((ao) => ao.publicaClavis == sr.interiore.siRemotionemOutput!.habereIus)) {
      Print.nota(nuntius: 'profundum non solvit propriis clavis publici', message: 'depth is not payed to the proper public key');
      return false;
    }
    BigInt pretiumRetro = BigInt.zero;
    for (TransactioOutput to in t.interiore.outputs.where((wo) => wo.publicaClavis == sr.interiore.siRemotionemOutput!.habereIus)) {
      pretiumRetro += to.pod;
    }
    if (pretiumRetro != sr.interiore.siRemotionemOutput!.pod) {
      Print.nota(nuntius: 'nullum conatus vasculum reddere', message: 'invalid attempt of pod to pay back');
      return false;
    }
    return true;
  }
  bool solvitStagnum(InterioreTransactio it, List<Obstructionum> lo) {
    SiRemotionem sr = SiRemotionem.exInitus(siRemotionemSignature, lo);
    List<TransactioOutput> lto = [];
    for (TransactioInput ti in  it.inputs) {
      List<Transactio> lt = [];
      lo.map((mlo) => sr.interiore.siRemotionemOutput!.liber ? mlo.interiore.liberTransactions
      .where((wlt) => wlt.interiore.identitatis == ti.transactioIdentitatis) :
      mlo.interiore.fixumTransactions.where((wft) => wft.interiore.identitatis == ti.transactioIdentitatis)).forEach(lt.addAll);
      for (Transactio ft in lt) {
        lto.add(ft.interiore.outputs[ti.index]);
      }
    }
    if (!lto.every((eto) => eto.publicaClavis == sr.interiore.siRemotionemOutput!.debetur)) {
      Print.nota(nuntius: 'profundum negotium non solvit verbo clavis publici', message: 'depth transaction is not payed with the owed public key');
      return false;
    }
    if (!it.outputs.any((ao) => ao.publicaClavis == sr.interiore.siRemotionemOutput!.habereIus)) {
      Print.nota(nuntius: 'profundum non solvit propriis clavis publici', message: 'depth is not payed to the proper public key');
      return false;
    }
    BigInt pretiumRetro = BigInt.zero;
    for (TransactioOutput to in it.outputs.where((wo) => wo.publicaClavis == sr.interiore.siRemotionemOutput!.habereIus)) {
      pretiumRetro += to.pod;
    }
    if (pretiumRetro != sr.interiore.siRemotionemOutput!.pod) {
      Print.nota(nuntius: 'nullum conatus vasculum reddere', message: 'invalid attempt of pod to pay back');
      return false;
    }
    return true;
  }
}

class SiRemotionemOutput { 
  bool liber;
  String habereIus;
  String debetur;
  String transactioIdentitatis;
  BigInt pod;
  SiRemotionemOutput(this.liber, this.habereIus, this.debetur,
      this.transactioIdentitatis, this.pod);

  SiRemotionemOutput.fromJson(Map<String, dynamic> map)
      : liber = bool.parse(map[JSON.liber].toString()),
        habereIus = map[JSON.habereIus],
        debetur = map[JSON.debetur],
        transactioIdentitatis = map[JSON.transactioIdentitatis],
        pod = BigInt.parse(map[JSON.pod].toString());

  Map<String, dynamic> toJson() => {
        JSON.liber: liber,
        JSON.habereIus: habereIus,
        JSON.debetur: debetur,
        JSON.transactioIdentitatis: transactioIdentitatis,
        JSON.pod: pod.toString()
      };

  bool estTransactionIdentitatisAdhucPraesto(List<Obstructionum> lo, Obstructionum? o) {
    if (o != null) {
      if (o.interiore.inritaTransactions.any((ait) => ait.interiore.identitatis == transactioIdentitatis)) {
        Print.nota(nuntius: 'negotium tollitur rei antequam omnia signata accipientis', message: 'transaction is removed by the owner of the transaction before it got signed by the receiver');
        return false;
      }
    }
    List<InritaTransactio> lit = [];
    lo.map((mo) => mo.interiore.inritaTransactions).forEach(lit.addAll);
    if (lit.any((ait) => ait.interiore.identitatis == transactioIdentitatis)) {
      Print.nota(nuntius: 'negotium tollitur rei antequam omnia signata accipientis', message: 'transaction is removed by the owner of the transaction before it got signed by the receiver');
      return false;
    }
    return true;
  }
}

class InterioreSiRemotionem {
  SiRemotionemOutput? siRemotionemOutput;
  SiRemotionemInput? siRemotionemInput;
  String? signatureInterioreSiRemotionem;
  BigInt nonce;
  mine() {
    nonce += BigInt.one;
  }

  InterioreSiRemotionem.output(String ex, this.siRemotionemOutput)
      : nonce = BigInt.zero,
        signatureInterioreSiRemotionem = Utils.signum(
            PrivateKey.fromHex(Pera.curve(), ex), siRemotionemOutput);

  InterioreSiRemotionem.input(this.siRemotionemInput)
      : nonce = BigInt.zero;

  InterioreSiRemotionem.fromJson(Map<String, dynamic> map)
      : siRemotionemInput = map[JSON.siRemotionemInput] != null
            ? SiRemotionemInput.fromJson(
                map[JSON.siRemotionemInput] as Map<String, dynamic>)
            : null,
        siRemotionemOutput = map[JSON.siRemotionemOutput] != null
            ? SiRemotionemOutput.fromJson(
                map[JSON.siRemotionemOutput] as Map<String, dynamic>)
            : null,

        nonce = BigInt.parse(map[JSON.nonce].toString()),
        signatureInterioreSiRemotionem =
            map[JSON.signatureInterioreSiRemotionem];
  Map<String, dynamic> toJson() => {
        JSON.siRemotionemInput: siRemotionemInput?.toJson(),
        JSON.siRemotionemOutput: siRemotionemOutput?.toJson(),
        JSON.signatureInterioreSiRemotionem: signatureInterioreSiRemotionem,
        JSON.nonce: nonce.toString()
      };

  bool cognoscereOutput() {
    if (Utils.cognoscereSiRemotionemOutput(
        PublicKey.fromHex(Pera.curve(), siRemotionemOutput!.debetur),
        Signature.fromASN1Hex(signatureInterioreSiRemotionem!),
        siRemotionemOutput!)) {
          return true;
        } else {
          print('siremotionemcheckwascognoscereoutput');
          return false;
        }
  }
  // bool vacuaEst(List<Obstructionum> lo) {
  //   List<SiRemotionem> lsr = [];
  //   lo.map((mlo) => mlo.interiore.siRemotiones).forEach(lsr.addAll);
  //   if (lsr.any((alsr) => alsr.interiore.))
  // }

  bool utPrimum(List<Transactio> lt) {
    return lt.any((alt) => alt.interiore.identitatis == siRemotionemOutput!.transactioIdentitatis);
  }
}


class SiRemotionem {
  String probationem;
  InterioreSiRemotionem interiore;
  SiRemotionem(this.probationem, this.interiore);
  SiRemotionem.summitto(this.interiore)
      : probationem = HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interiore.toJson())))
            .bytes);

  SiRemotionem.fromJson(Map<String, dynamic> map)
      : probationem = map[JSON.probationem],
        interiore = InterioreSiRemotionem.fromJson(
            map[JSON.interiore] as Map<String, dynamic>);
  Map<String, dynamic> toJson() => {
        JSON.probationem: probationem,
        JSON.interiore: interiore.toJson(),
      };

  bool validateProbationem() {
    if (probationem !=
        HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interiore.toJson())))
            .bytes)) {
              print('siremotionemcheckwasprobationem');
      return false;
    }
    return true;
  }

  Future<bool> remotumEst() async {
    Directory directorium = Directory(
        '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    List<Transactio> ltlt = [];
    lo
        .map((mo) => mo.interiore.liberTransactions)
        .forEach(ltlt.addAll);
    if (!ltlt.any((alt) =>
        alt.interiore.identitatis ==
        interiore.siRemotionemOutput?.transactioIdentitatis)) {
      print('f');
      return false;
    }
    List<Transactio> ltft = [];
    lo
        .map((mo) => mo.interiore.fixumTransactions)
        .forEach(ltft.addAll);
    if (ltft.any((alt) =>
        alt.interiore.identitatis ==
        interiore.siRemotionemOutput?.transactioIdentitatis)) {
      print('ff');
      return false;
    }
    List<SiRemotionem> lsr = [];
    lo.map((mo) => mo.interiore.siRemotiones).forEach(lsr.addAll);
    if (lsr.any((asr) =>
        asr.interiore.signatureInterioreSiRemotionem ==
        interiore.signatureInterioreSiRemotionem)) {
      print('fff');
      return false;
    }
    return true;
  }

  Future<bool> nonHabetInitus() async {
    Directory directorium = Directory(
        '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}');
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    List<SiRemotionem> lsr = [];
    lo
        .map((mo) => mo.interiore.siRemotiones.where(
            (wsr) => wsr.interiore.siRemotionemInput != null))
        .forEach(lsr.addAll);
    List<SiRemotionemInput> lsri =
        lsr.map((msr) => msr.interiore.siRemotionemInput!).toList();

    List<String> inputIdentitatum = [];
    lsri.map((sri) => sri.siRemotionemSignature).forEach(inputIdentitatum.add);
    if (inputIdentitatum.contains(interiore.signatureInterioreSiRemotionem)) {
      print('siremoptionemcheck nonhabetinit');
      return false;
    } 
    return true;
  }

  Future<bool> valetInitus() async {
    if (interiore.siRemotionemInput == null) {
      return true;
    }
    return false;
  }
  
  
  static Iterable<SiRemotionem> debitaHabereIus(bool debita, String publica, List<Obstructionum> lo) {
    List<SiRemotionem> lsr = [];
    lo.map((mlo) => mlo.interiore.siRemotiones
    .where((wsr) => wsr.interiore.siRemotionemOutput != null)).forEach(lsr.addAll);
    print('lsrtmp \n ${lsr.map((e) => e.toJson())}');
    return lsr.where((wlsr) => debita ? wlsr.interiore.siRemotionemOutput!.debetur == publica : wlsr.interiore.siRemotionemOutput!.habereIus == publica);
  }  
  static bool habetProfundum(bool liber, String publica, List<Obstructionum> lo) {
    List<SiRemotionem> lsr = [];
    lo.map((mo) => mo.interiore.siRemotiones.where((wsr) => wsr.interiore.siRemotionemOutput != null && wsr.interiore.siRemotionemOutput?.liber == liber)).forEach(lsr.addAll);
    return lsr.any((asr) => asr.interiore.siRemotionemOutput!.debetur == publica);
  }
  static SiRemotionem exInitus(String signature, List<Obstructionum> lo) {
    print(' \n tell me signature \ n');
    print(signature);
    List<SiRemotionem> lsr = [];
    lo.map((mo) => mo.interiore.siRemotiones).forEach(lsr.addAll);
    return lsr.singleWhere((wsr) => (wsr.interiore.signatureInterioreSiRemotionem == signature && wsr.interiore.siRemotionemOutput != null) || (wsr.interiore.siRemotionemInput != null && wsr.interiore.siRemotionemInput!.siRemotionemSignature == signature));
  }

  static void quaestum(List<dynamic> argumentis) {
    InterioreSiRemotionem interiore = argumentis[0] as InterioreSiRemotionem;
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
      mitte.send(SiRemotionem(probationem, interiore));
    }
  }

  // static List<SiRemotionem> grab(Iterable<SiRemotionem> isr) {
  //   List<SiRemotionem> reditus = [];
  //   for (int i = 128; i > 0; i--) {
  //     if (isr.any((aisr) => aisr.probationem.startsWith('0' * i))) {
  //       if (reditus.length < Constantes.txCaudice) {
  //         reditus.addAll(isr.where((wsr) =>
  //             wsr.probationem.startsWith('0' * i) && !reditus.contains(wsr)));
  //       } else {
  //         break;
  //       }
  //     }
  //   }
  //   return reditus;
  // }
  // but we dont have inputs yet so these depths could be payed
  static Future<List<SiRemotionemOutput>> profundums(String publicaClavis, Directory directorium) async {
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    List<SiRemotionem> lsr = [];
    lo.map((mo) => mo.interiore.siRemotiones).forEach(lsr.addAll);
    List<SiRemotionemOutput> lsro = [];
    lsr.where((wsr) => wsr.interiore.siRemotionemOutput != null).where((wsr) => wsr.interiore.siRemotionemOutput!.debetur == publicaClavis).map((msr) => msr.interiore.siRemotionemOutput!).forEach(lsro.add);
    return lsro;
  }
}
class SiRemotionemRemoveNuntius {
  String signature;
  String transactioIdentitatis;
  String signatureIdentitatis;
  SiRemotionemRemoveNuntius({ required String ex, required this.transactioIdentitatis, required this.signatureIdentitatis }): 
    signature = Utils.signumIdentitatis(PrivateKey.fromHex(Pera.curve(), ex), transactioIdentitatis);

  SiRemotionemRemoveNuntius.fromJson(Map<String, dynamic> map):
    signature = map[JSON.signature],
    transactioIdentitatis = map[JSON.transactioIdentitatis],
    signatureIdentitatis = map[JSON.signatureIdentitatis];

  Map<String, dynamic> toJson() => {
    JSON.signature: signature,
    JSON.transactioIdentitatis: transactioIdentitatis,
    JSON.signatureIdentitatis: signatureIdentitatis
  };

  bool estDominus(List<Obstructionum> lo) {
    List<SiRemotionem> lsr = [];
    lo.map((mlo) => mlo.interiore.siRemotiones).forEach(lsr.addAll);
    SiRemotionem sr = lsr.singleWhere((swlsr) => swlsr.interiore.signatureInterioreSiRemotionem == signatureIdentitatis && swlsr.interiore.siRemotionemOutput != null);
    return Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), sr.interiore.siRemotionemOutput!.habereIus), Signature.fromASN1Hex(signature), transactioIdentitatis);
  } 
}