part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();
}

class BookInitial extends BookState {
  @override
  List<Object> get props => [];
}

class BookLoading extends BookState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class AllBooksLoaded extends BookState{
  final List<Book> allBooks;
  AllBooksLoaded(this.allBooks);
  @override
  // TODO: implement props
  List<Object> get props => [allBooks];
}
class DeskBooksLoaded extends BookState{
  final List<Book> deskBooks;
  DeskBooksLoaded(this.deskBooks);
  @override
  // TODO: implement props
  List<Object> get props => [deskBooks];
}

class AddBookSuccess extends BookState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class AddBookFailed extends BookState{
  List<Object> get props => [];
}
class UpdateBookSuccess extends BookState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class UpdateBookFailed extends BookState{
  List<Object> get props => [];
}
