// ignore_for_file: lines_longer_than_80_chars

import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/modules/history/model/history_sync_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/download_file_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/email_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/email_send_search_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_process_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/send_report_model.dart';

abstract class IScholarshipRepository {
  Future<APIResponseModel> getScholarship();
  Future<APIResponseModel> searchUserReniec(ReniecSendModel send);
  Future<APIResponseModel> searchUserReniecIsMinor(ReniecSendModel send);
  Future<APIResponseModel> searchUserReniecIsMinorTutor(ReniecSendModel send);
  Future<APIResponseModel> searchUserReniecFirma(ReniecSendModel send);
  Future<APIResponseModel> searchUserReniecPerformance(ReniecSendModel send);
  Future<APIResponseModel> searchUserReniecPrepareExam(ReniecPrepareSendModel send);
  Future<APIResponseModel> getDataInitPrepareExam();
  Future<APIResponseModel> getDataInitPrepareExam2();
  Future<APIResponseModel> downloadReport(SendReportModel send);
  Future<APIResponseModel> downloadFile(DownloadFileSendModel send);
  Future<APIResponseModel> procesarRespuesta(ForeignProcessSendModel send);
  Future<APIResponseModel> sendEmailRegister(EmailSendModel send);
  Future<APIResponseModel> sendEmailSearch(EmailSendSearchModel send);
  Future<APIResponseModel> downloadFileSolution(int courseCode);
  Future<APIResponseModel> foreignSearch(ForeignSendModel send);
  Future<APIResponseModel> foreignProcess(ForeignProcessSendModel send);
  Future<APIResponseModel> syncHistory(HistorySyncSendModel send, String token);
}
