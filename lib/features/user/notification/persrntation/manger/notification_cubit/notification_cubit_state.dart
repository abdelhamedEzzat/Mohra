part of 'notification_cubit_cubit.dart';

sealed class NotificationCubitState extends Equatable {
  const NotificationCubitState();

  @override
  List<Object?> get props => [];
}

class NotificationCubitInitial extends NotificationCubitState {}

class NotificationCubitLoading extends NotificationCubitState {}

class NotificationCubitLoaded extends NotificationCubitState {
  final List<Notification> notifications;

  const NotificationCubitLoaded({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}

class NotificationCubitFinished extends NotificationCubitState {}
