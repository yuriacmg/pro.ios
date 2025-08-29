// ignore_for_file: lines_longer_than_80_chars
// // ignore_for_file: sort_constructors_first, inference_failure_on_untyped_parameter, avoid_dynamic_calls, lines_longer_than_80_chars

// class RespuestaProcesadaSendModel {
//   String? nroDocumento;
//   int? userConsulta;
//   List<RespuestaProcesada>? respuestas;

//   RespuestaProcesadaSendModel({
//     this.nroDocumento,
//     this.userConsulta,
//     this.respuestas,
//   });

//   RespuestaProcesadaSendModel.fromJson(Map<String, dynamic> json) {
//     nroDocumento = json['nroDocumento'].toString();
//     userConsulta = int.parse(json['userConsulta'].toString());
//     if (json['respuestas'] != null) {
//       respuestas = [];
//       json['respuestas'].forEach((v) {
//         respuestas!.add(RespuestaProcesada.fromJson(v as Map<String, dynamic>));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['nroDocumento'] = nroDocumento;
//     data['userConsulta'] = userConsulta;
//     if (respuestas != null) {
//       data['respuestas'] = respuestas!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class RespuestaProcesada {
//   int? idPregunta;
//   int? valorRespuesta;

//   RespuestaProcesada({this.idPregunta, this.valorRespuesta});

//   RespuestaProcesada.fromJson(Map<String, dynamic> json) {
//     idPregunta = int.parse(json['idPregunta'].toString());
//     valorRespuesta = int.parse(json['valorRespuesta'].toString());
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['idPregunta'] = idPregunta;
//     data['valorRespuesta'] = valorRespuesta;
//     return data;
//   }
// }
