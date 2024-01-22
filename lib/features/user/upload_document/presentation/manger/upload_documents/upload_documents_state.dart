part of 'upload_documents_cubit.dart';

sealed class UploadDocumentsState extends Equatable {
  const UploadDocumentsState();

  @override
  List<Object> get props => [];
}

final class UploadDocumentsInitial extends UploadDocumentsState {}

final class UploadDocumentLoading extends UploadDocumentsState {
  @override
  List<Object> get props => [];
}

final class UploadDocumentSuccess extends UploadDocumentsState {
  @override
  List<Object> get props => [];
}

final class UploadDocumentfaild extends UploadDocumentsState {
  final String error;

  const UploadDocumentfaild({required this.error});
  @override
  List<Object> get props => [];
}

final class ClearFileWhenChangeFromCameraToGallery
    extends UploadDocumentsState {
  @override
  List<Object> get props => [];
}
