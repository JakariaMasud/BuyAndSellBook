part of 'desk_book_bloc.dart';

@immutable
abstract class DeskBookState extends  Equatable{}

class DeskBookInitial extends DeskBookState {
  @override

  List<Object> get props => [];
}
class DeskBookLoading extends DeskBookState
{
  @override

  List<Object> get props => [];
}
class DeskBookLoaded extends DeskBookState{
  final List<Book>deskBooks;

  DeskBookLoaded(this.deskBooks);

  @override
  List<Object> get props => [];
}