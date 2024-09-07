import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripeaze/src/bloc/profile/profile_event.dart';
import 'package:tripeaze/src/bloc/profile/profile_state.dart';

import '../../repository/firebase_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfileEvent>(_onFetchProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onFetchProfile(
    FetchProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final user = await _firebaseRepository.getProfile();
      emit(ProfileLoaded(user: user));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUpdating());
    try {
      String profilePicUrl =
          await _firebaseRepository.uploadProfileImage(event.profilePic!);
      print("ths");
      await _firebaseRepository.updateProfile(
        name: event.name,
        email: event.email,
        dob: event.dob,
        profilePic: profilePicUrl,
      );

      final updatedUser = await _firebaseRepository.getProfile();
      print("erroe");
      emit(ProfileLoaded(user: updatedUser));
      print("uploadProfileImage");
      emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
