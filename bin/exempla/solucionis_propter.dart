import 'dart:convert';
import 'dart:isolate';

import 'package:crypto/crypto.dart';
import 'package:ecdsa/ecdsa.dart';
import 'package:hex/hex.dart';
import 'package:elliptic/elliptic.dart';
import '../auxiliatores/print.dart';
import 'constantes.dart';
import 'obstructionum.dart';
import 'pera.dart';
import 'utils.dart';
import 'package:encoder/encoder.dart';

class InterioreInterioreSolucionisPropter {
  String solucionis;
  String accipientis;
  InterioreInterioreSolucionisPropter(this.solucionis, this.accipientis);
  Map<String, dynamic> toJson() => {
    JSON.solucionis: solucionis,
    JSON.accipientis: accipientis
  };
  InterioreInterioreSolucionisPropter.fromJson(Map<String, dynamic> map):
  solucionis = map[JSON.solucionis],
  accipientis = map[JSON.accipientis];

  bool nonAccipitEtMittente() {
    if (accipientis == solucionis) {
      Print.nota(nuntius: 'accipientium publica clavis idem est ac mittentes publici clavis', message: 'receivers public key is the same as the senders public key');
      return false;
    } 
    return true;
  }
}
class InterioreSolucionisPropter {
  BigInt nonce;
  String signature;
  InterioreInterioreSolucionisPropter interioreInterioreSolucionisPropter;
  InterioreSolucionisPropter(PrivateKey privatus, this.interioreInterioreSolucionisPropter): nonce = BigInt.zero, signature = Utils.signum(privatus, interioreInterioreSolucionisPropter);

  Map<String, dynamic> toJson() => {
    JSON.nonce: nonce.toString(),
    JSON.signature: signature,
    JSON.interioreInterioreSolucionisPropter: interioreInterioreSolucionisPropter.toJson()
  };
  InterioreSolucionisPropter.fromJson(Map<String, dynamic> map):
    nonce = BigInt.parse(map[JSON.nonce].toString()),
    signature = map[JSON.signature],
    interioreInterioreSolucionisPropter = InterioreInterioreSolucionisPropter.fromJson(map[JSON.interioreInterioreSolucionisPropter] as Map<String, dynamic>);

  mine() {
    nonce += BigInt.one;
  }
  bool quinSignature() {
    if (!Utils.cognoscereInterioreInterioreSolucionisPropter(PublicKey.fromHex(Pera.curve(), interioreInterioreSolucionisPropter.solucionis), Signature.fromASN1Hex(signature), interioreInterioreSolucionisPropter)) {
      Print.nota(nuntius: 'non cognoscere subscriptione solutionis rationem', message: 'could not verify signature of payment account');
      return false;   
    }
    return true;
  }
  bool estValidus(List<Obstructionum> lo) {
    List<SolucionisPropter> lsp = [];
    lo.map((mo) => mo.interiore.solucionisRationibus).forEach(lsp.addAll);
    if (lsp.any((asp) => asp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == interioreInterioreSolucionisPropter.solucionis)) {
      Print.nota(nuntius: 'publica clavem iam usus est ad mercedem rationem', message: 'public key is already used for a payment account');
      return false;
    }
    if (lsp.any((asp) => asp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.accipientis == interioreInterioreSolucionisPropter.solucionis)) {
      Print.nota(nuntius: 'clavem publicam propter hanc solutionem portae usus esse non potest, receptaculum maioris solutionis portae', message: 'the public key used for this payment gateway can not be a receiver of an older payment gateway');
      return false;
    }
    List<FissileSolucionisPropter> lfsp = [];
    lo.map((mo) => mo.interiore.fissileSolucionisRationibus).forEach(lfsp.addAll);
    if (lfsp.any((afsp) => afsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == interioreInterioreSolucionisPropter.solucionis)) {
      Print.nota(nuntius: 'publica clavem iam usus est ad mercedem rationem', message: 'public key is already used for a payment account');
      return false;
    }
    List<Fixus> lf = [];
    lfsp.map((mfsp) => mfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.fixs).forEach(lf.addAll);
    if (lf.any((af) => af.accipientis == interioreInterioreSolucionisPropter.solucionis)) {
      Print.nota(nuntius: 'clavem publicam propter hanc solutionem portae usus esse non potest, receptaculum maioris solutionis portae', message: 'the public key used for this payment gateway can not be a receiver of an older payment gateway');
      return false;
    }
    return true;
  }
}
class SolucionisPropter {
  String probationem;
  InterioreSolucionisPropter interioreSolucionisPropter;
  SolucionisPropter(this.probationem, this.interioreSolucionisPropter);

