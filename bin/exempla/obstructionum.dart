import 'package:crypto/crypto.dart';
import 'package:ecdsa/ecdsa.dart';
import '../auxiliatores/print.dart';
import './constantes.dart';
import 'connexa_liber_expressi.dart';
import 'gladiator.dart';
import './transactio.dart';
import './utils.dart';
import 'package:hex/hex.dart';
import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:convert';
import 'package:tuple/tuple.dart';
import 'package:collection/collection.dart';
import 'package:elliptic/elliptic.dart';

import 'pera.dart';
import 'si_remotionem.dart';
import 'solucionis_propter.dart';
import 'telum.dart';
import '../server.dart';
import 'package:encoder/encoder.dart';
import 'package:encoder/encoder.dart';

enum Generare { incipio, efectus, confussus, expressi }

extension GenerareFromJson on Generare {
  static fromJson(String name) {
    switch (name) {
      case 'incipio':
        return Generare.incipio;
      case 'efectus':
        return Generare.efectus;
      case 'confussus':
        return Generare.confussus;
      case 'expressi':
        return Generare.expressi;
    }
  }
}

enum Corrumpo { forumCap, summaDifficultas, numerus, divisa, legalis }

enum QuidFacere { solitum, subter, corrupt }

class InterioreObstructionum {
  final Generare generare;
  final bool estFurca;
  int? numeruCuneosMaximumsOrdinata;
  int obstructionumDifficultas;
  int indicatione;
  BigInt? praemium;
  BigInt nonce;
  final double divisa;
  final BigInt summaObstructionumDifficultas;
  final BigInt forumCap;
  final BigInt liberForumCap;
  final BigInt fixumForumCap;
  BigInt? obstructionumPraemium;
  final List<int> obstructionumNumerus;
  List<String> defensio;
  List<String> impetus;
  final String producentis;
  final String priorProbationem;
  final Gladiator gladiator;
  final List<Transactio> liberTransactions;
  final Iterable<Transactio> fixumTransactions;
  final Iterable<Transactio> expressiTransactions;
  final Iterable<ConnexaLiberExpressi> connexaLiberExpressis;
  final Iterable<SiRemotionem> siRemotiones;
  final Iterable<SolucionisPropter> solucionisRationibus;
  final Iterable<FissileSolucionisPropter> fissileSolucionisRationibus;
  final Iterable<InritaTransactio> inritaTransactions;

  InterioreObstructionum(
      {required this.generare,
      required this.estFurca,
      required this.obstructionumDifficultas,
      required this.divisa,
      required this.summaObstructionumDifficultas,
      required this.forumCap,
      required this.liberForumCap,
      required this.fixumForumCap,
      required this.obstructionumNumerus,
      required this.defensio,
      required this.impetus,
      required this.producentis,
      required this.priorProbationem,
      required this.gladiator,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotiones,
      required this.solucionisRationibus,
      required this.fissileSolucionisRationibus,
      required this.inritaTransactions
    })
      : indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero;

  InterioreObstructionum.incipio({ required String ex, required this.producentis, required BigInt praemium})
      : generare = Generare.incipio,
        estFurca = false,
        numeruCuneosMaximumsOrdinata = 7637637637637637637,
        obstructionumDifficultas = 0,
        divisa = 0,
        indicatione = DateTime.now().microsecondsSinceEpoch,
        praemium = BigInt.parse("763000000000000000000"),
        nonce = BigInt.zero,
        summaObstructionumDifficultas = BigInt.zero,
        forumCap = BigInt.zero,
        liberForumCap = BigInt.zero,
        fixumForumCap = BigInt.zero,
        obstructionumNumerus = [0],
        defensio = [],
        impetus = [],
        priorProbationem = '',
        gladiator = Gladiator.nullam(InterioreGladiator.incipio(ex, producentis)),
        liberTransactions = List<Transactio>.from(
            [Transactio.nullam(InterioreTransactio.praemium(producentis, praemium))]),
        fixumTransactions = [],
        expressiTransactions = [],
        connexaLiberExpressis = [],
        siRemotiones = [],
        solucionisRationibus = [],
        fissileSolucionisRationibus = [],
        inritaTransactions = [];

  InterioreObstructionum.efectus(
      {required this.estFurca,
      required this.obstructionumDifficultas,
      required this.summaObstructionumDifficultas,
      required this.divisa,
      required this.forumCap,
      required this.liberForumCap,
      required this.fixumForumCap,
      required this.obstructionumNumerus,
      required this.producentis,
      required this.priorProbationem,
      required this.gladiator,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotiones,
      required this.solucionisRationibus,
      required this.fissileSolucionisRationibus,
      required this.inritaTransactions,
      required Obstructionum prior})
      : generare = Generare.efectus,
        indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero,
        defensio = [Utils.randomHex(1)],
        impetus = [Utils.randomHex(1), Utils.randomHex(1), Utils.randomHex(1)];

  InterioreObstructionum.confussus(
      {required this.estFurca,
      required this.obstructionumDifficultas,
      required this.summaObstructionumDifficultas,
      required this.divisa,
      required this.forumCap,
      required this.fixumForumCap,
      required this.liberForumCap,
      required this.obstructionumNumerus,
      required this.producentis,
      required this.priorProbationem,
      required this.gladiator,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotiones,
      required this.solucionisRationibus,
      required this.fissileSolucionisRationibus,
      required this.inritaTransactions,
      required Obstructionum prior})
      : generare = Generare.confussus,
        indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero,
        defensio = [Utils.randomHex(1)],
        impetus = [Utils.randomHex(1), Utils.randomHex(1), Utils.randomHex(1)];

  InterioreObstructionum.expressi(
      {required this.estFurca,
      required this.obstructionumDifficultas,
      required this.summaObstructionumDifficultas,
      required this.forumCap,
      required this.liberForumCap,
      required this.fixumForumCap,
      required this.divisa,
      required this.obstructionumNumerus,
      required this.producentis,
      required this.priorProbationem,
      required this.gladiator,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotiones,
      required this.solucionisRationibus,
      required this.fissileSolucionisRationibus,
      required this.inritaTransactions,
      required Obstructionum prior})
      : generare = Generare.expressi,
        indicatione = DateTime.now().microsecondsSinceEpoch,
        nonce = BigInt.zero,
        defensio = [Utils.randomHex(1)],
        impetus = [Utils.randomHex(1), Utils.randomHex(1), Utils.randomHex(1)];

