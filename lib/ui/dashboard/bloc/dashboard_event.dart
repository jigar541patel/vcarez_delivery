part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class GetNewOrderEvent extends DashboardEvent {}
class GetCurrentLocationName extends DashboardEvent {}
class AcceptOrderEvent extends DashboardEvent {

  final int orderID;

  AcceptOrderEvent(this.orderID);
}
class ExtraTimeOrderEvent extends DashboardEvent {

  final int orderID;

  ExtraTimeOrderEvent(this.orderID);
}
class OrderPickedEvent extends DashboardEvent {

  final int orderID;

  OrderPickedEvent(this.orderID);
}
class OrderDeliveredEvent extends DashboardEvent {

  final int orderID;

  OrderDeliveredEvent(this.orderID);
}

class RejectOrderEvent extends DashboardEvent {

  final int orderID;

  RejectOrderEvent(this.orderID);
}
