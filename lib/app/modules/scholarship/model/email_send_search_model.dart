// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class EmailSendSearchModel {
  List<int>? modalidadesId;
  String? correo;

  EmailSendSearchModel({this.modalidadesId, this.correo});

  EmailSendSearchModel.fromJson(Map<String, dynamic> json) {
    modalidadesId = (json['modalidadesId'] as List<dynamic>).map((e) => e as int).toList();
    correo = json['correo'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['modalidadesId'] = modalidadesId;
    data['correo'] = correo;
    return data;
  }
}