  Map<String, dynamic> toJson() => {
    JSON.probationem: probationem,
    JSON.interioreSolucionisPropter: interioreSolucionisPropter.toJson()
  };
  SolucionisPropter.fromJson(Map<String, dynamic> map):
  probationem = map[JSON.probationem],
  interioreSolucionisPropter = InterioreSolucionisPropter.fromJson(map[JSON.interioreSolucionisPropter] as Map<String, dynamic>);


  bool estProbationem() {
    if (probationem !=
        HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interioreSolucionisPropter.toJson())))
            .bytes)) {
      Print.nota(nuntius: 'invalidum probationem solucionis rationem', message: 'invalid proof of payment account');      
      return false;
    }
    return true;
  }

  static void quaestum(List<dynamic> argumentis) {
    InterioreSolucionisPropter interiore = argumentis[0] as InterioreSolucionisPropter;
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
      mitte.send(SolucionisPropter(probationem, interiore));
    }
  }
  static SolucionisPropter accipere(String publica, List<Obstructionum> lo) {
    List<SolucionisPropter> lsp = [];
    lo.map((mo) => mo.interiore.solucionisRationibus).forEach(lsp.addAll);
    return lsp.singleWhere((swsp) => swsp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == publica);
  } 
}
class Fixus {
  BigInt pod;
  String accipientis;
  Fixus(this.pod, this.accipientis);
  Map<String, dynamic> toJson() => {
    JSON.pod: pod.toString(),
    JSON.accipientis: accipientis
  }..removeWhere((key, value) => value == null);
  Fixus.fromJson(Map<String, dynamic> map):
    pod = BigInt.parse(map[JSON.pod].toString()),
    accipientis = map[JSON.accipientis];
}
class InterioreInterioreFissileSolucionisPropter {
  String solucionis;
  String reliquiae;
  List<Fixus> fixs;
  InterioreInterioreFissileSolucionisPropter(this.solucionis, this.reliquiae, this.fixs);
  Map<String, dynamic> toJson() => {
    JSON.solucionis: solucionis,
    JSON.reliquiae: reliquiae,
    JSON.fixs: fixs.map((mf) => mf.toJson()).toList()
  };
  InterioreInterioreFissileSolucionisPropter.fromJson(Map<String, dynamic> map):
    solucionis = map[JSON.solucionis],
    reliquiae = map[JSON.reliquiae],
    fixs = List<Fixus>.from((map[JSON.fixs] as List<dynamic>).map((f) => Fixus.fromJson(f as Map<String, dynamic>)));

  bool nonAccipitEtMittente() {
    if (fixs.any((af) => af.accipientis == solucionis) || solucionis == reliquiae) {
      Print.nota(nuntius: 'accipientium publica clavis idem est ac mittentes publici clavis', message: 'receivers public key is the same as the senders public key');
      return false;
    }
    return true;
  }
}
class InterioreFissileSolucionisPropter {
  BigInt nonce;
  String signature;
  InterioreInterioreFissileSolucionisPropter interioreInterioreFissileSolucionisPropter;
  InterioreFissileSolucionisPropter(PrivateKey privatus, this.interioreInterioreFissileSolucionisPropter): nonce = BigInt.zero, signature = Utils.signum(privatus, interioreInterioreFissileSolucionisPropter);
  Map<String, dynamic> toJson() => {
    JSON.nonce: nonce.toString(),
    JSON.signature: signature,
    JSON.interioreInterioreFissileSolucionisPropter: interioreInterioreFissileSolucionisPropter.toJson()
  };
  InterioreFissileSolucionisPropter.fromJson(Map<String, dynamic> map):
    nonce = BigInt.parse(map[JSON.nonce].toString()),
    signature = map[JSON.signature],
    interioreInterioreFissileSolucionisPropter = InterioreInterioreFissileSolucionisPropter.fromJson(map[JSON.interioreInterioreFissileSolucionisPropter] as Map<String, dynamic>);