  mine() {
    indicatione = DateTime.now().microsecondsSinceEpoch;
    nonce += BigInt.one;
  }

  Map<String, dynamic> toJson() => {
        JSON.estFurca: estFurca,
        JSON.generare: generare.name.toString(),
        JSON.obstructionumDifficultas: obstructionumDifficultas,
        JSON.divisa: divisa.toString(),
        JSON.indicatione: indicatione,
        JSON.praemium: praemium.toString(),
        JSON.nonce: nonce.toString(),
        JSON.summaObstructionumDifficultas:
            summaObstructionumDifficultas.toString(),
        JSON.forumCap: forumCap.toString(),
        JSON.liberForumCap: liberForumCap.toString(),
        JSON.fixumForumCap: fixumForumCap.toString(),
        JSON.obstructionumNumerus: obstructionumNumerus.toList(),
        JSON.defensio: defensio,
        JSON.impetus: impetus,
        JSON.producentis: producentis,
        JSON.priorProbationem: priorProbationem,
        JSON.gladiator: gladiator.toJson(),
        JSON.liberTransactions:
            liberTransactions.map((e) => e.toJson()).toList(),
        JSON.fixumTransactions:
            fixumTransactions.map((e) => e.toJson()).toList(),
        JSON.expressiTransactions:
            expressiTransactions.map((e) => e.toJson()).toList(),
        JSON.adRemovendumConnexaLiberExpressis:
            connexaLiberExpressis.map((e) => e.toJson()).toList(),
        JSON.siRemotiones: siRemotiones.map((e) => e.toJson()).toList(),
        JSON.solucionisPropter: solucionisRationibus.map((e) => e.toJson()).toList(),
        JSON.fissileSolucionisPropter: fissileSolucionisRationibus.map((e) => e.toJson()).toList(),
        JSON.inritaTransactions: inritaTransactions.map((e) => e.toJson()).toList(),
      }..removeWhere((key, value) => value == null);
  InterioreObstructionum.fromJson(Map jsoschon)
      : estFurca = bool.parse(jsoschon[JSON.estFurca].toString()),
        generare = GenerareFromJson.fromJson(jsoschon[JSON.generare].toString())
            as Generare,
        obstructionumDifficultas =
            int.parse(jsoschon[JSON.obstructionumDifficultas].toString()),
        divisa = double.parse(jsoschon[JSON.divisa].toString()),
        indicatione = int.parse(jsoschon[JSON.indicatione].toString()),
        praemium = jsoschon[JSON.praemium].toString() == 'null' ? null : BigInt.parse(jsoschon[JSON.praemium].toString()),
        nonce = BigInt.parse(jsoschon[JSON.nonce].toString()),
        summaObstructionumDifficultas = BigInt.parse(
            jsoschon[JSON.summaObstructionumDifficultas].toString()),
        forumCap = BigInt.parse(jsoschon[JSON.forumCap].toString()),
        liberForumCap = BigInt.parse(jsoschon[JSON.liberForumCap].toString()),
        fixumForumCap = BigInt.parse(jsoschon[JSON.fixumForumCap]),
        obstructionumNumerus = List<int>.from(
            jsoschon[JSON.obstructionumNumerus] as List<dynamic>),
        defensio = List<String>.from(jsoschon[JSON.defensio]),
        impetus = List<String>.from(jsoschon[JSON.impetus]),
        producentis = jsoschon[JSON.producentis].toString(),
        priorProbationem = jsoschon[JSON.priorProbationem].toString(),
        gladiator = Gladiator.fromJson(
            jsoschon[JSON.gladiator] as Map<String, dynamic>),
        liberTransactions = List<Transactio>.from(
            jsoschon[JSON.liberTransactions]
                    .map((l) => Transactio.fromJson(l as Map<String, dynamic>))
                as Iterable<dynamic>),
        fixumTransactions = List<Transactio>.from(
            jsoschon[JSON.fixumTransactions]
                    .map((f) => Transactio.fromJson(f as Map<String, dynamic>))
                as Iterable<dynamic>),
        expressiTransactions = List<Transactio>.from(
            jsoschon[JSON.expressiTransactions]
                    .map((e) => Transactio.fromJson(e as Map<String, dynamic>))
                as Iterable<dynamic>),
        connexaLiberExpressis = List<ConnexaLiberExpressi>.from(
            (jsoschon[JSON.adRemovendumConnexaLiberExpressis] as List<dynamic>)
                .map((cle) => ConnexaLiberExpressi.fromJson(
                    cle as Map<String, dynamic>))),
        siRemotiones = List<SiRemotionem>.from((jsoschon[JSON.siRemotiones]
                as List<dynamic>)
            .map((sr) => SiRemotionem.fromJson(sr as Map<String, dynamic>))),
        solucionisRationibus = List<SolucionisPropter>.from((jsoschon[JSON.solucionisPropter] as List<dynamic>).map((msp) => SolucionisPropter.fromJson(msp as Map<String, dynamic>))),
        fissileSolucionisRationibus = List<FissileSolucionisPropter>.from((jsoschon[JSON.fissileSolucionisPropter] as List<dynamic>).map((mfsp) => FissileSolucionisPropter.fromJson(mfsp as Map<String, dynamic>))),
        inritaTransactions = List<InritaTransactio>.from((jsoschon[JSON.inritaTransactions] as List<dynamic>).map((mit) => InritaTransactio.fromJson(mit as Map<String, dynamic>)));

  BigInt numero() {
    BigInt n = BigInt.zero;
    for (int i in obstructionumNumerus) {
      n += BigInt.parse(i.toString());
    }
    return n;
  }

  double divisone() {
    return numero() / BigInt.parse(obstructionumDifficultas.toString());
  }
}

class InFieriObstructionum {
  List<String> gladiatorIdentitatum = [];
  List<String> liberTransactions = [];
  List<String> fixumTransactions = [];
  List<String> expressiTransactions = [];
  List<String> connexaLiberExpressis = [];
  List<String> siRemotionemOutputs = [];
  List<String> siRemotionemInputs = [];
  List<String> solucionisRationibus = [];
  List<String> fissileSolucionisRationibus = [];
  InFieriObstructionum({
      required this.gladiatorIdentitatum,
      required this.liberTransactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.connexaLiberExpressis,
      required this.siRemotionemInputs,
      required this.siRemotionemOutputs,
      required this.solucionisRationibus,
      required this.fissileSolucionisRationibus 
  });
}

