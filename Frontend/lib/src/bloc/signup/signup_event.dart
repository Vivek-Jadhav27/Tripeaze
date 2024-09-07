import 'package:equatable/equatable.dart';

class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupButtonPressed extends SignupEvent {
  final String email;
  final String password;
  final String name;
  SignupButtonPressed({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [email, password, name];
}
