part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
}
class LoadAllBooks extends BookEvent{
  @override
  List<Object> get props => [];

}
class LoadDeskBooks extends BookEvent{
  @override
  List<Object> get props => [];
}
class AddBook extends BookEvent {
  final Book book;
  final File pickedImage;

  AddBook(this.book,this.pickedImage);

  @override
  List<Object> get props => [book];
}
class UpdateBook extends BookEvent{
 final Book book;
 final pickedImage;
 final bool isCoverChanged;

  UpdateBook(this.book,this.pickedImage,this.isCoverChanged);

  @override
  List<Object> get props => [book];
}
class AllBookUpdated extends BookEvent{
  final List<Book> allBooks;
  AllBookUpdated(this.allBooks);

  @override
  List<Object> get props => [allBooks];
}
class DeskBookUpdated extends BookEvent{
  final List<Book> deskBooks;
  DeskBookUpdated(this.deskBooks);

  @override
  List<Object> get props => [deskBooks];
}