  bool quinSignature() {
    if (!Utils.cognoscereInterioreInterioreFissileSolucionisPropter(PublicKey.fromHex(Pera.curve(), interioreInterioreFissileSolucionisPropter.solucionis), Signature.fromASN1Hex(signature), interioreInterioreFissileSolucionisPropter)) {
      Print.nota(nuntius: 'non cognoscere subscriptione solutionis rationem', message: 'could not verify signature of payment account');
      return false;   
    }
    return true;
  }

  bool estValidus(List<Obstructionum> lo) {
    List<SolucionisPropter> lsp = [];
    lo.map((mo) => mo.interiore.solucionisRationibus).forEach(lsp.addAll);
    if (lsp.any((asp) => asp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis == interioreInterioreFissileSolucionisPropter.solucionis)) {
      Print.nota(nuntius: 'publica clavem iam usus est ad mercedem rationem', message: 'public key is already used for a payment account');
      return false;
    }
    if (lsp.any((asp) => asp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.accipientis == interioreInterioreFissileSolucionisPropter.solucionis)) {
      Print.nota(nuntius: 'clavem publicam propter hanc solutionem portae usus esse non potest, receptaculum maioris solutionis portae', message: 'the public key used for this payment gateway can not be a receiver of an older payment gateway');
      return false;
    }
    List<FissileSolucionisPropter> lfsp = [];
    lo.map((mo) => mo.interiore.fissileSolucionisRationibus).forEach(lfsp.addAll);
    if (lfsp.any((afsp) => afsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == interioreInterioreFissileSolucionisPropter.solucionis)) {
      Print.nota(nuntius: 'publica clavem iam usus est ad mercedem rationem', message: 'public key is already used for a payment account');
      return false;
    }
    List<Fixus> lf = [];
    lfsp.map((mfsp) => mfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.fixs).forEach(lf.addAll);
    if (lf.any((af) => af.accipientis == interioreInterioreFissileSolucionisPropter.solucionis)) {
      Print.nota(nuntius: 'clavem publicam propter hanc solutionem portae usus esse non potest, receptaculum maioris solutionis portae', message: 'the public key used for this payment gateway can not be a receiver of an older payment gateway');
      return false;
    }
    return true;
  }
  mine() {
    nonce += BigInt.one;
  }
}
class FissileSolucionisPropter {
  String probationem;
  InterioreFissileSolucionisPropter interioreFissileSolucionisPropter;
  FissileSolucionisPropter(this.probationem, this.interioreFissileSolucionisPropter);

  Map<String, dynamic> toJson() => {
    JSON.probationem: probationem,
    JSON.interioreFissileSolucionisPropter: interioreFissileSolucionisPropter.toJson()
  };
  FissileSolucionisPropter.fromJson(Map<String, dynamic> map): 
    probationem = map[JSON.probationem],
    interioreFissileSolucionisPropter = InterioreFissileSolucionisPropter.fromJson(map[JSON.interioreFissileSolucionisPropter] as Map<String, dynamic>);
    
