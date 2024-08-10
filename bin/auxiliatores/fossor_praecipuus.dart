
import 'package:ecdsa/ecdsa.dart';
import 'package:tuple/tuple.dart';

import '../exempla/connexa_liber_expressi.dart';
import '../exempla/gladiator.dart';
import '../exempla/obstructionum.dart';
import '../exempla/pera.dart';
import '../exempla/petitio/incipit_pugna.dart';
import '../exempla/si_remotionem.dart';
import '../exempla/solucionis_propter.dart';
import '../exempla/transactio.dart';
import 'package:collection/collection.dart';
import 'package:elliptic/elliptic.dart';

import '../exempla/utils.dart';


class COE {
  int maxime;
  List<Transactio> llt;
  List<Transactio> lft;
  COE({ required this.maxime, required this.llt, required this.lft });

  Map<String, dynamic> toJson() => {
    'maxime': maxime,
    'llt': llt.map((e) => e.toJson()).toList(),
    'lft': lft.map((e) => e.toJson()).toList()
  };

  static Future<COE> computo({ 
    required bool victimaPrimis, 
    required bool inimicusPrimis, 
    required int maxime, 
    required String ex,
    required Obstructionum prior, 
    required Gladiator gladiatorVictima, 
    required Gladiator gladiatorInimicus, 
    required List<Transactio> llt, 
    required List<Obstructionum> lo }) async {
    List<Transactio> llttbi = [];
    List<Transactio> lfttbi = [];
    List<Transactio> ltp = [];
    List<String> llti = [];
    for (String acc in gladiatorVictima
          .interiore.outputs[victimaPrimis ? 0 : 1].rationibus
          .map((e) => e.interiore.publicaClavis)) {
      InterioreTransactio? it = await Pera.perdita(
        PrivateKey.fromHex(Pera.curve(), ex),
        acc,
        prior.probationem,
        llt,
        lo);
      if (it != null) {
        ltp.add(Transactio.nullam(it));
        llti.add(it.identitatis);
        maxime -= it.inputs.length;
      }
    }
    llttbi.addAll(ltp);
    List<Transactio> ltpr = [];
    for (Transactio t in ltp) {
      Transactio? rtt = llt.singleWhereOrNull((swonlt) => t.interiore.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interiore.identitatis) && !llti.contains(swonlt.interiore.identitatis));
      while (rtt != null) {
        ltpr.add(rtt);
        llti.add(rtt.interiore.identitatis);
        maxime -= 1;
        rtt = llt.singleWhereOrNull((swonlt) => rtt!.interiore.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interiore.identitatis) && !llti.contains(swonlt.interiore.identitatis));
      }
    }
    llttbi.insertAll(0, ltpr);
    List<Transactio> lttf = [];
    for (String acc in gladiatorInimicus.interiore.outputs[inimicusPrimis ? 0 : 1].rationibus.map((mrationibus) => mrationibus.interiore.publicaClavis)) {
          Tuple2<InterioreTransactio?, InterioreTransactio?> transform =
          await Pera.transformFixum(
              ex, acc, llt.where((wlt) => wlt.interiore.transactioSignificatio != TransactioSignificatio.regularis || wlt.interiore.certitudo != null), lo);
      if (transform.item1 != null) {
        llttbi.add(Transactio.nullam(transform.item1!));
        maxime -= transform.item1!.inputs.length;
        for (TransactioInput ti in transform.item1!.inputs) {
          Transactio? ift = llt.singleWhereOrNull(
            (swonlt) => (swonlt.interiore.identitatis == ti.transactioIdentitatis && 
            !llti.contains(swonlt.interiore.identitatis) && 
            swonlt.interiore.transactioSignificatio != TransactioSignificatio.regularis) || 
            (swonlt.interiore.identitatis == ti.transactioIdentitatis && 
            !llti.contains(swonlt.interiore.identitatis) && swonlt.interiore.certitudo != null));
          while (ift != null) {
            lttf.add(ift);
            llti.add(ift.interiore.identitatis); 
            maxime -= 1;
            ift = llt.singleWhereOrNull(
              (swonlt) => (ift!.interiore.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interiore.identitatis) && 
              !llti.contains(swonlt.interiore.identitatis) && 
              swonlt.interiore.transactioSignificatio != TransactioSignificatio.regularis) || 
              (ift.interiore.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interiore.identitatis) && !llti.contains(swonlt.interiore.identitatis) && swonlt.interiore.certitudo != null));
          }  
        }
      }
      if (transform.item2 != null) {
        lfttbi.add(Transactio.nullam(transform.item2!));
      }
      llttbi.insertAll(0, lttf);
    }

    return COE(maxime: maxime, llt: llttbi, lft: lfttbi);
  }
}

