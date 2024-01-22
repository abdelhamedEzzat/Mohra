part of 'create_company_cubit.dart';

sealed class FirebaseCreateCompanyState extends Equatable {
  const FirebaseCreateCompanyState();

  @override
  List<Object> get props => [];
}

final class FirestoreStorageInitial extends FirebaseCreateCompanyState {
  @override
  List<Object> get props => [];
}

final class FirestoreStorageLoading extends FirebaseCreateCompanyState {
  @override
  List<Object> get props => [];
}

final class FirestoreStorageSuccess extends FirebaseCreateCompanyState {
  @override
  List<Object> get props => [];
}

final class FirestoreStoragefaild extends FirebaseCreateCompanyState {
  final String error;

  const FirestoreStoragefaild({required this.error});
  @override
  List<Object> get props => [];
}

final class clearDataStorage extends FirebaseCreateCompanyState {
  @override
  List<Object> get props => [];
}