class Obstructionum {
  final InterioreObstructionum interiore;
  late String probationem;
  Obstructionum(this.interiore, this.probationem);
  Obstructionum.incipio(this.interiore)
      : probationem = HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interiore.toJson())))
            .bytes);
  static Future efectus(List<dynamic> args) async {
    InterioreObstructionum interioreObstructionum =
        args[0] as InterioreObstructionum;
    SendPort mitte = args[1] as SendPort;
    String probationem = '';
    do {
      interioreObstructionum.mine();
      probationem = HEX.encode(sha512
          .convert(utf8.encode(Encoder.encodeJson(interioreObstructionum.toJson())))
          .bytes);
    } while (!probationem
        .startsWith('0' * interioreObstructionum.obstructionumDifficultas));
    mitte.send(Obstructionum(interioreObstructionum, probationem));
  }

  static Future confussus(List<dynamic> args) async {
    InterioreObstructionum interioreObstructionum =
        args[0] as InterioreObstructionum;
    List<String> toCrack = args[1] as List<String>;
    SendPort mitte = args[2] as SendPort;
    String probationem = '';
    while (true) {
      do {
        interioreObstructionum.mine();
        probationem = HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interioreObstructionum.toJson())))
            .bytes);
        // print(probationem);
      } while (!probationem
          .startsWith('0' * interioreObstructionum.obstructionumDifficultas));
      if (!toCrack.every((tc) => probationem.contains(tc))) {
        continue;
      } else {
        break;
      }
    }
    mitte.send(Obstructionum(interioreObstructionum, probationem));
  }

  static Future expressi(List<dynamic> args) async {
    InterioreObstructionum interioreObstructionum =
        args[0] as InterioreObstructionum;
    List<String> toCrack = args[1] as List<String>;
    SendPort mitte = args[2] as SendPort;
    String probationem = '';
    while (true) {
      do {
        interioreObstructionum.mine();
        probationem = HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interioreObstructionum.toJson())))
            .bytes);
      } while (!probationem.startsWith('0' *
              (interioreObstructionum.obstructionumDifficultas / 2).floor()) ||
          !probationem.endsWith('0' *
              (interioreObstructionum.obstructionumDifficultas / 2).floor()));
      if (!toCrack.every((tc) => probationem.contains(tc))) {
        continue;
      } else {
        break;
      }
    }
    mitte.send(Obstructionum(interioreObstructionum, probationem));
  }

  Map<String, dynamic> toJson() => {
        JSON.interiore: interiore.toJson(),
        JSON.probationem: probationem
      };
  Obstructionum.fromJson(Map<String, dynamic> jsoschon)
      : interiore = InterioreObstructionum.fromJson(
            jsoschon[JSON.interiore] as Map<String, dynamic>),
        probationem = jsoschon[JSON.probationem].toString();

  bool isProbationem() {
    if (probationem ==
        HEX.encode(sha512
            .convert(utf8.encode(Encoder.encodeJson(interiore.toJson())))
            .bytes)) {
      return true;
    }
    return false;
  }

  Future salvareIncipio(Directory dir) async {
    File file = await File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}0.txt')
        .create(recursive: true);
    await File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.exitus}.txt').create(recursive: true);
    await File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.latus}.txt').create(recursive: true);

    await interioreSalvare(file);
  }

  Future salvare(Directory dir) async {
    File file = await File(
            '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${(dir.listSync().length - 1)}.txt')
        .create(recursive: true);
    if (await Utils.fileAmnis(file).length > Constantes.maximeCaudicesFile) {
      file = await File(
              '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${(dir.listSync().length)}.txt')
          .create(recursive: true);
      await interioreSalvare(file);
    } else {
      await interioreSalvare(file);
    }
  }
  Future salvareExitus(Directory dir) async {
    File file = await File(
            '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.exitus}.txt')
        .create(recursive: true);
    await interioreSalvare(file);
  }
  Future salvareLatus(Directory dir) async {
    File file = await File(
            '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.latus}.txt')
        .create(recursive: true);
    await interioreSalvare(file);
  }
  // weird that json encode works here with bigger blocks it does but why out trues not languages choices unmeans out false not languages
  // logics not thats notjsonnotencode unworks there withouts smaller not blocks not its not dids butes reasons
  Future interioreSalvare(File file) async {
    var sink = file.openWrite(mode: FileMode.append);
    sink.write('${Encoder.encodeJson(toJson())}\n');
    sink.close();
  }

  static Future<Obstructionum> accipereIncipio(Directory directorium) async {
    return Obstructionum.fromJson(Encoder.decodeJson(await Utils.fileAmnis(
            File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}0.txt'))
        .first) as Map<String, dynamic>);
  }

  static Future<Obstructionum> acciperePrior(Directory directorium) async =>
      Obstructionum.fromJson(Encoder.decodeJson(await Utils.fileAmnis(File(
              '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${(directorium.listSync().isNotEmpty ? directorium.listSync().length - 1 : 0)}.txt'))
          .last) as Map<String, dynamic>);

  static Future<Obstructionum> accipereObstructionNumerus(
      List<int> numerus, Directory directory) async {
    File file =
        File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${numerus.length - 1}');
    List<String> lines = await Utils.fileAmnis(file).toList();
    return Obstructionum.fromJson(
        Encoder.decodeJson(lines[numerus.last]) as Map<String, dynamic>);
  }

  static Future<List<GladiatorOutput>> utDifficultas(
      List<Obstructionum> lo) async {
    List<GladiatorInput?> gladiatorInitibus = [];
    List<Tuple3<String, GladiatorOutput, bool>> gladiatorOutputs = [];
    lo
        .map((mo) =>
            mo.interiore.gladiator.interiore.input)
        .forEach(gladiatorInitibus.add);
    for (Obstructionum o in lo) {
      for (int i = 0;
          i <
              o.interiore.gladiator.interiore.outputs
                  .length;
          i++) {
        gladiatorOutputs.add(Tuple3<String, GladiatorOutput, bool>(
            o.interiore.gladiator.interiore.identitatis,
            o.interiore.gladiator.interiore.outputs[i],
            (i == 0 ? true : false)));
      }
    }
    gladiatorOutputs.removeWhere((element) => gladiatorInitibus.any((init) =>
        init?.victima.identitatis == element.item1 &&
        init?.victima.primis == element.item3));
    return gladiatorOutputs.map((g) => g.item2).toList();
  }

  static Future<List<Tuple3<String, GladiatorOutput, bool>>>
      invictosGladiatores(Directory directory) async {
    List<Obstructionum> caudices = [];
    List<GladiatorInput?> gladiatorInitibus = [];
    List<Tuple3<String, GladiatorOutput, bool>> gladiatorOutputs = [];
    for (int i = 0; i < directory.listSync().length; i++) {
      caudices.addAll(await Utils.fileAmnis(
              File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}$i.txt'))
          .map((b) =>
              Obstructionum.fromJson(Encoder.decodeJson(b) as Map<String, dynamic>))
          .toList());
    }
    caudices.forEach((obstructionum) {
      gladiatorInitibus.add(obstructionum
          .interiore.gladiator.interiore.input);
    });
    caudices.forEach((obstructionum) {
      for (int i = 0;
          i <
              obstructionum.interiore.gladiator.interiore
                  .outputs.length;
          i++) {
        gladiatorOutputs.add(Tuple3<String, GladiatorOutput, bool>(
            obstructionum.interiore.gladiator.interiore
                .identitatis,
            obstructionum
                .interiore.gladiator.interiore.outputs[i],
            i == 0 ? true : false));
      }
    });
    gladiatorOutputs.removeWhere((element) => gladiatorInitibus.any((init) =>
        init?.victima.identitatis == element.item1 &&
        init?.victima.primis == element.item3));
    return gladiatorOutputs;
  }

  static Future<BigInt> utSummaDifficultas(List<Obstructionum> lo) async {
    List<GladiatorOutput> lgo = await Obstructionum.utDifficultas([lo.first]);
    BigInt total = BigInt.from(lgo.length);
    for (Obstructionum o in lo) {
      total += BigInt.from(o.interiore.obstructionumDifficultas);
    }
    return total;
  }

  static Future<List<int>> utObstructionumNumerus(
      Obstructionum obstructionum) async {
    Obstructionum co = Obstructionum.fromJson(
        Encoder.decodeJson(Encoder.encodeJson(obstructionum.toJson())));
    List<int> dif = co.interiore.obstructionumNumerus;
    final int priorObstructionumNumerus = dif[dif.length - 1];
    if (priorObstructionumNumerus < Constantes.maximeCaudicesFile) {
      dif[dif.length - 1]++;
    } else if (priorObstructionumNumerus == Constantes.maximeCaudicesFile) {
      dif.add(0);
    }
    return dif;
  }

  static Future<BigInt> numeruo(List<int> numerus) async {
    BigInt n = BigInt.zero;
    for (int i in numerus) {
      n += BigInt.parse(i.toString());
    }
    return n;
  }

  static Future<List<Obstructionum>> getBlocks(Directory directory) async {
    List<Obstructionum> obs = [];
    for (int i = 0; i < directory.listSync().length; i++) {
      await for (String line in Utils.fileAmnis(
          File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}$i.txt'))) {
        obs.add(
            Obstructionum.fromJson(Encoder.decodeJson(line) as Map<String, dynamic>));
      }
    }
    return obs;
  }
  static Future<List<Obstructionum>> getExitusBlocks() async {
    List<Obstructionum> obs = [];
    await for (String line in Utils.fileAmnis(File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.exitus}.txt'))) {
      obs.add(
          Obstructionum.fromJson(Encoder.decodeJson(line) as Map<String, dynamic>));
    }
    return obs;
  }
  static Future<List<Obstructionum>> getLatusBlocks() async {
    List<Obstructionum> obs = [];
    await for (String line in Utils.fileAmnis(
        File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.latus}.txt'))) {
      obs.add(
          Obstructionum.fromJson(Encoder.decodeJson(line) as Map<String, dynamic>));
    }
    return obs;
  }

  //spirtus looks at the dir not te list of obstructionum
  static Future<bool> gladiatorSpiritus(
      bool primis, String gladiatorId, Directory dir) async {
    List<Obstructionum> obs = await getBlocks(dir);
    List<GladiatorInput?> gis = obs
        .map((o) => o.interiore.gladiator.interiore.input)
        .toList();
    if (gis.any(
        (g) => g?.victima.identitatis == gladiatorId && g?.victima.primis == primis)) {
      return false;
    }
    return true;
  }

  static Future<bool> gladiatorConfodiantur(
      bool primis, String gladiatorId, String publicaClavis, List<Obstructionum> lo) async {
    Obstructionum obsGladiator = lo.singleWhere((swo) =>
        swo.interiore.gladiator.interiore.identitatis ==
        gladiatorId);
    Gladiator gladiator = obsGladiator.interiore.gladiator;
    return gladiator.interiore.outputs[primis ? 0 : 1].rationibus
        .any((r) => r.interiore.publicaClavis == publicaClavis);
  }

  static Future<Gladiator?> grabGladiator(
      String gladiatorIdentitatis, List<Obstructionum> lo) async {
    return lo.singleWhereOrNull((obs) =>
                obs.interiore.gladiator.interiore
                    .identitatis ==
                gladiatorIdentitatis) !=
            null
        ? lo
            .singleWhere((obs) => 
                obs.interiore.gladiator.interiore
                    .identitatis ==
                gladiatorIdentitatis)
            .interiore
            .gladiator
        : null;
  }

  static Future<BigInt> accipereForumCap(List<Obstructionum> lo) async {
    final obstructionumPraemium = lo
        .where((obs) =>
            obs.interiore.generare == Generare.incipio ||
            obs.interiore.generare == Generare.efectus)
        .length;
    
    return (BigInt.parse(obstructionumPraemium.toString()) * lo.first.interiore.praemium!);
  }

  static Future<BigInt> accipereForumCapLiberFixum(
      bool liber, List<Obstructionum> lo) async {
    List<Tuple3<int, String, TransactioOutput>> outputs = [];
    List<TransactioInput> initibus = [];
    List<Transactio> txs = [];
    for (Obstructionum o in lo) {
      txs.addAll(liber
          ? o.interiore.liberTransactions
          : o.interiore.fixumTransactions);
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

  static bool estNovamNodi(Directory directorium, Obstructionum obs) {
    return directorium.listSync().isEmpty &&
        obs.interiore.generare == Generare.incipio;
  }

  static QuidFacere fortiorEst(
      InterioreObstructionum advenientis, Obstructionum nostrum) {
    if (advenientis.priorProbationem == nostrum.probationem) {
      if (advenientis.summaObstructionumDifficultas >
          nostrum.interiore.summaObstructionumDifficultas) {
        return QuidFacere.solitum;
      } else {
        return QuidFacere.corrupt;
      }
    }
    if (advenientis.divisa < nostrum.interiore.divisa) {
      return QuidFacere.subter;
    }
    return QuidFacere.solitum;
    // todo je kan ook achterlopen
  }

  static Future<Corrumpo> estVerum(
      InterioreObstructionum adventientis, List<Obstructionum> lo) async {
    if (adventientis.forumCap != await Obstructionum.accipereForumCap(lo)) {
      return Corrumpo.forumCap;
    } else if (adventientis.summaObstructionumDifficultas !=
        await Obstructionum.utSummaDifficultas(lo)) {
      return Corrumpo.summaDifficultas;
    } else if (adventientis.obstructionumNumerus !=
        await Obstructionum.utObstructionumNumerus(lo.last)) {
    } else {
      BigInt nuschum = await Obstructionum.numeruo(
          await Obstructionum.utObstructionumNumerus(lo.last));
      if (adventientis.divisa !=
          (nuschum / await Obstructionum.utSummaDifficultas(lo))) {
        return Corrumpo.divisa;
      }
    }
    return Corrumpo.legalis;
  }

  static bool nonFortum(Iterable<Transactio> transactions) {
    for (Transactio transactio in transactions) {
      if (!transactio.isFurantur() && !transactio.validateProbationem()) {
        return false;
      }
    }
    return true;
  }

  Future<bool> validatePraemium(Obstructionum incipio) async {
    if (interiore.fixumTransactions.any((ft) =>
        ft.interiore.transactioSignificatio ==
        TransactioSignificatio.praemium)) {
      return false;
    }
    if (interiore.liberTransactions
            .where((wlt) =>
                wlt.interiore.transactioSignificatio ==
                TransactioSignificatio.praemium)
            .length >
        1) {
      return false;
    }
    Transactio t = interiore.liberTransactions.singleWhere(
        (swlt) =>
            swlt.interiore.transactioSignificatio ==
            TransactioSignificatio.praemium);
    if (t.interiore.outputs.length > 1) {
      return false;
    }
    return t.interiore.outputs[0].pod ==
        incipio.interiore.liberTransactions
            .singleWhere((swlt) =>
                swlt.interiore.transactioSignificatio ==
                TransactioSignificatio.praemium)
            .interiore
            .outputs[0]
            .pod;
  }

  static Future removereUsqueAd(
      Obstructionum foramen, Directory directorium) async {
    List<Obstructionum> obss = await Obstructionum.getBlocks(directorium);
    Obstructionum hNostrum = obss.last;
    if (hNostrum.interiore.obstructionumNumerus.length ==
        foramen.interiore.obstructionumNumerus.length) {
      for (int i = 0;
          i < hNostrum.interiore.obstructionumNumerus.length;
          i++) {
        File f = File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}$i.txt');
        List<String> ss = await Utils.fileAmnis(f).toList();
        ss.removeRange(foramen.interiore.obstructionumNumerus.last,
            ss.length);
        f.deleteSync();
        f.createSync();
        var sink = f.openWrite(mode: FileMode.append);
        for (String jobs in ss) {
          sink.write('$jobs\n');
        }
        await sink.close();
      }
    }
    //todo else 
  }
  static Future removereExitus(Obstructionum foramen, Directory directorium) async {
    File f = File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.exitus}.txt');
    List<String> ss = await Utils.fileAmnis(f).toList();
    ss.removeAt(ss.indexOf(Encoder.encodeJson(foramen.toJson()))); 
    
  }

  InFieriObstructionum inFieriObstructionum() {
    List<String> gladiatorIdentitatum = [];
    interiore.gladiator.interiore.outputs
        .map((go) => go.rationibus.map((gr) => gr.interiore.publicaClavis))
        .forEach(gladiatorIdentitatum.addAll);
    List<String> lt = interiore.liberTransactions.where((wlt) => wlt.interiore.transactioSignificatio == TransactioSignificatio.regularis || wlt.interiore.transactioSignificatio == TransactioSignificatio.ardeat || wlt.interiore.transactioSignificatio == TransactioSignificatio.solucionis || wlt.interiore.transactioSignificatio == TransactioSignificatio.fissile || wlt.interiore.transactioSignificatio == TransactioSignificatio.reliquiae)
        .map((lt) => lt.interiore.identitatis)
        .toList();
    List<String> ft = interiore.fixumTransactions.where((wft) => wft.interiore.transactioSignificatio == TransactioSignificatio.regularis || wft.interiore.transactioSignificatio == TransactioSignificatio.ardeat  || wft.interiore.transactioSignificatio == TransactioSignificatio.solucionis || wft.interiore.transactioSignificatio == TransactioSignificatio.fissile || wft.interiore.transactioSignificatio == TransactioSignificatio.reliquiae)
        .map((ft) => ft.interiore.identitatis)
        .toList();
    List<String> et = interiore.expressiTransactions
        .map((et) => et.interiore.identitatis)
        .toList();
    List<String> cles = interiore.connexaLiberExpressis
        .map((cle) => cle.interioreConnexaLiberExpressi.identitatis)
        .toList();
    List<String> srsonn = interiore.siRemotiones.where((wsr) => wsr.interiore.siRemotionemOutput != null)
        .map(
            (msr) => msr.interiore.signatureInterioreSiRemotionem!)
        .toList();
    List<String> srsinn = interiore.siRemotiones.where((wsr) => wsr.interiore.siRemotionemInput != null)
        .map((msr) => msr.interiore.siRemotionemInput!.siRemotionemSignature).toList();
    List<String> sp = interiore.solucionisRationibus.map((msp) => msp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis).toList();
    List<String> fsp = interiore.fissileSolucionisRationibus.map((mfsp) => mfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis).toList();
    return InFieriObstructionum(gladiatorIdentitatum: gladiatorIdentitatum, liberTransactions: lt, fixumTransactions: ft, expressiTransactions: et, connexaLiberExpressis: cles, siRemotionemInputs: srsinn, siRemotionemOutputs: srsonn, solucionisRationibus: sp, fissileSolucionisRationibus: fsp);
  }

  Future<bool> convalidandumTransform(List<Obstructionum> lo) async {
    List<TransactioInput> ltit = [];
    interiore.liberTransactions
        .where((wlt) =>
            wlt.interiore.transactioSignificatio ==
            TransactioSignificatio.transform)
        .map((mlt) => mlt.interiore.inputs)
        .forEach(ltit.addAll);
    List<TransactioOutput> lto = [];
    interiore.fixumTransactions
        .where((wlf) =>
            wlf.interiore.transactioSignificatio ==
            TransactioSignificatio.transform)
        .map((mft) => mft.interiore.outputs)
        .forEach(lto.addAll);
    List<String> identitatumltit = [];
    ltit.map((mlt) => mlt.transactioIdentitatis).forEach(identitatumltit.add);
    List<Transactio> ltop = [];
    lo
        .map((mlo) => mlo.interiore.liberTransactions.where(
            (wlt) => identitatumltit.any((identitatis) =>
                identitatis == wlt.interiore.identitatis)))
        .forEach(ltop.addAll);

    List<TransactioOutput> rlt = [];
    ltop.map((mltop) => mltop.interiore.outputs.where((wo) => wo.publicaClavis == interiore.producentis)).forEach(rlt.addAll);
    BigInt fixum = BigInt.zero;
    for (TransactioOutput to in lto) {
      fixum += to.pod;
    }
    BigInt rfixum = BigInt.zero;
    for (TransactioOutput to in rlt) {
      rfixum += to.pod;
    }
    List<TransactioInput> tlti = [];
    interiore.liberTransactions.where((wlt) => 
      wlt.interiore.transactioSignificatio == 
      TransactioSignificatio.regularis || 
      wlt.interiore.transactioSignificatio == 
      TransactioSignificatio.expressi ||
      wlt.interiore.transactioSignificatio == 
      TransactioSignificatio.refugium ||
      wlt.interiore.transactioSignificatio == 
      TransactioSignificatio.ardeat
    ).map((mlt) => mlt.interiore.inputs).forEach(tlti.addAll);
    List<TransactioOutput> ltoProducer = [];
    interiore.liberTransactions
        .where((wlt) =>
            (wlt.interiore.transactioSignificatio ==
            TransactioSignificatio.regularis || 
            wlt.interiore.transactioSignificatio == 
            TransactioSignificatio.expressi || 
            wlt.interiore.transactioSignificatio == 
            TransactioSignificatio.refugium || 
            wlt.interiore.transactioSignificatio == 
            TransactioSignificatio.ardeat) && !tlti.any((atlti) => atlti.transactioIdentitatis == wlt.interiore.identitatis))
        .map((mlt) => mlt.interiore.outputs.where(
            (wo) => wo.publicaClavis == interiore.producentis))
        .forEach(ltoProducer.addAll);
    for (TransactioOutput to in ltoProducer) {
      rfixum += to.pod;
    }
    return fixum == rfixum;
  }
  // mab y map and addal in inner for loop have conccerns
  Future<bool> convalidandumPerdita(List<Obstructionum> lo) async {
    List<TransactioInput> lti = []; 
    interiore.liberTransactions
    .where((wlt) => wlt.interiore.transactioSignificatio == TransactioSignificatio.perdita)
    .map((mlt) => mlt.interiore.inputs)
    .forEach(lti.addAll); 
    List<TransactioOutput> lto = [];
    for (TransactioInput ti in lti) {
      List<Transactio> lt = [];
      lo.map((mo) => mo.interiore.liberTransactions.where((wo) => wo.interiore.identitatis == ti.transactioIdentitatis)).forEach(lt.addAll);
      lt.addAll(interiore.liberTransactions.where((wi) => wi.interiore.identitatis == ti.transactioIdentitatis));
      for (Transactio t in lt) {
        TransactioOutput to = t.interiore.outputs[ti.index];
        if (!Utils.cognoscere(PublicKey.fromHex(Pera.curve(), interiore.producentis), Signature.fromASN1Hex(ti.signature), to)) {
          Print.nota(nuntius: 'combussit pecuniam non signatum producentis amet', message: 'burned money is not signed with the producer key');
          return false;
        } 
        lto.add(to);
      }
    }    
    List<TransactioOutput> ltoi = [];
    interiore.liberTransactions
    .where((wlt) => wlt.interiore.transactioSignificatio == TransactioSignificatio.perdita)
    .map((mlt) => mlt.interiore.outputs)
    .forEach(ltoi.addAll);
    if (!ltoi.every((eltoi) => eltoi.publicaClavis == lo.last.probationem)) {
      Print.nota(nuntius: 'pecunia non uritur ante probationem', message: 'money is not burned to previous proof');
      return false;
    }
    BigInt comburantur = BigInt.zero;
    for (TransactioOutput to in lto) {
      comburantur += to.pod;
    }
    BigInt conbusit = BigInt.zero;
    for (TransactioOutput to in ltoi) {
      conbusit += to.pod;
    }
    return comburantur == conbusit;
  }
  Future<bool> vicit(List<Obstructionum> lo) async {
    GladiatorInput? gi =
        interiore.gladiator.interiore.input;
    if (gi == null) { 
      Print.nota(
          nuntius: 'Obstructionum gladiatorem sine input',
          message:
              'Block can not have defeaten a gladiator without a gladiator input');
      return false;
    }
    Obstructionum swo = lo.singleWhere((swo) =>
        swo.interiore.gladiator.interiore.identitatis ==
        gi.victima.identitatis);
    String inimicusImpetumBasis = await Pera.turpiaGladiatoriaTelum(
        gi.inimicus.primis, true, gi.inimicus.identitatis, lo);
    List<Telum> inimicusImpetusLiber = await Pera.maximeArma(
        liber: true, primis: gi.inimicus.primis, impetum: true, gladiatorIdentitatis: gi.inimicus.identitatis, lo: lo);
    List<Telum> inimicusImpetusFixum = await Pera.maximeArma(
        liber: false, primis: gi.inimicus.primis, impetum: true, gladiatorIdentitatis: gi.inimicus.identitatis, lo: lo);
    List<String> inimicusImpetus = [inimicusImpetumBasis];
    inimicusImpetusLiber.map((miil) => miil.telum).forEach(inimicusImpetus.addAll);
    inimicusImpetusFixum.map((miif) => miif.telum).forEach(inimicusImpetus.addAll);

    String victimaDefensioBasis = await Pera.turpiaGladiatoriaTelum(
        gi.victima.primis, false, gi.victima.identitatis, lo);
    List<Telum> victimaDefensioLiber = await Pera.maximeArma(
        liber: true, primis: gi.victima.primis, impetum: false, gladiatorIdentitatis: gi.victima.identitatis, lo: lo);
    List<Telum> victimaDefensioFixum = await Pera.maximeArma(
        liber: false, primis: gi.victima.primis, impetum: false, gladiatorIdentitatis: gi.victima.identitatis, lo: lo);
    List<String> victimaDefensiones = [victimaDefensioBasis];
    victimaDefensioLiber
        .map((mvdl) => mvdl.telum)
        .forEach(victimaDefensiones.addAll);
    victimaDefensioFixum
        .map((mvdf) => mvdf.telum)
        .forEach(victimaDefensiones.addAll);
    List<String> requiritur = victimaDefensiones;
    requiritur.removeWhere((rwr) => inimicusImpetus.any((aii) => aii == rwr));
    if (!requiritur.every((er) => probationem.contains(er))) {
      return false;
    }
    List<GladiatorInput?> lgi = [];
    lo
        .map((mo) =>
            mo.interiore.gladiator.interiore.input)
        .forEach(lgi.add);
    if (lgi.any((agi) =>
        agi?.victima.identitatis == gi.victima.identitatis &&
        agi?.victima.primis == gi.victima.primis)) {
      Print.nota(
          nuntius: 'gladiator iam victus est',
          message: 'gladiator is already defeated');
      return false;
    }
    GladiatorOutput go = swo.interiore.gladiator.interiore
        .outputs[gi.victima.primis ? 0 : 1];
    if (!Utils.cognoscereVictusGladiator(
        PublicKey.fromHex(Pera.curve(), interiore.producentis),
        Signature.fromASN1Hex(gi.signature),
        go)) {
      return false;
    }
    return true;
  }

  bool transactionsIncluduntur(List<Obstructionum> lo) {
    List<Transactio> llt = [];
    lo.map((mo) => mo.interiore.liberTransactions).forEach(llt.addAll);
    List<String> llti = [];
    llt.map((mlt) => mlt.interiore.identitatis).forEach(llti.add); 
    // if (!interiore.liberTransactions.every(
    //   (elt) => elt.interiore.inputs.every(
    //     (ei) => llti.any((alti) => ei.transactioIdentitatis == alti) || 
    //     interiore.liberTransactions.any((alt) => alt.interiore.identitatis == ei.transactioIdentitatis)))) {
    //       print('complainedaboveabove');
    //   return false;
    // }
    List<Transactio> let = [];
    lo.map((mo) => mo.interiore.expressiTransactions).forEach(let.addAll);
    List<String> leti = [];
    let.map((met) => met.interiore.identitatis).forEach(leti.add);
    if (!interiore.expressiTransactions.every(
      (eet) => eet.interiore.inputs.every(
        (ei) => leti.any((aeti) => ei.transactioIdentitatis == aeti) || 
        llti.any((alti) =>  ei.transactioIdentitatis == alti) || 
        interiore.liberTransactions.any((alt) => ei.transactioIdentitatis == alt.interiore.identitatis) ||
        interiore.expressiTransactions.any((aet) => ei.transactioIdentitatis == aet.interiore.identitatis)))) {
          print('complainedabove');
          return false;
    }
    List<Transactio> lft = [];
    lo.map((mo) => mo.interiore.fixumTransactions).forEach(lft.addAll);
    List<String> lfti = [];
    lft.map((mft) => mft.interiore.identitatis).forEach(lfti.add);
    if (!interiore.fixumTransactions.every(
      (eft) => eft.interiore.inputs.every(
        (ei) => lfti.any((afti) => ei.transactioIdentitatis == afti) ||
        interiore.fixumTransactions.any((aft) => aft.interiore.identitatis == ei.transactioIdentitatis)))) {
          print('complainedrighthere');
          return false;
        }
    return true;
  }

  static BigInt confirmationes(List<int> from, List<int> to) {
    if (from.length == to.length) {}
    BigInt counter = BigInt.zero;
    while (to.length != from.length) {
      counter += BigInt.parse(
          ((Constantes.maximeCaudicesFile + 1) - from.last).toString());
      from.add(0);
    }
    counter += BigInt.parse((to.last - from.last).toString());
    return counter;
  }

  Future<bool> convalidandumObsturcutionumNumerus(
      Obstructionum incipio, Obstructionum prioro) async {
    for (int i = 0;
        i > prioro.interiore.obstructionumNumerus.length;
        i++) {
      if (interiore.obstructionumNumerus.any((eon) =>
          eon > incipio.interiore.numeruCuneosMaximumsOrdinata!)) {
        return false;
      }
      if (!interiore.obstructionumNumerus.every((eon) =>
          eon <=
          incipio.interiore.numeruCuneosMaximumsOrdinata!)) {
        return false;
      }
    }
    return true;
  }

  // Future<List<SiRemotionemOutput>> inconsumptusRemotionems(
  //     List<Obstructionum> lo) async {
  //   List<SiRemotionem> lsr = [];
  //   lo.map((mo) => mo.interiore.siRemotiones).forEach(lsr.addAll);
  //   List<SiRemotionemOutput?> lsro = [];
  //   lsr
  //       .map((msr) => msr.interioreSiRemotionem.siRemotionemOutput)
  //       .forEach(lsro.add);
  //   List<SiRemotionemInput?> lsri = [];
  //   lsr
  //       .map((msr) => msr.interioreSiRemotionem.siRemotionemInput)
  //       .forEach(lsri.add);
  //   for (SiRemotionemInput? sri in lsri) {
  //     if (sri != null) {
  //       2522222222222 355325222522  35533333333355  53333333333333333333333333333333333333333333333333255 225
  //     }
  //   }
  // }

  static Future removereUltimumObstructionum(Directory directorium) async {
    Obstructionum prioro = await Obstructionum.acciperePrior(directorium);
    if (prioro.interiore.obstructionumNumerus
        .any((aon) => aon == 0)) {
      File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${prioro.interiore.obstructionumNumerus.length - 1}.txt')
          .deleteSync();
    } else {
      File f = File(
          '${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${directorium.listSync().length - 1}.txt');
      List<String> os = await Utils.fileAmnis(f).toList();
      os.removeLast();
      f.deleteSync();
      var s = f.openWrite(mode: FileMode.append);
      for (String o in os) {
        s.write('$o\n');
      }
      await s.close();
    }
  }
  // [1] geeft length van 1
  // [1, 1] geeft length van 2
