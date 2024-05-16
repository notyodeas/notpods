import './utils.dart';
import 'dart:convert';
import 'package:hex/hex.dart';
import 'package:crypto/crypto.dart';
import 'dart:isolate';
import './constantes.dart';
import 'errors.dart';
import 'obstructionum.dart';
import 'pera.dart';
import 'package:elliptic/elliptic.dart';
import 'package:collection/collection.dart';
import 'package:encoder/encoder.dart';
class Quadrigis {
  final String publicaClavis;
  final String signature;
  Quadrigis(String ex, this.publicaClavis):
    signature = Utils.signumIdentitatis(PrivateKey.fromHex(Pera.curve(), ex), publicaClavis); 
  Quadrigis.fromJson(Map<String, dynamic> map):
    publicaClavis = map[JSON.publicaClavis],
    signature = map[JSON.signature];
  Map<String, dynamic> toJson() => {
    JSON.publicaClavis: publicaClavis,
    JSON.signature: signature
  };
}

class InteriorePropter {
  bool? primis;
  final String publicaClavis;
  final String signature;
  final List<Quadrigis> quadrigis;
  BigInt nonce;
  InteriorePropter(String ex, this.publicaClavis, this.quadrigis):
    signature = Utils.signumIdentitatis(PrivateKey.fromHex(Pera.curve(), ex), publicaClavis),
    nonce = BigInt.zero; 
  InteriorePropter.incipio(String ex, this.publicaClavis): 
      signature = Utils.signumIdentitatis(PrivateKey.fromHex(Pera.curve(), ex), publicaClavis),
      quadrigis = [],
      nonce = BigInt.zero;
  mine() {
    nonce += BigInt.one;
  }

  Map<String, dynamic> toJson() => {
        JSON.publicaClavis: publicaClavis,
        JSON.signature: signature,
        JSON.quadrigis: quadrigis.map((mquadrigis) => mquadrigis.toJson()).toList(),
        JSON.nonce: nonce.toString(),
      };
  InteriorePropter.fromJson(Map<String, dynamic> jsoschon)
      : publicaClavis = jsoschon[JSON.publicaClavis].toString(),
        signature = jsoschon[JSON.signature],
        quadrigis = List<Quadrigis>.from((jsoschon[JSON.quadrigis] as List<dynamic>).map((m) => Quadrigis.fromJson(m as Map<String, dynamic>))),
        nonce = BigInt.parse(jsoschon[JSON.nonce].toString());
}

class Propter {
  late String probationem;
  final InteriorePropter interiore;
  Propter(this.probationem, this.interiore);

  Propter.incipio(this.interiore)
      : probationem = HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interiore.toJson())))
            .bytes);
  static void quaestum(List<dynamic> argumentis) {
    InteriorePropter interiorePropter = argumentis[0] as InteriorePropter;
    SendPort mitte = argumentis[1] as SendPort;
    String probationem = '';
    int zeros = 1;
    while (true) {
      do {
        interiorePropter.mine();
        probationem = HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interiorePropter.toJson())))
            .bytes);
      } while (!probationem.startsWith('0' * zeros));
      for (int i = zeros + 1; i < probationem.length; i++) {
        if (probationem.substring(0, i) == ('0' * i)) {
          zeros += 1;          
        } else {
          break;
        }
      } 
      zeros += 1;
      mitte.send(Propter(probationem, interiorePropter));
    }
  }

  Map<String, dynamic> toJson() => {
        JSON.probationem: probationem,
        JSON.interiore: interiore.toJson()
      };
  Propter.fromJson(Map<String, dynamic> jsoschon)
      : probationem = jsoschon[JSON.probationem].toString(),
        interiore = InteriorePropter.fromJson(
            jsoschon[JSON.interiore] as Map<String, dynamic>);
  bool isProbationem() {
    if (probationem ==
        HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interiore.toJson())))
            .bytes)) {
      return true;
    }
    return false;
  }
}
class GladiatorInputPar {
  bool primis;
  String identitatis;
  GladiatorInputPar(this.primis, this.identitatis);
  Map<String, dynamic> toJson() => {
    JSON.primis: primis,
    JSON.identitatis: identitatis
  };
  GladiatorInputPar.fromJson(Map<String, dynamic> map): primis = bool.parse(map[JSON.primis].toString()), identitatis = map[JSON.identitatis];
}

