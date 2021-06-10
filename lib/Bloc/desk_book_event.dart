part of 'desk_book_bloc.dart';

@immutable
abstract class DeskBookEvent extends Equatable {}
class LoadDeskBooks extends DeskBookEvent{
  @override

  List<Object> get props => [];

}
class DeskBookUpdated extends DeskBookEvent{
  final List<Book>bookList;

  DeskBookUpdated(this.bookList);

  @override
  // TODO: implement props
  List<Object> get props => [bookList];
}