//  setl je voor prior heeft een numerus van [8, 8, 5];
  // en donec heeft een numerus van [5] 
//   
  static Future removereAdProbationemObstructionum(String probationem, Directory directorium) async {
    List<Obstructionum> lo = await Obstructionum.getBlocks(directorium);
    Obstructionum prioro = await Obstructionum.acciperePrior(directorium);
    Obstructionum donec = lo.singleWhere((swlo) => swlo.probationem == probationem);
    print(' \n iamconf \n');
    print(donec.toJson());
    // int donecLength = donec.interiore.obstructionumNumerus.length;
    if (prioro.interiore.obstructionumNumerus.length > donec.interiore.obstructionumNumerus.length) {
      for (int i = prioro.interiore.obstructionumNumerus.length-1; i >= donec.interiore.obstructionumNumerus.length; i--) {
        File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}$i.txt').deleteSync();
        // prioro.interiore.obstructionumNumerus.removeAt(i);
      }
    }
    File f = File('${Constantes.vincula}/${argumentis!.obstructionumDirectorium}${Constantes.principalis}${Constantes.caudices}${directorium.listSync().length - 1}.txt');
    List<String> os = await Utils.fileAmnis(f).toList();
    os.removeRange(donec.interiore.obstructionumNumerus.last+1, os.length);
    f.deleteSync();
    var s = f.openWrite(mode: FileMode.append);
    for (String o in os) {
      s.write('$o\n');
    }
    await s.close();
  }
  
  Future<bool> convalidandumRationibus(List<Obstructionum> lo) async {
    List<Propter> lnp = [];
    interiore.gladiator.interiore.outputs.map((e) => e.rationibus).forEach(lnp.addAll);
    for (Propter p in lnp) {
      if (await Pera.isPublicaClavisDefended(p.interiore.publicaClavis, lo)) {
        Print.nota(nuntius: 'clausus publicas claves iam defendi conatur defendere', message: 'block tries to defend public keys that already are defended');
        return false;
      }
    }
    return true;
  }
  bool badsewapons() {
    if (interiore.defensio.length != 1) return true;
    if (interiore.impetus.length != 3) return true;
    return false;
  }
  bool convalidandumExpressiMoles() {
    List<Iterable<Transactio>> lllt = [];
    List<String> lltiti = [];
    int counter = 0;
    for (Transactio t in interiore.liberTransactions.reversed.where((wlt) => wlt.interiore.transactioSignificatio == TransactioSignificatio.regularis && !lltiti.contains(wlt.interiore.identitatis))) {
      List<Transactio> llt = [];
      llt.add(t);
      lltiti.add(t.interiore.identitatis);
      Transactio? rt = interiore.liberTransactions.singleWhereOrNull((swonlt) => t.interiore.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interiore.identitatis));
      counter++;
      while (rt != null) {
        counter++;
        llt.add(rt);
        lltiti.add(rt.interiore.identitatis);
        rt = interiore.liberTransactions.singleWhereOrNull((swonlt) => rt!.interiore.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interiore.identitatis));
      }
      lllt.add(llt.reversed);
    }
    List<TransactioInput> leti = [];
    interiore.expressiTransactions.map((met) => met.interiore.inputs).forEach(leti.addAll);
    
    if (
      counter != interiore.expressiTransactions.length || 
      !leti.every((eeti) => interiore.liberTransactions.map((mlt) => mlt.interiore.identitatis).contains(eeti.transactioIdentitatis) || 
      interiore.expressiTransactions.any((aet) => aet.interiore.identitatis == eeti.transactioIdentitatis))) {
        Print.nota(nuntius: 'transactions expressi possunt solum ad current liber transactions', message: 'expressi transactions may only refer to current liber transactions');
      return false;
    }
    for (List<Transactio> llt in lllt.map((e) => e.toList())) {
      BigInt olpod = BigInt.zero;
      for (TransactioOutput lto in llt.last.interiore.outputs.where((wo) => wo.publicaClavis != llt.last.interiore.dominus)) {
        olpod += lto.pod;
      }
      Transactio? et = interiore.expressiTransactions.singleWhere((wet) => wet.interiore.inputs.any((ai) => ai.transactioIdentitatis == llt.last.interiore.identitatis));
      BigInt oepod = BigInt.zero;
      for (TransactioOutput eto in et.interiore.outputs.where((wo) => wo.publicaClavis != et!.interiore.dominus)) {
        oepod += eto.pod;
      }
      if (olpod != oepod) {
        Print.nota(nuntius: 'expressi transactions amounts ad continet iniuriam', message: 'the expressi transactions contain wrong amounts');
        return false;
      }
      for (int i = llt.length-2; i >= 0; i--) {
        BigInt lpod = BigInt.zero;
        for (TransactioOutput lto in llt[i].interiore.outputs.where((wo) => wo.publicaClavis != llt[i].interiore.dominus)) {
          lpod += lto.pod;
        }
        et = interiore.expressiTransactions.singleWhereOrNull((swonet) => swonet.interiore.inputs.any((ai) => ai.transactioIdentitatis == et!.interiore.identitatis));
        BigInt epod = BigInt.zero; 
        for (TransactioOutput eto in et!.interiore.outputs.where((wo) => wo.publicaClavis != et!.interiore.dominus)) {
          epod += eto.pod;
        }
        if (lpod != epod) {
          Print.nota(nuntius: 'expressi transactions amounts ad continet iniuriam', message: 'the expressi transactions contain wrong amounts');
          return false;
        }
      }
    }
    return true;
  }
  // bool convalidandumExpressiLiber() {
  //   List<Transactio> let = [];

  // }
  // bool victusEst() {
  //   GladiatorInput? gi =
  //       interioreObstructionum.gladiator.interioreGladiator.input;
  //   if (gi == null) {
  //     throw BadRequest(
  //         code: 0,
  //         nuntius: 'Gladiator non inveni',
  //         message: 'Gladiator not found');
  //   }
  // }
}