class GladiatorInput {
  final String signature;
  final GladiatorInputPar inimicus;
  final GladiatorInputPar victima;
  GladiatorInput({ required this.signature, required this.inimicus, required this.victima });
  Map<String, dynamic> toJson() => {
        JSON.signature: signature,
        JSON.inimicus: inimicus.toJson(),
        JSON.victima: victima.toJson()
      };
  GladiatorInput.fromJson(Map jsoschon)
      : signature = jsoschon[JSON.signature].toString(),
        inimicus = GladiatorInputPar.fromJson(jsoschon[JSON.inimicus] as Map<String, dynamic>),
        victima = GladiatorInputPar.fromJson(jsoschon[JSON.victima] as Map<String, dynamic>);
}

class GladiatorOutput {
  final List<Propter> rationibus;
  final String defensio;
  final String impetum;
  GladiatorOutput(this.rationibus)
      : impetum = Utils.randomHex(1),
        defensio = Utils.randomHex(1);
  GladiatorOutput.incipio(String ex, String producentis)
      : rationibus = [
          Propter.incipio(InteriorePropter.incipio(ex, producentis)),
        ],
        defensio = Utils.randomHex(1),
        impetum = Utils.randomHex(1);
  Map<String, dynamic> toJson() => {
        JSON.rationibus: rationibus.map((r) => r.toJson()).toList(),
        JSON.defensio: defensio,
        JSON.impetum: impetum
      };
  GladiatorOutput.fromJson(Map<String, dynamic> jsoschon)
      : rationibus = List<Propter>.from(jsoschon[JSON.rationibus]
                .map((r) => Propter.fromJson(r as Map<String, dynamic>))
            as Iterable<dynamic>),
        defensio = jsoschon[JSON.defensio].toString(),
        impetum = jsoschon[JSON.impetum].toString();
}

class InterioreGladiator {
  GladiatorInput? input;
  final List<GladiatorOutput> outputs;
  final String identitatis;
  InterioreGladiator({required this.input, required this.outputs})
      : identitatis = Utils.randomHex(64);
  InterioreGladiator.efectus({required this.outputs})
      : input = null,
        identitatis = Utils.randomHex(64);
  InterioreGladiator.ce({required this.input})
      : outputs = [],
        identitatis = Utils.randomHex(64);
  InterioreGladiator.incipio(String ex, String producentis)
      : outputs = [GladiatorOutput.incipio(ex, producentis)],
        identitatis = Utils.randomHex(64);
  static List<GladiatorOutput> egos(List<Propter> propters) {
    List<List<Propter>> teams = [];
    List<String> lpi = [];
    outer:
    for (Propter p in propters.where((wpropters) => wpropters.interiore.quadrigis.isNotEmpty && !lpi.contains(wpropters.interiore.publicaClavis))) {
      List<Propter> bigas = [p];
      for (Quadrigis q in p.interiore.quadrigis) {
        Propter? ffp = propters.singleWhereOrNull((swpropters) => swpropters.interiore.publicaClavis == q.publicaClavis && !lpi.contains(q.publicaClavis));
        if (ffp == null) {
          continue outer;
        }
        bigas.add(ffp);
        lpi.add(ffp.interiore.publicaClavis);
      }
      teams.add(bigas);
    }
    for (List<Propter> lp in teams) {
      for (Propter p in lp) {
        propters.remove(p);
      }
    }
    List<Propter> primisGo = [];
    List<Propter> secundoGo = []; 
    for (int i = 0; i < teams.length; i++) {
      if (i % 2 == 0) {
        primisGo.addAll(teams[i]);
      } else {
        secundoGo.addAll(teams[i]);
      }
    }
    List<Propter> lpt = propters.take((propters.length / 2).round()).toList();
    List<Propter> lps = propters.skip((propters.length / 2).round()).toList();
    lpt.addAll(primisGo);
    lps.addAll(secundoGo);
    return [
      GladiatorOutput(lpt),
      GladiatorOutput(lps)
    ];
  }

