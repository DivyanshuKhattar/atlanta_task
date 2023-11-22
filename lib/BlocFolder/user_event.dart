part of 'user_bloc.dart';

abstract class UserEvent extends Equatable{
  const UserEvent();
}

class UserLoadEvent extends UserEvent{
  @override
  List<Object> get props => [];
}