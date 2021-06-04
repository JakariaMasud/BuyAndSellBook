import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buy_book_app/Models/User.dart';
import 'package:buy_book_app/Services/AuthenticationService.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthenticationService authenticationService;
  AuthBloc({@required this.authenticationService }) : super(Uninitialized());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if(event is AppStarted){
      String userToken=await authenticationService.getUserToken();
      User user=await authenticationService.getUserById(userToken);
      if(userToken !=null && user!=null){
        yield Authenticated(user);
      }else{
        yield Unauthenticated();
      }

    }else if(event is Login){
      User user=await authenticationService.logIn(event.userId, event.password);
      if(user!=null){
        yield Authenticated(user);
      }else{
        yield Unauthenticated();
      }
    }else if(event is Logout){
      bool isDone=await authenticationService.signOut();
      if(isDone){
        yield Unauthenticated();
      }
    }

  }
}
