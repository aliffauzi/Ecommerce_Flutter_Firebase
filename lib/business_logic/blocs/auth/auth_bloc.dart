import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/business_logic/blocs/auth/auth_event.dart';
import 'package:e_commerce_app/business_logic/repositories/user_repo.dart';

import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      bool isLoggedIn = await _userRepository.isLoggedIn();

      //For display splash screen
      await Future.delayed(Duration(seconds: 2));

      if (isLoggedIn) {
        // Get current user
        final currUser = _userRepository.currentUser;
        yield Authenticated(currUser);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(_userRepository.currentUser);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.logOut();
  }
}
