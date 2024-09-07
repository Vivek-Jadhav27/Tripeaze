import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripeaze/src/bloc/signin/signin_event.dart';
import 'package:tripeaze/src/bloc/signin/signin_state.dart';
import 'package:tripeaze/src/repository/firebase_repository.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  SigninBloc() : super(SigninInitial()) {
    on<SigninButtonPressed>(_signin);
  }

  Future<void> _signin(
      SigninButtonPressed event, Emitter<SigninState> emit) async {
    emit(SigninLoading());

    try {
      // Validate email
      if (event.email.isEmpty) {
        emit(SigninError(error: 'Email cannot be empty'));
        return;
      }
      // Validate password
      if (event.password.isEmpty) {
        emit(SigninError(error: 'Password cannot be empty'));
        return;
      }
      // Attempt to sign in
      bool result = await _firebaseRepository.signIn(
          email: event.email, password: event.password);

      // Emit success or error based on the result
      if (result) {
        emit(SigninSuccess());
      } else {
        emit(SigninError(error: 'Invalid email or password'));
      }
    } catch (e) {
      emit(SigninError(error: e.toString()));
    }
  }
}
