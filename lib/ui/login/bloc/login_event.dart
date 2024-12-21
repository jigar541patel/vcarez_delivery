part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
class LoginSubmittedEvent extends LoginEvent {
  final String strEmail;
  final String strPassword;

  LoginSubmittedEvent(this.strEmail, this.strPassword);
}
