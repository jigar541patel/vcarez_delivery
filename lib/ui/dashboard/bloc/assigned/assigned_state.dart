part of 'assigned_bloc.dart';

@immutable
abstract class AssignedState {}

class AssignedInitial extends AssignedState {}
class AssignOrderLoading extends AssignedState {}
class AssignOrderDataLoaded extends AssignedState {
  final AssignOrderModel assignOrderModel;
  AssignOrderDataLoaded(this.assignOrderModel);

}

class ErrorAssignOrderLoading extends AssignedState {}