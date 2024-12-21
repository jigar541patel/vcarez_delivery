part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}
class ErrorNewLoading extends DashboardState {}
class NewOrderLoading extends DashboardState {}
class OnLocationLoadedState extends DashboardState {
 final String? strLocation;

 OnLocationLoadedState(this.strLocation);
}

class OnLocationLoadingState extends DashboardState {}
class AcceptOrderLoadingState extends DashboardState {}
class NeedMoreTimeLoadingState extends DashboardState {}
class PickedOrderLoadingState extends DashboardState {}
class DeliveredOrderLoadingState extends DashboardState {}
class AcceptOrderSuccessState extends DashboardState {}
class NeedMoreTimeSuccessState extends DashboardState {}
class PickedOrderSuccessState extends DashboardState {}
class DeliveredOrderSuccessState extends DashboardState {}
class RejectOrderLoadingState extends DashboardState {}
class RejectOrderSuccessState extends DashboardState {}
class NewOrderDataLoaded extends DashboardState {
 final NewOrderModel newOrderModel;
  NewOrderDataLoaded(this.newOrderModel);


}
class ErrorAcceptOrderLoading extends DashboardState {}
class ErrorNeedMoreTimeLoading extends DashboardState {}
class ErrorPickedOrderTimeLoading extends DashboardState {}
class ErrorDeliveredOrderLoading extends DashboardState {}
class ErrorRejectOrderLoading extends DashboardState {}

