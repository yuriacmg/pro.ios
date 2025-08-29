// ignore_for_file: lines_longer_than_80_chars

class VersionSendModel {
  VersionSendModel({
    required this.versionOs,
    required this.descOs,
    required this.ip,
    required this.tokenPushNoti,
    required this.idUnicoPushNoti,
  });

  factory VersionSendModel.fromJson(Map<String, dynamic> json) => VersionSendModel(
        versionOs: json['versionOS'].toString(),
        descOs: json['descOS'].toString(),
        ip: json['ip'].toString(),
        tokenPushNoti: json['tokenPushNoti'].toString(),
        idUnicoPushNoti: json['idUnicoPushNoti'].toString(),
      );

  String versionOs;
  String descOs;
  String ip;
  String tokenPushNoti;
  String idUnicoPushNoti;

  Map<String, dynamic> toJson() => {
        'versionOS': versionOs,
        'descOS': descOs,
        'ip': ip,
        'tokenPushNoti': tokenPushNoti,
        'idUnicoPushNoti': idUnicoPushNoti,
      };
}
