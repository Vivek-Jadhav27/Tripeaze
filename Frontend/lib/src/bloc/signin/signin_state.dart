import 'package:equatable/equatable.dart';

class SigninState extends Equatable {
  @override
  List<Object> get props => [];
}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninSuccess extends SigninState {}

class SigninError extends SigninState {
  final String error;
  SigninError({required this.error});
}