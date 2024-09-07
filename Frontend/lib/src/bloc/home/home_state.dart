import 'package:equatable/equatable.dart';
import 'package:tripeaze/src/model/user_model.dart';

class HomeState extends Equatable{
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState{}

class HomeLoading extends HomeState{}

class HomeLoaded extends HomeState{
  final UserModel user;
  HomeLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class HomeError extends HomeState{
  final String message;
  HomeError({required this.message});

  @override
  List<Object?> get props => [message];
} 