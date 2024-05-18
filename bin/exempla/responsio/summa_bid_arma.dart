import '../constantes.dart';
import '../obstructionum_arma.dart';

class SummaBidArma {
  String probationem;
  BigInt summaBidnotliber;
  BigInt summaBidnotfixum;
  ObstructionumArma obstructionumArma;
  SummaBidArma(this.probationem, this.summaBidnotliber, this.summaBidnotfixum, this.obstructionumArma);
  Map<String, dynamic> toJson() => {
        JSON.probationem: probationem,
        JSON.summaBidNotFixum: summaBidnotfixum.toString(),
        JSON.summaBidNotLiber: summaBidnotliber.toString(),
        JSON.obstructionumArma: obstructionumArma.toJson()
      };
}
