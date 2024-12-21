part of 'delivery_history_bloc.dart';

@immutable
abstract class DeliveryHistoryState {}

class DeliveryHistoryInitial extends DeliveryHistoryState {}
class DeliveryHistoryLoading extends DeliveryHistoryState {}
class DeliveryHistoryDataLoaded extends DeliveryHistoryState {

  final DeliveryHistoryModel deliveryHistoryModel;
  DeliveryHistoryDataLoaded(this.deliveryHistoryModel);

}
class ErrorDeliveryHistoryLoading extends DeliveryHistoryState {}
