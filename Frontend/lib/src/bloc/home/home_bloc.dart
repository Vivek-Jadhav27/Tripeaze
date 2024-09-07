import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripeaze/src/bloc/home/home_event.dart';
import 'package:tripeaze/src/bloc/home/home_state.dart';
import 'package:tripeaze/src/model/user_model.dart';

import '../../repository/firebase_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  
  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_homeloaded);
  }

  Future<void> _homeloaded(
      HomeInitialEvent event, 
      Emitter<HomeState> emit) async {
      emit(HomeLoading());
      try {
        UserModel user = await _firebaseRepository.getProfile();
        emit(HomeLoaded(user: user));
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
  }
}
