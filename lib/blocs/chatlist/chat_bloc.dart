import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:layover/blocs/auth/auth_bloc.dart';
import 'package:layover/blocs/profile/profile_bloc.dart';
import 'package:layover/model/user_model.dart';
import 'package:layover/respositories/database/database_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final AuthBloc _authBloc;
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _authSubscription;

  ChatBloc({
    required AuthBloc authBloc,
    required DatabaseRepository databaseRepository,
  })  : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        super(ChatLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<UpdateHome>(_onUpdateHome);
    on<ChatLeft>(_onChatLeft);
    on<ChatRight>(_onChatRight);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.status == AuthStatus.authenticated) {
        add(LoadUsers(userId: state.user!.uid));
      }
    });
  }

  void _onLoadUsers(
    LoadUsers event,
    Emitter<ChatState> emit,
  ) async {
    final ref = await FirebaseFirestore.instance
        .collection('users')
        .doc(event.userId)
        .collection('messages')
        .snapshots();
    _databaseRepository.getUsersChat(event.userId).listen((users) {
      print(event.userId);
      add(
        UpdateHome(users: users),
      );
    });
  }

  void _onUpdateHome(
    UpdateHome event,
    Emitter<ChatState> emit,
  ) {
    if (event.users != null) {
      emit(ChatLoaded(users: event.users!));
    } else {
      emit(ChatError());
    }
  }

  void _onChatLeft(
    ChatLeft event,
    Emitter<ChatState> emit,
  ) {
    if (state is ChatLoaded) {
      final state = this.state as ChatLoaded;

      List<User> users = List.from(state.users)..remove(event.user);

      if (users.isNotEmpty) {
        emit(ChatLoaded(users: users));
      } else {
        emit(ChatError());
      }
    }
  }

  void _onChatRight(
    ChatRight event,
    Emitter<ChatState> emit,
  ) {
    if (state is ChatLoaded) {
      final state = this.state as ChatLoaded;
      List<User> users = List.from(state.users)..remove(event.user);

      if (users.isNotEmpty) {
        emit(ChatLoaded(users: users));
      } else {
        emit(ChatError());
      }
    }
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}
