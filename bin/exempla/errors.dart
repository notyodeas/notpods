class BadRequest {
  final int code;
  final String nuntius;
  final String message;
  String? falses;
  BadRequest(
      {required this.code, required this.nuntius, required this.message, this.falses});
  Map<String, dynamic> toJson() =>
      {'code': code, 'nuntius': nuntius, 'message': message, 'falses': falses };
}
