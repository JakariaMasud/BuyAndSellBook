import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buy_book_app/Bloc/auth_bloc.dart';
import 'package:buy_book_app/Models/Book.dart';
import 'package:buy_book_app/Models/User.dart';
import 'package:buy_book_app/Services/FirestoreService.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'desk_book_event.dart';
part 'desk_book_state.dart';

class DeskBookBloc extends Bloc<DeskBookEvent, DeskBookState> {
  BookDatabaseService bookDatabaseService;
  StreamSubscription<AuthState> _authStateStreamSubscription;
  StreamSubscription _deskBooksSubscription;
  AuthBloc authBloc;
  User user;
  DeskBookBloc({this.bookDatabaseService,this.authBloc}) : super(DeskBookInitial()){
    _authStateStreamSubscription = authBloc.listen((authState) {
      if(authState is Authenticated){
        user= authState.user;
      }
    });
  }

  @override
  Stream<DeskBookState> mapEventToState(
    DeskBookEvent event,
  ) async* {
    if(event is LoadDeskBooks){
      _deskBooksSubscription?.cancel();
      _deskBooksSubscription=bookDatabaseService.deskBooksStream(user.id).listen((querySnapshot) {
       add(DeskBookUpdated(querySnapshot.docs.map((doc) => Book.fromDocument(doc)).toList()));
      });
    }else if(event is DeskBookUpdated){
      yield DeskBookLoaded(event.bookList);
    }
  }
}
