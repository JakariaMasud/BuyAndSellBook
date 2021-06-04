import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:buy_book_app/Bloc/auth_bloc.dart';
import 'package:buy_book_app/Models/Book.dart';
import 'package:buy_book_app/Models/User.dart';
import 'package:buy_book_app/Services/FirestoreService.dart';
import 'package:equatable/equatable.dart';
part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookDatabaseService bookDatabaseService;
  StreamSubscription _allBooksSubscription;
  StreamSubscription _deskBooksSubscription;
  AuthBloc authBloc;
  StreamSubscription<AuthState> _authStateStreamSubscription;
  User user;
  BookBloc({this.bookDatabaseService,this.authBloc}) : super(BookInitial()) {
    _authStateStreamSubscription = authBloc.listen((authState) {
      if(authState is Authenticated){
       user= authState.user;
      }
    });
  }
  @override
  Stream<BookState> mapEventToState(
    BookEvent event,
  ) async* {
   if(event is LoadAllBooks){
     _allBooksSubscription?.cancel();
     _allBooksSubscription=bookDatabaseService.allBooksStream().listen((querySnapshot) {
       add(AllBookUpdated(querySnapshot.docs.map((doc) => Book.fromDocument(doc)).toList()));
     });
   }else if (event is LoadDeskBooks){
     _deskBooksSubscription?.cancel();
     _deskBooksSubscription=bookDatabaseService.deskBooksStream(user.id).listen((querySnapshot) {
       add(DeskBookUpdated(querySnapshot.docs.map((doc) => Book.fromDocument(doc)).toList()));
     });
   }else if(event is AllBookUpdated){
     yield AllBooksLoaded(event.allBooks);
   }else if(event is DeskBookUpdated){
     yield DeskBooksLoaded(event.deskBooks);
   }
   else if(event is UpdateBook){
    try{
      await bookDatabaseService.updateBook(event.book, event.pickedImage, event.isCoverChanged, user.id);
      yield UpdateBookSuccess();
    } catch(error){
      yield UpdateBookFailed();
    }

   }else if(event is AddBook){
     try{
       await bookDatabaseService.addBook(event.book, event.pickedImage, user.id);
       yield AddBookSuccess();
     }catch(error){
       yield AddBookFailed();
     }
   }
  }
  @override
  Future<void> close() {
    _authStateStreamSubscription.cancel();
    _allBooksSubscription.cancel();
    _deskBooksSubscription.cancel();
    return super.close();
  }
}