class FossorPraecipuus {
  List<Transactio> llttbui = [];
  List<Transactio> llttbi = [];
  List<String> llti = [];
  List<ConnexaLiberExpressi> lcletbi = [];
  List<String> lclei = [];
  List<Transactio> lettbi = [];
  List<String> leti = [];
  List<Transactio> lfttbui = [];
  List<Transactio> lfttbi = [];
  List<String> lfti = [];
  List<Propter> lptbit = [];
  List<Propter> lptbi = [];
  List<String> lpi = [];
  List<SiRemotionem> lsrtbi = [];
  List<String> lsrsoo = [];
  List<String> lsrsoi = [];
  List<String> lsriti = [];
  List<SolucionisPropter> lsptbi = [];
  List<String> lspi = [];
  List<FissileSolucionisPropter> lfsptbi = [];
  List<String> lfspi = [];
  List<InritaTransactio> littbi = [];
  List<String> liti = [];

  List<String> referreDebetIdentitatumLiber = [];
  List<String> referreDebetIdentitatumExpressi = [];

  FossorPraecipuus();

  FossorPraecipuus.coe({ required this.llttbi, required this.lfttbi }): llti = llttbi.map((mlttbi) => mlttbi.interiore.identitatis).toList();

  accipere({ required bool efectus, required int maxime, required Iterable<Transactio> llt, required Iterable<Transactio> lft, required Iterable<Transactio> let, required Iterable<ConnexaLiberExpressi> lcle, required Iterable<SiRemotionem> lsr, required Iterable<Propter> lp, required Iterable<SolucionisPropter> lsp, required Iterable<FissileSolucionisPropter> lfsp, required Iterable<InritaTransactio> lit, required Iterable<Obstructionum> lo }) {      
    Iterable<SiRemotionem> lsrc = List<SiRemotionem>.from(lsr.map((mlsr) => SiRemotionem.fromJson(mlsr.toJson())));
    Iterable<Transactio> lltf = llt.where(
      (wlt) => wlt.interiore.transactioSignificatio != TransactioSignificatio.regularis ||
      (
        wlt.interiore.certitudo != null && 
        Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), wlt.interiore.recipiens), Signature.fromASN1Hex(wlt.interiore.certitudo!), wlt.interiore.identitatis)
      )
    );
    Iterable<Transactio> lftf = lft.where(
      (wft) => wft.interiore.transactioSignificatio != TransactioSignificatio.regularis ||
      (
        wft.interiore.certitudo != null && 
        Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), wft.interiore.recipiens), Signature.fromASN1Hex(wft.interiore.certitudo!), wft.interiore.identitatis)
      )
    );
    Iterable<Transactio> letf = let.where(
      (wet) => wet.interiore.certitudo != null && 
      Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), wet.interiore.recipiens), Signature.fromASN1Hex(wet.interiore.certitudo!), wet.interiore.identitatis)
    );
    print('iwannknowyourprob \n ${letf.map((e) => e.toJson())}');
    lltf.map((mlt) => mlt.interiore.identitatis).forEach(referreDebetIdentitatumLiber.add);
    List<Transactio> llttm = [];
    lo.map((mo) => mo.interiore.liberTransactions).forEach(llttm.addAll);
    llttm.map((mlt) => mlt.interiore.identitatis).forEach(referreDebetIdentitatumLiber.add);
    bool istxs = false;
    bool capta = false;
    for (int i = 6; i > 0; i--) {
      capta = false;
      istxs = true;
      while ((maxime > 0 && !capta) || (istxs && !capta)) {
        int tslt = llttbui.length;
        llttbui.addAll(
            lltf.where((wlt) => wlt.probationem.startsWith('0' * i) && !llti.contains(wlt.interiore.identitatis) && wlt.interiore.inputs.every((ei) => referreDebetIdentitatumLiber.contains(ei.transactioIdentitatis))).isNotEmpty ?  
          lltf.where((wlt) => wlt.probationem.startsWith('0' * i) && !llti.contains(wlt.interiore.identitatis) && wlt.interiore.inputs.every((ei) => referreDebetIdentitatumLiber.contains(ei.transactioIdentitatis))) : 
          []
        );
        maxime -= (llttbui.length - tslt);
        llti.addAll(llttbui.where((wlt) => !llti.contains(wlt.interiore.identitatis)).map((e) => e.interiore.identitatis));
        maxime -= llttbui.length;
        List<Transactio> llttba = [];
        for (Transactio t in llttbui) {
          for (TransactioInput ti in t.interiore.inputs) {
            Transactio? rt = llt.singleWhereOrNull((swonlt) => swonlt.interiore.identitatis == ti.transactioIdentitatis && !llttbui.map((mlt) => mlt.interiore).contains(swonlt.interiore) && !llti.contains(swonlt.interiore.identitatis));
            while (rt != null) {
              maxime -= 1;
              llttba.add(rt);
              llti.add(rt.interiore.identitatis);
              rt = llt.singleWhereOrNull((swonlt) => rt!.interiore.inputs.any((ai) => ai.transactioIdentitatis == swonlt.interiore.identitatis) && !llti.contains(swonlt.interiore.identitatis)  && !llttba.map((mlt) => mlt.interiore).contains(swonlt.interiore) && !llttbui.map((mlt) => mlt.interiore).contains(swonlt.interiore));
            }
          }
        }
        llttbi.addAll(llttbui);
        // llttbi.addAll(llttba);
        llttbi.insertAll(0, llttba);
        llttbui = [];
        if (efectus) {
          int tscle = lcletbi.length;
          List<String> llttbii = [];
          llttbi.map((mlttbi) => mlttbi.interiore.identitatis).forEach(llttbii.add);
          lcletbi.addAll(lcle.where((cle) => llttbii.any((alti) => alti == cle.interioreConnexaLiberExpressi.identitatis) && !lclei.contains(cle.interioreConnexaLiberExpressi.identitatis)).toList());
          maxime -= (lcletbi.length - tscle);
          lclei.addAll(lcletbi.where((wcle) => !lclei.contains(wcle.interioreConnexaLiberExpressi.identitatis)).map((mcle) => mcle.interioreConnexaLiberExpressi.identitatis));
          lettbi.addAll(letf
              .where((et) => lcle.any((cle) =>
              cle.interioreConnexaLiberExpressi.identitatum.any((aei) => aei == et.interiore.identitatis)
              && llttbii.any((alti) => alti == cle.interioreConnexaLiberExpressi.identitatis)
              ) && !leti.contains(et.interiore.identitatis)));
          leti.addAll(lettbi.where((wet) => !leti.contains(wet.interiore.identitatis)).map((met) => met.interiore.identitatis));
        }
        istxs = false;
        istxs = true;
        int tsft = lfttbui.length;
        lfttbui.addAll(
          lftf.where((wft) => wft.probationem.startsWith('0' * i) && !lfti.contains(wft.interiore.identitatis)).isNotEmpty ?  
          lftf.where((wft) => wft.probationem.startsWith('0' * i) && !lfti.contains(wft.interiore.identitatis)): 
          []
        );
        lfti.addAll(lfttbui.where((wft) => !lfti.contains(wft.interiore.identitatis)).map((e) => e.interiore.identitatis));
        maxime -= (lfttbui.length - tsft);
        List<Transactio> lfttba = [];
        for (Transactio t in lfttbui) {
          for (TransactioInput ti in t.interiore.inputs) {
            Transactio? rt = lftf.singleWhereOrNull((swonft) => swonft.interiore.identitatis == ti.transactioIdentitatis);
            while (rt != null) {
              maxime -= 1;
              lfttba.add(rt);
              lfti.add(rt.interiore.identitatis);
              rt = lftf.singleWhereOrNull((swonft) => rt!.interiore.inputs.any((ai) => ai.transactioIdentitatis == swonft.interiore.identitatis) && !lfti.contains(swonft.interiore.identitatis));
            }
          }
        }
        lfttbi.addAll(lfttbui);
        lfttbi.addAll(lfttba);
        lfttbui = [];
        istxs = false;
        istxs  = true;
        int tssr = lsrtbi.length;
        lsrtbi.addAll(lsrc.where((wsr) => wsr.probationem.startsWith('0' * i) && wsr.interiore.siRemotionemOutput != null && !lsrsoo.contains(wsr.interiore.signatureInterioreSiRemotionem)));
        lsrtbi.addAll(lsrc.where((wsr) => wsr.probationem.startsWith('0' * i) && wsr.interiore.siRemotionemInput != null && !lsrsoi.contains(wsr.interiore.siRemotionemInput!.siRemotionemSignature)));
        lsrsoo.addAll(lsrtbi.where((wlsrtbi) => wlsrtbi.interiore.siRemotionemOutput != null && !lsrsoo.contains(wlsrtbi.interiore.signatureInterioreSiRemotionem) && wlsrtbi.interiore.siRemotionemOutput != null).map((msr) => msr.interiore.signatureInterioreSiRemotionem!));        
        maxime -= (lsrtbi.length - tssr);
        List<Transactio> lltrbsr = [];
        lsrtbi.where((wsr) => wsr.interiore.siRemotionemInput != null && wsr.interiore.siRemotionemInput!.interioreTransactio!.liber && !lsrsoi.contains(wsr.interiore.siRemotionemInput!.siRemotionemSignature) && lsriti.contains(wsr.interiore.siRemotionemInput!.interioreTransactio!.identitatis)).map((msr) => Transactio.nullam(msr.interiore.siRemotionemInput!.interioreTransactio!)).forEach(lltrbsr.add);
        lsriti.addAll(lltrbsr.map((mlltrbsr) => mlltrbsr.interiore.identitatis));
        llttbi.insertAll(0, lltrbsr);
        maxime -= lltrbsr.length;
        List<Transactio> lftrbsr = [];
        lsrtbi.where((wsr) => wsr.interiore.siRemotionemInput != null && !wsr.interiore.siRemotionemInput!.interioreTransactio!.liber && !lsrsoi.contains(wsr.interiore.siRemotionemInput!.siRemotionemSignature)).map((msr) => Transactio.nullam(msr.interiore.siRemotionemInput!.interioreTransactio!)).forEach(lftrbsr.add);
        lfttbi.insertAll(0, lftrbsr);
        maxime -= lftrbsr.length;
        lsrsoi.addAll(lsrtbi.where((wlsrtbi) => wlsrtbi.interiore.siRemotionemInput != null && !lsrsoi.contains(wlsrtbi.interiore.siRemotionemInput!.siRemotionemSignature)).map((mlsrtbi) => mlsrtbi.interiore.siRemotionemInput!.siRemotionemSignature));
        
        
        
        istxs = false;
        int tslp = lptbi.length;
        lptbi.addAll(lp.where((wp) => wp.probationem.startsWith('0' * i) && !lpi.contains(wp.interiore.publicaClavis) && wp.interiore.quadrigis.isEmpty));
        lpi.addAll(lptbi.where((wp) => !lpi.contains(wp.interiore.publicaClavis)).map((mp) => mp.interiore.publicaClavis));
        List<Propter> lpta = [];
        outer:  
        //UNUSED
        for (Propter p in lp.where((wp) => wp.probationem.startsWith('0' * i) && !lpi.contains(wp.interiore.publicaClavis) && wp.interiore.quadrigis.isNotEmpty)) {
          // bool signatiAll = true;
          // List<Propter> ilpta = [];
          for (Quadrigis q in p.interiore.quadrigis) {
            if (Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), p.interiore.publicaClavis), Signature.fromASN1Hex(q.signature), q.publicaClavis)) {
              // je gaat zoeken naar een account van q of die jou ook hebben gesigned
              // misschien hier ook loopen over propter
              Propter? pr = lp.singleWhereOrNull((swlp) => swlp.interiore.publicaClavis == q.publicaClavis);
              // Propter? pro = ilpta.singleWhereOrNull((swonilpta) => swonilpta.interiore.publicaClavis == q.publicaClavis);

              if (pr == null) {
                // moet je er voor zorgen dat hij zelf niet meedoet
                // maar we skippen ook helemaal omhoog naar de volgend p in lp
                continue outer;

              }
              // hier uis je iemand erin en moet je die account niet stopepen
              /// hier moet je eigenlijk loepen zijn al die van hem gereferenceerd dus loopen over hen dus ik denk zijn al die pooublic keys ge referentceerd
              /// je kijt hier is er eentje met je moet ook eerder terug schieten je moet nog checken of die propter somehow voor de derde maakt niet meer uit
              /// want je schiet terug nog een keer continue outer als ze niet allemaal de pr.interiore.publicaclavis hebben
              if (pr.interiore.quadrigis.any(
                (aq) => Utils.cognoscereIdentitatis(PublicKey.fromHex(Pera.curve(), pr.interiore.publicaClavis), 
                Signature.fromASN1Hex(aq.signature), p.interiore.publicaClavis))) {
                  for (Quadrigis ffiiq in pr.interiore.quadrigis) {
                    Propter? ffiifp = lp.singleWhereOrNull((swonlp) => swonlp.interiore.publicaClavis == ffiiq.publicaClavis);
                    // Propter? ffiifpo = ilpta.singleWhereOrNull((swonilpta) => swonilpta.interiore.publicaClavis == ffiiq.publicaClavis);
                    if (ffiifp == null) {
                      continue outer;
                    }
                    lpta.add(ffiifp);
                  }
                // ilpta.add(pr);
                maxime -= 1;
              } else {

              } 
            }
          }
          
        }
        lptbi.addAll(lpta);

        maxime -= (lp.length - tslp);
        int tssp = lsptbi.length;
        lsptbi.addAll(lsp.where((wsp) => wsp.probationem.startsWith('0' * i) && !lspi.contains(wsp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis)));
        lspi.addAll(lsptbi.where((wsp) => !lspi.contains(wsp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis)).map((msp) => msp.interioreSolucionisPropter.interioreInterioreSolucionisPropter.solucionis));
        maxime -= (lsptbi.length - tssp);
        int tsfsp = lfsptbi.length;
        lfsptbi.addAll(lfsp.where((wfsp) => wfsp.probationem.startsWith('0' * i) && !lfspi.contains(wfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis)));
        lfspi.addAll(lfsptbi.where((wfsp) => !lfspi.contains(wfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis)).map((mfsp) => mfsp.interioreFissileSolucionisPropter.interioreInterioreFissileSolucionisPropter.solucionis));
        maxime -= (lfsptbi.length - tsfsp);
        int tsit = littbi.length;
        littbi.addAll(lit.where((wit) => wit.probationem.startsWith('0' * i) && !liti.contains(wit.interiore.identitatis)));
        liti.addAll(littbi.where((wit) => !liti.contains(wit.interiore.identitatis)).map((mit) => mit.interiore.identitatis));
        maxime = (littbi.length - tsit);
        print('reachedendcaptawillbetrue');
        print('andlfsptbi?? ${lfsptbi.map((e) => e.toJson())}');
        capta = true;        
      }
    }
  }

  reset() {
    llttbui = [];
    llttbi = [];
    llti = [];
    lcletbi = [];
    lclei = [];
    lettbi = [];
    leti = [];
    lfttbui = [];
    lfttbi = [];
    lfti = [];
    lptbi = [];
    lpi = [];
    lsrtbi = [];
    lsrsoo = [];
    lsrsoi = [];
    lsptbi = [];
    lspi = [];
    lfsptbi = [];
    lspi = [];
    littbi = [];
    liti = [];
    referreDebetIdentitatumLiber = [];
    referreDebetIdentitatumExpressi = [];
  }
}