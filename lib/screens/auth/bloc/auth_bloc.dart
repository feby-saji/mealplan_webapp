import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:web_app/functions/firebase/firestore.dart';
import 'package:web_app/models/admin.dart';
import 'package:web_app/screens/home/desktop.dart';
import 'package:web_app/screens/home/mobile/mobile.dart';
import 'package:web_app/widgets/build_layout.dart';
import 'package:web_app/widgets/err_snackbar.dart';

part 'auth_event.dart';
part 'auth_state.dart';

late FireStoreRepository _firestore;
late AdminModel userDet;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(FireStoreRepository fireStore) : super(AuthLogIn()) {
    _firestore = fireStore;
    on<ToggleSignUpAndLogIn>(_toggleSignUpAndLogIn);
    on<SignUpEvent>(_signUpEvent);
    on<LogInEvent>(_logInEvent);
    on<UserLogOutEvent>(_userLogOut);
  }

  _toggleSignUpAndLogIn(ToggleSignUpAndLogIn event, Emitter<AuthState> emit) {
    if (event.signUp) {
      return emit(AuthSignUp());
    } else {
      return emit(AuthLogIn());
    }
  }

  _signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuth());

    final result =
        await _firestore.signUpUser(event.name, event.email, event.password);
    if (result.startsWith('Registration successful')) {
      Router.neglect(event.context, () => event.context.go('/homeScreen'));
    } else {
      showErrorSnackbar(event.context, result);
      emit(ErrorState(err: result));
    }
  }

  _logInEvent(LogInEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuth());

    final result = await _firestore.logInUser(event.email, event.password);
    if (result.startsWith('Login successful')) {
      Router.neglect(event.context, () => event.context.go('/homeScreen'));
    } else {
      emit(ErrorState(err: result));
      showErrorSnackbar(event.context, result);
    }
  }

  _userLogOut(UserLogOutEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuth());
    bool firestoreResult = await _firestore.logOut();
    if (firestoreResult) {
     return emit(AuthLoggedOut());
    } else {
     return emit(ErrorState(err: 'Could not log out.'));
    }
  }
}
