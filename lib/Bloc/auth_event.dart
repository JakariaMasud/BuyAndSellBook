part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}
class AppStarted extends AuthEvent{
  @override
  List<Object> get props => [];
}
class Login extends AuthEvent{
  String userId,password;
  Login({this.userId, this.password});

  @override
  List<Object> get props => [userId,password];
}
class Logout extends AuthState{
  @override
  List<Object> get props => [];
}

