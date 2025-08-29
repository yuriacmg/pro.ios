part of 'download_file_bloc.dart';

abstract class DownloadFileState extends Equatable {
  const DownloadFileState();

  @override
  List<Object> get props => [];
}

class DownloadFileInitialState extends DownloadFileState {
  const DownloadFileInitialState();

  @override
  List<Object> get props => [];
}

class DownloadFileLoadingState extends DownloadFileState {
  const DownloadFileLoadingState();

  @override
  List<Object> get props => [];
}

class DownloadFileCompleteState extends DownloadFileState {
  const DownloadFileCompleteState(this.response);

  final FileResponseModel response;

  @override
  List<Object> get props => [response];
}

class ErrorState extends DownloadFileState {
  const ErrorState({required this.error});

  final ErrorResponseModel error;

  @override
  List<Object> get props => [];
}
