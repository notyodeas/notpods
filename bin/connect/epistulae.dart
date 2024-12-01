import '../exempla/connexa_liber_expressi.dart';
import '../exempla/constantes.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/si_remotionem.dart';
import '../exempla/solucionis_propter.dart';
import '../exempla/transactio.dart';

class PervideasNuntius {
  String titulus;
  List<String> accepit;
  PervideasNuntius(this.titulus, this.accepit);
  PervideasNuntius.ex(Map<String, dynamic> nuntius)
      : titulus = nuntius[PervideasNuntiusCasibus.titulus],
        accepit = List<String>.from(
            nuntius[PervideasNuntiusCasibus.accepit] as Iterable<dynamic>);
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class UnaBasesSingulasPervideasNuntius extends PervideasNuntius {
  String nervus;
  UnaBasesSingulasPervideasNuntius(
      this.nervus, String titulus, List<String> accepit)
      : super(titulus, accepit);

  UnaBasesSingulasPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : nervus = nuntius[PervideasNuntiusCasibus.nervus].toString(),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.nervus: nervus,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class InConnectPervideasNuntius extends PervideasNuntius {
  List<String> bases = [];
  List<Propter> rationibus = [];
  List<Transactio> liberTansactions = [];
  List<Transactio> fixumTransactions = [];
  List<Transactio> expressiTransactions = [];
  List<InritaTransactio> inritaTransactions = [];
  List<SiRemotionem> siRemotionems = [];
  List<ConnexaLiberExpressi> connexaLiberExpressis = [];
  List<SolucionisPropter> solucionisRationibus = [];
  List<FissileSolucionisPropter> fissileSolucionisRationibus = [];

  InConnectPervideasNuntius(
      {required this.bases,
      required this.rationibus,
      required this.liberTansactions,
      required this.fixumTransactions,
      required this.expressiTransactions,
      required this.inritaTransactions,
      required this.siRemotionems,
      required this.connexaLiberExpressis,
      required this.solucionisRationibus,
      required this.fissileSolucionisRationibus,
      required String titulus,
      required List<String> accepit})
      : super(titulus, accepit);

  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.bases: bases,
        PervideasNuntiusCasibus.rationibus: rationibus,
        PervideasNuntiusCasibus.liberTransactions:
            liberTansactions.map((lt) => lt.toJson()).toList(),
        PervideasNuntiusCasibus.fixumTransactions:
            fixumTransactions.map((ft) => ft.toJson()).toList(),
        PervideasNuntiusCasibus.expressiTransactions:
            expressiTransactions.map((et) => et.toJson()).toList(),
        PervideasNuntiusCasibus.connexaLiberExpressi:
            connexaLiberExpressis.map((cle) => cle.toJson()).toList(),
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };

  InConnectPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : bases = List<String>.from(
            nuntius[PervideasNuntiusCasibus.bases] as List<dynamic>),
        rationibus = List<Propter>.from(
            (nuntius[PervideasNuntiusCasibus.rationibus] as List<dynamic>)
                .map((p) => Propter.fromJson(p as Map<String, dynamic>))),
        liberTansactions = List<Transactio>.from(
          (nuntius[PervideasNuntiusCasibus.liberTransactions] as List<dynamic>)
              .map((lt) => Transactio.fromJson(lt as Map<String, dynamic>)),
        ),
        fixumTransactions = List<Transactio>.from(
            (nuntius[PervideasNuntiusCasibus.fixumTransactions]
                    as List<dynamic>)
                .map((ft) => Transactio.fromJson(ft as Map<String, dynamic>))),
        expressiTransactions = List<Transactio>.from(
            (nuntius[PervideasNuntiusCasibus.expressiTransactions]
                    as List<dynamic>)
                .map((et) => Transactio.fromJson(et as Map<String, dynamic>))),
        connexaLiberExpressis = List<ConnexaLiberExpressi>.from((nuntius[
                PervideasNuntiusCasibus.connexaLiberExpressi] as List<dynamic>)
            .map((cle) =>
                ConnexaLiberExpressi.fromJson(cle as Map<String, dynamic>))),
        super.ex(nuntius);
}

class TransactioPervideasNuntius extends PervideasNuntius {
  Transactio transactio;
  TransactioPervideasNuntius(
      this.transactio, String titulus, List<String> accepit)
      : super(titulus, accepit);
  TransactioPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : transactio = Transactio.fromJson(
            nuntius[PervideasNuntiusCasibus.transactio]
                as Map<String, dynamic>),
        super.ex(nuntius);

  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.transactio: transactio.toJson(),
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class LiberTransactioPervideasNuntius extends TransactioPervideasNuntius {
  LiberTransactioPervideasNuntius(
      Transactio transactio, String titulust, List<String> accepit)
      : super(transactio, titulust, accepit);
  LiberTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : super.ex(nuntius);
}

class FixumTransactioPervideasNuntius extends TransactioPervideasNuntius {
  FixumTransactioPervideasNuntius(
      Transactio transactio, String titulust, List<String> accepit)
      : super(transactio, titulust, accepit);
  FixumTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : super.ex(nuntius);
}

class ExpressiTransactioPervideasNuntius extends TransactioPervideasNuntius {
  Transactio transactio;
  ExpressiTransactioPervideasNuntius(
      this.transactio, String titulust, List<String> accepit)
      : super(transactio, titulust, accepit);
  ExpressiTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : transactio = Transactio.fromJson(
            nuntius[PervideasNuntiusCasibus.transactio]
                as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit,
        PervideasNuntiusCasibus.transactio: transactio.toJson()
      };
}

class PetitioExpressiTransactioPervideasNuntius extends PervideasNuntius {
  PetitioExpressiTransactioPervideasNuntius(String titulus, List<String> accepit): super(titulus, accepit);
  PetitioExpressiTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius): super.ex(nuntius);
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}
class DareExpressiTransactioPervideasNuntius extends PervideasNuntius {
  Transactio transactio;
  DareExpressiTransactioPervideasNuntius(this.transactio, String titulus, List<String> accepit): super(titulus, accepit);
  DareExpressiTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius): 
  transactio = Transactio.fromJson(nuntius[PervideasNuntiusCasibus.transactio] as Map<String, dynamic>),
  super.ex(nuntius);
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit,
    PervideasNuntiusCasibus.transactio: transactio.toJson()
  };
}
class ConnexaLiberExpressiPervideasNuntius extends PervideasNuntius {
  ConnexaLiberExpressi cle;
  ConnexaLiberExpressiPervideasNuntius(
      this.cle, String titulust, List<String> accepit)
      : super(titulust, accepit);
  ConnexaLiberExpressiPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : cle = ConnexaLiberExpressi.fromJson(
            nuntius[PervideasNuntiusCasibus.cle] as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.cle: cle.toJson(),
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class SiRemotionemPervideasNuntius extends PervideasNuntius {
  SiRemotionem siRemotionem;
  SiRemotionemPervideasNuntius(
      this.siRemotionem, String titulus, List<String> accepit)
      : super(titulus, accepit);
  SiRemotionemPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : siRemotionem = SiRemotionem.fromJson(
            nuntius[PervideasNuntiusCasibus.siRemotionem]
                as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.siRemotionem: siRemotionem,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class SolucionisPropterPervideasNuntius extends PervideasNuntius {
  SolucionisPropter solucionisPropter;
  SolucionisPropterPervideasNuntius(this.solucionisPropter, String titulus, List<String> accepit): super(titulus, accepit);
  SolucionisPropterPervideasNuntius.ex(Map<String, dynamic> nuntius): solucionisPropter = SolucionisPropter.fromJson(nuntius[PervideasNuntiusCasibus.solucionisPropter] as Map<String, dynamic>), super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.solucionisPropter: solucionisPropter.toJson(),
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}
class FissileSolucionisPropterPervideasNuntius extends PervideasNuntius {
  FissileSolucionisPropter fissileSolucionisPropter;
  FissileSolucionisPropterPervideasNuntius(this.fissileSolucionisPropter, String titulus, List<String> accepit): super(titulus, accepit);
  FissileSolucionisPropterPervideasNuntius.ex(Map<String, dynamic> nuntius): fissileSolucionisPropter = FissileSolucionisPropter.fromJson(nuntius[PervideasNuntiusCasibus.solucionisPropter] as Map<String, dynamic>), super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.solucionisPropter: fissileSolucionisPropter.toJson(),
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}


class PropterPervideasNuntius extends PervideasNuntius {
  Propter propter;
  PropterPervideasNuntius(this.propter, String titulust, List<String> accepit)
      : super(titulust, accepit);
  PropterPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : propter = Propter.fromJson(
            nuntius[PervideasNuntiusCasibus.propter] as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.propter: propter.toJson(),
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class PrepareObstructionumAnswerPervideasNuntius extends PervideasNuntius {
  List<String> bases;
  PrepareObstructionumAnswerPervideasNuntius(
      this.bases, String titulust, List<String> accepit)
      : super(titulust, accepit);
  PrepareObstructionumAnswerPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : bases = List<String>.from(
            nuntius[PervideasNuntiusCasibus.bases] as List<dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.bases: bases,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

// enum Exemplar { liber, expressi, fixum }

// extension ExemplarFromJson on Exemplar {
//   static fromJson(String name) {
//     switch (name) {
//       case 'liber':
//         return Exemplar.liber;
//       case 'expressi':
//         return Exemplar.expressi;
//       case 'fixum':
//         return Exemplar.fixum;
//     }
//   }
// }

class RemoveByIdentitatumPervideasNuntius extends PervideasNuntius {
  List<String> identitatum;
  RemoveByIdentitatumPervideasNuntius(this.identitatum, String titulus, List<String> accepit): super(titulus, accepit);
  RemoveByIdentitatumPervideasNuntius.ex(Map<String, dynamic> nuntius): identitatum = List<String>.from(nuntius[PervideasNuntiusCasibus.identitatum] as List<dynamic>), super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.identitatum: identitatum,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
  };
}
// class RemoveTransactionsPervideasNuntius extends PervideasNuntius {
//   TransactioGenus transactioGenus;
//   List<String> identitatum;
//   RemoveTransactionsPervideasNuntius(
//       this.transactioGenus, this.identitatum, String titulust, List<String> accepit)
//       : super(titulust, accepit);
//   RemoveTransactionsPervideasNuntius.ex(Map<String, dynamic> nuntius)
//       : transactioGenus =
//             TransactioGenusFromJson.fromJson(nuntius[PervideasNuntiusCasibus.transactioGenus])
//                 as TransactioGenus,
//         identitatum = List<String>.from(
//             nuntius[PervideasNuntiusCasibus.identitatum] as List<dynamic>),
//         super.ex(nuntius);
//   @override
//   Map<String, dynamic> indu() => {
//     PervideasNuntiusCasibus.transactioGenus: transactioGenus.name.toString(),
//     PervideasNuntiusCasibus.identitatum: identitatum,
//     PervideasNuntiusCasibus.titulus: titulus,
//     PervideasNuntiusCasibus.accepit: accepit
//   };
// }

class RemoveSiRimotionemRemovePervideasNuntius extends PervideasNuntius {
  SiRemotionemRemoveNuntius srrn;
  RemoveSiRimotionemRemovePervideasNuntius(this.srrn, String titulus, List<String> accepit): super(titulus, accepit);
  RemoveSiRimotionemRemovePervideasNuntius.ex(Map<String, dynamic> nuntius):
    srrn = SiRemotionemRemoveNuntius.fromJson(nuntius[PervideasNuntiusCasibus.srrn] as Map<String, dynamic>), super.ex(nuntius);
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.srrn: srrn.toJson(),
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}

class InritaTransactioPervideasNuntius extends PervideasNuntius {
  InterioreInritaTransactio interiore;
  InritaTransactioPervideasNuntius(this.interiore, String titulus, List<String> accepit): super(titulus, accepit);
  
  InritaTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius): interiore = InterioreInritaTransactio.fromJson(nuntius[PervideasNuntiusCasibus.interiore]), super.ex(nuntius);
  
  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.interiore: interiore.toJson(),
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}
class NeTransactioPervideasNuntius extends PervideasNuntius {
  InritaTransactio it;
  NeTransactioPervideasNuntius(this.it, String titulus, List<String> accepit): super(titulus, accepit);

  NeTransactioPervideasNuntius.ex(Map<String, dynamic> nuntius):
    it = InritaTransactio.fromJson(nuntius[PervideasNuntiusCasibus.it] as Map<String, dynamic>), super.ex(nuntius);
  
  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.it: it.toJson(),
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}
class SumoTransactionsPervideasNuntius extends PervideasNuntius {
  TransactioGenus transactioGenus;
  List<String> identitatum;
  SumoTransactionsPervideasNuntius(this.transactioGenus, this.identitatum, String titulust, List<String> accepit): super(titulust, accepit);
  SumoTransactionsPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : transactioGenus =
            TransactioGenusFromJson.fromJson(nuntius[PervideasNuntiusCasibus.transactioGenus].toString())
                as TransactioGenus,
        identitatum = List<String>.from(
            nuntius[PervideasNuntiusCasibus.identitatum] as List<dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.transactioGenus: transactioGenus.name.toString(),
    PervideasNuntiusCasibus.identitatum: identitatum,
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}
class ObstructionumPervideasNuntius extends PervideasNuntius {
  Obstructionum obstructionum;
  ObstructionumPervideasNuntius(
      this.obstructionum, String titulust, List<String> accepit)
      : super(titulust, accepit);
  ObstructionumPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : obstructionum = Obstructionum.fromJson(
            nuntius['obstructionum'] as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.obstructionum: obstructionum.toJson(),
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class PetitioObstructionumPervideasNuntius extends PervideasNuntius {
  String probationem;
  // bool isMajor;
  // int numerus;
  PetitioObstructionumPervideasNuntius(
      this.probationem, String titulust, List<String> accepit)
      : super(titulust, accepit);
  // PetitioObstructionumPervideasNuntius.major(
  //     this.probationem, this.isMajor, this.numerus, String titulust, List<String> accepit)
  //     : super(titulust, accepit);
  PetitioObstructionumPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : probationem = nuntius[PervideasNuntiusCasibus.probationem].toString(),
        // isMajor = nuntius[PervideasNuntiusCasibus.isMajor],
        // numerus = nuntius[PervideasNuntiusCasibus.numerus],
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.probationem: probationem,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit,
        // PervideasNuntiusCasibus.isMajor: isMajor,
        // PervideasNuntiusCasibus.numerus: numerus
      };
}

class MatchingInvenireProbationemPervideasNuntius extends PervideasNuntius {
  String probationem;
  MatchingInvenireProbationemPervideasNuntius(
      this.probationem, String titulust, List<String> accepit)
      : super(titulust, accepit);
  MatchingInvenireProbationemPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : probationem = nuntius[PervideasNuntiusCasibus.probationem].toString(),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.probationem: probationem,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class PetitioObstructionumIncipioPervideasNuntius extends PervideasNuntius {
  PetitioObstructionumIncipioPervideasNuntius(
      String titulus, List<String> accepit)
      : super(titulus, accepit);
  PetitioObstructionumIncipioPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : super.ex(nuntius);
}

class PetitioSummumObsturctionumProbationemPervideasNuntius
    extends PervideasNuntius {
  String ip;
  List<String> documenta;
  PetitioSummumObsturctionumProbationemPervideasNuntius(
      this.ip, this.documenta, String titulus, List<String> accepit)
      : super(titulus, accepit);
  PetitioSummumObsturctionumProbationemPervideasNuntius.ex(
      Map<String, dynamic> nuntius)
      : ip = nuntius[PervideasNuntiusCasibus.ip],
        documenta =
            List<String>.from(nuntius[PervideasNuntiusCasibus.documenta]),
        super.ex(nuntius);
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class ObstructionumSalvarePervideasNuntius extends PervideasNuntius {
  Obstructionum obstructionum;
  ObstructionumSalvarePervideasNuntius(
      this.obstructionum, String titulus, List<String> accepit)
      : super(titulus, accepit);
  ObstructionumSalvarePervideasNuntius.ex(Map<String, dynamic> nuntius)
      : obstructionum = Obstructionum.fromJson(
            nuntius[PervideasNuntiusCasibus.obstructionum]
                as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.obstructionum: obstructionum.toJson(),
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}


class ObstructionumReponereUnaPervideasNuntius extends PervideasNuntius {
  bool? remove;
  Obstructionum obstructionum;
  ObstructionumReponereUnaPervideasNuntius({
      this.remove, required this.obstructionum, required String titulus, required List<String> accepit})
      : super(titulus, accepit);
  ObstructionumReponereUnaPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : remove = nuntius[PervideasNuntiusCasibus.remove].toString() == 'null' ? null : nuntius[PervideasNuntiusCasibus.remove],
        obstructionum = Obstructionum.fromJson(
            nuntius[PervideasNuntiusCasibus.obstructionum]
                as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.remove: remove,
        PervideasNuntiusCasibus.obstructionum: obstructionum.toJson(),
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      }..removeWhere((key, value) => value == null);
}

class ObstructionumReponerePervideasNuntius extends PervideasNuntius {
  Obstructionum postea;
  ObstructionumReponerePervideasNuntius(
      this.postea, String titulus, List<String> accepit)
      : super(titulus, accepit);
  ObstructionumReponerePervideasNuntius.ex(Map<String, dynamic> nuntius)
      : postea =
            Obstructionum.fromJson(nuntius[PervideasNuntiusCasibus.postea]),
        super.ex(nuntius);
}

class SummaScandalumExNodoPervideasNuntius extends PervideasNuntius {
  List<int> numerus;
  SummaScandalumExNodoPervideasNuntius(
      this.numerus, String titulus, List<String> accepit)
      : super(titulus, accepit);
  SummaScandalumExNodoPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : numerus = List<int>.from(nuntius[PervideasNuntiusCasibus.numerus]),
        super.ex(nuntius);

  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.numerus: numerus,
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit
      };
}

class SatusFurcaPropagationemPervideasNuntius extends PervideasNuntius {
  Obstructionum obstructionum;
  SatusFurcaPropagationemPervideasNuntius(
      this.obstructionum, String titulus, List<String> accepit)
      : super(titulus, accepit);
  SatusFurcaPropagationemPervideasNuntius.ex(Map<String, dynamic> nuntius)
      : obstructionum = Obstructionum.fromJson(
            nuntius[PervideasNuntiusCasibus.obstructionum]
                as Map<String, dynamic>),
        super.ex(nuntius);
  @override
  Map<String, dynamic> indu() => {
        PervideasNuntiusCasibus.titulus: titulus,
        PervideasNuntiusCasibus.accepit: accepit,
        PervideasNuntiusCasibus.obstructionum: obstructionum
      };
}

class InvalidumFurcaPervideasNuntius extends PervideasNuntius {
  InvalidumFurcaPervideasNuntius(String titulus, List<String> accepit): super(titulus, accepit);
  InvalidumFurcaPervideasNuntius.ex(Map<String, dynamic> nuntius): super.ex(nuntius);
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}

class NonInvenioFurcaPervideasNuntius extends PervideasNuntius {
  NonInvenioFurcaPervideasNuntius(String titulus, List<String> accepit): super(titulus, accepit);
  NonInvenioFurcaPervideasNuntius.ex(Map<String, dynamic> nuntius): super.ex(nuntius);
  @override 
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}

class PosseSyncFurcaPervideasNuntius extends PervideasNuntius {
  String summum;
  PosseSyncFurcaPervideasNuntius(this.summum, String titulus, List<String> accepit): super(titulus, accepit);
  PosseSyncFurcaPervideasNuntius.ex(Map<String , dynamic> nuntius):
    summum = nuntius[PervideasNuntiusCasibus.summum], super.ex(nuntius);

  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.summum: summum,
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}
class DeclinareFurcaPervideasNuntius extends PervideasNuntius {
  List<String> lymphaticorum;
  DeclinareFurcaPervideasNuntius(this.lymphaticorum, String titulus, List<String> accepit): super(titulus, accepit);
  DeclinareFurcaPervideasNuntius.ex(Map<String, dynamic> nuntius): 
  lymphaticorum = List<String>.from(nuntius[PervideasNuntiusCasibus.lymphaticorum]),
  super.ex(nuntius);

  @override
  Map<String, dynamic> indu() => {
      PervideasNuntiusCasibus.lymphaticorum: lymphaticorum,
      PervideasNuntiusCasibus.titulus: titulus,
      PervideasNuntiusCasibus.accepit: accepit
    };
}

class RemovePropterStagnumPervideasNuntius extends PervideasNuntius {
  RemovePropterStagnum rps;
  RemovePropterStagnumPervideasNuntius(this.rps, String titulus, List<String> accepit): super(titulus, accepit);
  RemovePropterStagnumPervideasNuntius.ex(Map<String, dynamic> nuntius): 
  rps = RemovePropterStagnum.fromJson(nuntius[PervideasNuntiusCasibus.rps] as Map<String, dynamic>), super.ex(nuntius);

  @override
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.rps: rps.toJson(),
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}

class RespondBasesPervideasNuntius extends PervideasNuntius {
  List<String> bases;
  RespondBasesPervideasNuntius(this.bases, String titulus, List<String> accepit): super(titulus, accepit);
  RespondBasesPervideasNuntius.ex(Map<String, dynamic> nuntius):
    bases = List<String>.from(nuntius[PervideasNuntiusCasibus.bases]), super.ex(nuntius);
  
  Map<String, dynamic> indu() => {
    PervideasNuntiusCasibus.bases: bases,
    PervideasNuntiusCasibus.titulus: titulus,
    PervideasNuntiusCasibus.accepit: accepit
  };
}


// class SyncFurcaAccepitPervideasNuntius extends PervideasNuntius {
//   Obstructionum obstructionum;
//   SyncFurcaAccepitPervideasNuntius(this.obstructionum, String titulus, List<String> accepit): super(titulus, accepit);
//   SyncFurcaAccepitPervideasNuntius.ex(Map<String, dynamic> nuntius):
//     obstructionum = Obstructionum.fromJson(nuntius[PervideasNuntiusCasibus.obstructionum]), super.ex(nuntius);
//   @override
//   Map<String, dynamic> indu() => {
//     PervideasNuntiusCasibus.obstructionum: obstructionum.toJson(),
//     PervideasNuntiusCasibus.titulus: titulus,
//     PervideasNuntiusCasibus.accepit: accepit
//   };
  
// }
