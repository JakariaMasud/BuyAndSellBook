part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class Uninitialized  extends AuthState {
  @override

  List<Object> get props => [];
}
class Authenticated  extends AuthState{
  User user;
  Authenticated(this.user);
  @override
  List<Object> get props => [user];
}
class Authenticating extends AuthState {
  @override

  List<Object> get props => [];
}
class Unauthenticated extends AuthState{
  @override

  List<Object> get props =>[];
}