  static Future<GladiatorInput> cegi({ required String privatusClavis,
      required GladiatorInputPar inimicus, required GladiatorInputPar victima, required List<Obstructionum> lo }) async {
    Gladiator? g = await Obstructionum.grabGladiator(victima.identitatis, lo);
    if (g == null) {
      throw BadRequest(
          code: 1,
          nuntius: 'Gladiator iam victus aut non inveni',
          message: 'Gladiator already defeaten or not found');
    }
    return GladiatorInput(
        signature: Utils.signum(PrivateKey.fromHex(Pera.curve(), privatusClavis),
            g.interiore.outputs[victima.primis ? 0 : 1]),
        inimicus: GladiatorInputPar(inimicus.primis, inimicus.identitatis),
        victima: GladiatorInputPar(victima.primis, victima.identitatis)
      );
  }

  Map<String, dynamic> toJson() => {
        JSON.input: input?.toJson(),
        JSON.outputs: outputs.map((o) => o.toJson()).toList(),
        JSON.identitatis: identitatis
      }..removeWhere((key, value) => value == null);
  InterioreGladiator.fromJson(Map<String, dynamic> jsoschon)
      : input = jsoschon[JSON.input] != null
            ? GladiatorInput.fromJson(jsoschon[JSON.input] as Map)
            : null,
        outputs = List<GladiatorOutput>.from(jsoschon[JSON.outputs]
                .map((o) => GladiatorOutput.fromJson(o as Map<String, dynamic>))
            as Iterable<dynamic>),
        identitatis = jsoschon[JSON.identitatis].toString();

  // static List<Propter> grab(List<Propter> propters) {
  //   List<Propter> reditus = [];
  //   for (int i = 64; i > 0; i--) {
  //     if (propters.any((p) => p.probationem.startsWith('0' * i))) {
  //       if (reditus.length < Constantes.perRationesObstructionum) {
  //         reditus.addAll(propters.where((p) =>
  //             p.probationem.startsWith('0' * i) && !reditus.contains(p)));
  //       } else {
  //         break;
  //       }
  //     }
  //   }
  //   return reditus;
  // }
}

class Gladiator {
  String probationem;
  InterioreGladiator interiore;
  Gladiator(this.probationem, this.interiore);
  Gladiator.nullam(this.interiore)
      : probationem = HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interiore.toJson())))
            .bytes);
  Map<String, dynamic> toJson() => {
        JSON.probationem: probationem,
        JSON.interiore: interiore.toJson()
      };
  Gladiator.fromJson(Map<String, dynamic> jsoschon)
      : probationem = jsoschon[JSON.probationem],
        interiore = InterioreGladiator.fromJson(
            jsoschon[JSON.interiore] as Map<String, dynamic>);
}


class RemovePropterStagnum {
  String publicaClavis;
  String signature;
  RemovePropterStagnum(String ex, this.publicaClavis): 
    signature = Utils.signumIdentitatis(PrivateKey.fromHex(Pera.curve(), ex), publicaClavis);
  RemovePropterStagnum.fromJson(Map<String, dynamic> map):
    publicaClavis = map[JSON.publicaClavis],
    signature = map[JSON.signature]; 

  Map<String, dynamic> toJson() => {
    JSON.publicaClavis: publicaClavis,
    JSON.signature: signature
  };
}