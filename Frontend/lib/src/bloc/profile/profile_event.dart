import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchProfileEvent extends ProfileEvent {
}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final String email;
  final String dob;
  final XFile? profilePic;
  final String? profilePicUrl;

  const UpdateProfileEvent({
    required this.name,
    required this.email,
    required this.dob,
    this.profilePic,
    this.profilePicUrl,
  });

  @override
  List<Object?> get props => [ name, email, dob, profilePic, profilePicUrl];
}
