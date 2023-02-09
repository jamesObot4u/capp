part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  List<Object> get props => [];
}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<User> users;

  const ChatLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class ChatError extends ChatState {}
