import 'dart:math';
import 'dart:io';
import 'package:hex/hex.dart';
import 'dart:convert';
import './gladiator.dart';
import 'package:elliptic/elliptic.dart';
import './transactio.dart';
import 'package:ecdsa/ecdsa.dart';
import 'connexa_liber_expressi.dart';
import 'si_remotionem.dart';
import 'solucionis_propter.dart';
import 'package:encoder/encoder.dart';
class Utils {
  static final Random _random = Random.secure();

  static String randomHex(int length) {
    var values = List<int>.generate(length, (index) => _random.nextInt(256));
    return HEX.encode(values);
  }

  static Stream<String> fileAmnis(File file) =>
      file.openRead().transform(utf8.decoder).transform(LineSplitter());

  static String signum(PrivateKey privateKey, dynamic output) =>
      signature(privateKey, utf8.encode(Encoder.encodeJson(output.toJson())))
          .toASN1Hex();

  static String signumIdentitatis(PrivateKey privateKey, String identitatis) => 
      signature(privateKey, utf8.encode(identitatis)).toASN1Hex();
  static bool cognoscereVictusGladiator(PublicKey publicaClavis,
          Signature signature, GladiatorOutput gladiatorOutput) =>
      verify(publicaClavis, utf8.encode(Encoder.encodeJson(gladiatorOutput.toJson())),
          signature);
  static bool cognoscere(PublicKey publicaClavis, Signature signature,
          TransactioOutput txOutput) =>
      verify(publicaClavis, utf8.encode(Encoder.encodeJson(txOutput.toJson())),
          signature);

  static bool cognoscereConnexaLiberExpressi(PublicKey publicaClavis,
          Signature signature, InterioreConnexaLiberExpressi icle) =>
      verify(publicaClavis, utf8.encode(Encoder.encodeJson(icle.toJson())), signature);

  static bool cognoscereIdentitatis(PublicKey publicaClavis, Signature signature, String identitatis) => 
      verify(publicaClavis, utf8.encode(identitatis), signature);
  static bool cognoscereTransform(
          PublicKey publicaClavis, Signature signature, TransactioInput ti) =>
      verify(publicaClavis, utf8.encode(Encoder.encodeJson(ti.toJson())), signature);

  static bool cognoscereSiRemotionemOutput(PublicKey publicaClavis,
          Signature signature, SiRemotionemOutput sro) =>
      verify(publicaClavis, utf8.encode(Encoder.encodeJson(sro.toJson())), signature);
  static bool cognoscereInterioreSiRemotionem(PublicKey publicaClavis, Signature signature, InterioreSiRemotionem isr) => verify(publicaClavis, utf8.encode(Encoder.encodeJson(isr.toJson())), signature);

  static bool cognoscereInterioreInterioreSolucionisPropter(PublicKey publicaClavis, Signature signature, InterioreInterioreSolucionisPropter iisp) =>  
    verify(publicaClavis, utf8.encode(Encoder.encodeJson(iisp.toJson())), signature);
  
  static bool cognoscereInterioreInterioreFissileSolucionisPropter(PublicKey publicaClavis, Signature signature, InterioreInterioreFissileSolucionisPropter iifsp) =>  
    verify(publicaClavis, utf8.encode(Encoder.encodeJson(iifsp.toJson())), signature);
    
}