  // bool estNovum(List<Obstructionum> lo) {
  //   List<SolucionisPropter> lsp = [];
  //   lo.map((mo) => mo.interioreObstructionum.solucionisRationibus).forEach(lsp.addAll);
  //   if (lsp.any((asp) => asp.interioreSolucionisPropter.solucionis == interioreFissileSolucionisPropter.solucionis)) {
  //     Print.nota(nuntius: 'Ibi iam est ratio cum hoc publico clavem solucionis', message: 'there already is a payment account with this public key');
  //     return false;
  //   }
  //   List<FissileSolucionisPropter> lfsp = [];
  //   lo.map((mo) => mo.interioreObstructionum.fissileSolucionisRationibus).forEach(lfsp.addAll);
  //   if (lfsp.any((afsp) => afsp.interioreFissileSolucionisPropter.solucionis == interioreFissileSolucionisPropter.solucionis)) {
  //     Print.nota(nuntius: 'Ibi iam est ratio cum hoc publico clavem solucionis', message: 'there already is a payment account with this public key');
  //     return false;
  //   }
  //   return true;
  // }
  // bool estValid(List<Obstructionum> lo) {
  //   List<SolucionisPropter> lsp = [];
  //   lo.map((mo) => mo.interioreObstructionum.solucionisRationibus).forEach(lsp.addAll);
  //   List<FissileSolucionisPropter> lfsp = [];
  //   lo.map((mo) => mo.interioreObstructionum.fissileSolucionisRationibus).forEach(lfsp.addAll);
  //   if (lsp.any((asp) => asp.interioreSolucionisPropter.solucionis == interioreFissileSolucionisPropter.solucionis)) {
  //     Print.nota(nuntius: 'Ibi iam est ratio cum hoc publico clavem solucionis', message: 'there already is a payment account with this public key');
  //     return false;
  //   }
  //   if (lsp.any((asp) => asp.interioreSolucionisPropter.accipientis == interioreFissileSolucionisPropter.solucionis)) {
  //     Print.nota(nuntius: 'novam mercedem rationem non licet esse rationem mercedem accipit prior', message: 'a new payment account is not allowed to be a receiver of a previous payment account');
  //     return false;
  //   }
  //   if (lsp.any((asp) => interioreFissileSolucionisPropter.fixs.map((mf) => mf.accipientis).contains(asp.interioreSolucionisPropter.solucionis))) {
  //     Print.nota(nuntius: 'iam de ratione accipientis rationem reddi', message: 'one of the receiver accounts is already a payment account');
  //     return false;
  //   }
  //   if (lfsp.any((afsp) => afsp.interioreFissileSolucionisPropter.solucionis == interioreFissileSolucionisPropter.solucionis)) {
  //     Print.nota(nuntius: 'Ibi iam est ratio cum hoc publico clavem solucionis', message: 'there already is a payment account with this public key');
  //     return false;
  //   }
  //   if (lfsp.any((afsp) => afsp.interioreFissileSolucionisPropter.fixs.every((ef) => ef.accipientis != interioreFissileSolucionisPropter.solucionis))) {
  //     Print.nota(nuntius: 'novam mercedem rationem non licet esse rationem mercedem accipit prior', message: 'a new payment account is not allowed to be a receiver of a previous payment account');
  //     return false;
  //   }
  //   return true;
  // }

  bool estProbationem() {
    if (probationem !=
        HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interioreFissileSolucionisPropter.toJson())))
            .bytes)) {
      Print.nota(nuntius: 'invalidum probationem solucionis rationem', message: 'invalid proof');
      return false;
    }
    return true;
  }

  static void quaestum(List<dynamic> argumentis) {
    InterioreFissileSolucionisPropter interiore = argumentis[0] as InterioreFissileSolucionisPropter;
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
      mitte.send(FissileSolucionisPropter(probationem, interiore));
    }
  }
  static FissileSolucionisPropter accipere(String publica, List<Obstructionum> lo) {
    List<FissileSolucionisPropter> lfsp = [];
    lo.map((mo) => mo.interiore.fissileSolucionisRationibus).forEach(lfsp.addAll);
    return lfsp.singleWhere((swsp) => swsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis == publica);
  } 
}