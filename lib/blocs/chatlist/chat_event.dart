part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsers extends ChatEvent {
  final String userId;

  LoadUsers({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

class UpdateHome extends ChatEvent {
  final List<User>? users;

  UpdateHome({
    required this.users,
  });

  @override
  List<Object?> get props => [users];
}

class ChatLeft extends ChatEvent {
  final User user;

  ChatLeft({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class ChatRight extends ChatEvent {
  final User user;

  ChatRight({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}
