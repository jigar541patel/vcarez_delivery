part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}
class RegisterDataSubmittedEvent extends RegisterEvent {
  final AddDeliveryMenRequestModel addDeliveryMenRequestModel;

  RegisterDataSubmittedEvent(this.addDeliveryMenRequestModel);
}
