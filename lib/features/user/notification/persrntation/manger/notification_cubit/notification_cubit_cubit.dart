import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mohra_project/features/user/notification/data/notification_model.dart';

part 'notification_cubit_state.dart';

class NotificationCubitCubit extends Cubit<NotificationCubitState> {
  NotificationCubitCubit() : super(NotificationCubitInitial());
  List<Notification> dataList = [];
  void addNotifications(Notification notification) {
    emit(NotificationCubitLoading());

    dataList.add(notification); // Remove the unnecessary cast

    emit(NotificationCubitLoaded(notifications: dataList));
  }
}
