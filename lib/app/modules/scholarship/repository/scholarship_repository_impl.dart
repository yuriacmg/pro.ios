// ignore_for_file: lines_longer_than_80_chars

import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/modules/history/model/history_sync_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/download_file_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/email_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/email_send_search_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_process_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/send_report_model.dart';
import 'package:perubeca/app/modules/scholarship/repository/i_scholarship_repository.dart';
import 'package:perubeca/app/modules/scholarship/service/scholarship_service.dart';

class ScholarshipRepositoryImpl extends IScholarshipRepository {
  ScholarshipRepositoryImpl();

  final ScholarShipService service = getItApp.get<ScholarShipService>();

  @override
  Future<APIResponseModel> getScholarship() async {
    return service.getScholarship();
  }

  @override
  Future<APIResponseModel> searchUserReniec(ReniecSendModel send) async {
    return service.searchUserReniec(send);
  }

  @override
  Future<APIResponseModel> searchUserReniecIsMinor(ReniecSendModel send) async {
    return service.searchUserReniecIsMinor(send);
  }

  @override
  Future<APIResponseModel> searchUserReniecIsMinorTutor(ReniecSendModel send) async {
    return service.searchUserReniecIsMinorTutor(send);
  }

  @override
  Future<APIResponseModel> searchUserReniecFirma(ReniecSendModel send) async {
    return service.searchUserReniecFirma(send);
  }

  @override
  Future<APIResponseModel> downloadReport(SendReportModel send) async {
    return service.downloadReport(send);
  }

  @override
  Future<APIResponseModel> downloadFile(DownloadFileSendModel send) async {
    return service.downloadFile(send);
  }

  @override
  Future<APIResponseModel> procesarRespuesta(ForeignProcessSendModel send) {
    return service.responseMixtProcess(send);
  }

  @override
  Future<APIResponseModel> sendEmailRegister(EmailSendModel send) {
    return service.sendEmailRegister(send);
  }

   @override
  Future<APIResponseModel> sendEmailSearch(EmailSendSearchModel send) {
    return service.sendEmailSearchMod(send);
  }

  @override
  Future<APIResponseModel> searchUserReniecPerformance(ReniecSendModel send) {
    return service.searchUserReniecPerformance(send);
  }

  @override
  Future<APIResponseModel> searchUserReniecPrepareExam(ReniecPrepareSendModel send) {
    return service.searchUserReniecPrepareExam(send);
  }

  @override
  Future<APIResponseModel> getDataInitPrepareExam() {
    return service.getDataInitPrepareExam();
  }

  @override
  Future<APIResponseModel> getDataInitPrepareExam2() {
    return service.getDataInitPrepareExam2();
  }

  @override
  Future<APIResponseModel> downloadFileSolution(int courseCode) {
    return service.downloadFileSolution(courseCode);
  }

  @override
  Future<APIResponseModel> foreignSearch(ForeignSendModel send) {
    return service.searchForeignSearch(send);
  }

  @override
  Future<APIResponseModel> foreignProcess(ForeignProcessSendModel send) {
    return service.responseMixtProcess(send);
  }

  @override
  Future<APIResponseModel> syncHistory(HistorySyncSendModel send, String token) {
   return service.syncHistory(send, token);
  }
}
