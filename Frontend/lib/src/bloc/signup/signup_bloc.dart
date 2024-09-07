import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripeaze/src/bloc/signup/signup_event.dart';
import 'package:tripeaze/src/bloc/signup/signup_state.dart';

import '../../repository/firebase_repository.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  SignupBloc() : super(SignupInitial()) {
    on<SignupButtonPressed>(_signup);
  }

  Future<void> _signup(
    SignupButtonPressed event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoading());

    try {
      // Validate email
      if (event.email.isEmpty) {
        emit(SignupError(error: 'Email cannot be empty'));
        return;
      }

      // Validate password
      if (event.password.isEmpty) {
        emit(SignupError(error: 'Password cannot be empty'));
        return;
      }

      // Validate name
      if (event.name.isEmpty) {
        emit(SignupError(error: 'Name cannot be empty'));
        return;
      }

      bool result = await _firebaseRepository.signUp(
        email: event.email,
        password: event.password,
        name: event.name,
      );

      if (result) {
        emit(SignupSuccess());
      } else {
        emit(SignupError(error: "Invalid UserCredential"));
      }
    } catch (e) {
      emit(SignupError(error: e.toString()));
    }
  }
}
