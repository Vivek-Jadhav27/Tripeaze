import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_event.dart';
import '../../bloc/profile/profile_state.dart';
import '../../utils/appcolors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _dobFocusNode = FocusNode();

  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfileEvent());
  }

  Future<void> _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is ProfileLoaded) {
          _nameController.text = state.user.name;
          _emailController.text = state.user.email;
          _dobController.text = state.user.dob;
        } else if (state is ProfileUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading || state is ProfileUpdating) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProfileLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: width * 0.20,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(width * 0.2)),
                            child: _selectedImage != null
                                ? Image.file(
                                    File(_selectedImage!.path),
                                    fit: BoxFit.cover,
                                    width: width * 0.5,
                                    height: width * 0.5,
                                  )
                                : Image.network(
                                    state.user.profilePic,
                                    fit: BoxFit.cover,
                                    width: width * 0.5,
                                    height: width * 0.5,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: width * 0.12,
                            width: width * 0.12,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: width * 0.07,
                              ),
                              onPressed: _pickProfileImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.05,
                        right: width * 0.06,
                        left: width * 0.06),
                    child: Column(
                      children: [
                        _buildTextField(
                          label: 'Name',
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          width: width,
                          height: height,
                        ),
                        _buildTextField(
                          label: 'Email',
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          width: width,
                          height: height,
                        ),
                        _buildTextField(
                          label: 'Date of Birth',
                          controller: _dobController,
                          focusNode: _dobFocusNode,
                          width: width,
                          height: height,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        context.read<ProfileBloc>().add(
                              UpdateProfileEvent(
                                name: _nameController.text,
                                email: _emailController.text,
                                dob: _dobController.text,
                                profilePic: _selectedImage,
                                profilePicUrl: state.user.profilePic,
                              ),
                            );
                      },
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.5,
                        margin: EdgeInsets.only(
                          top: height * 0.03,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(width * 0.1)),
                          color: AppColors.primaryblue,
                        ),
                        child: Center(
                          child: Text(
                            'Save',
                            style: GoogleFonts.poppins(
                                fontSize: width * 0.06, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(child: Text('No Profile Data Available'));
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required double width,
    required double height,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: height * 0.015),
          child: Text(
            label,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, fontSize: width * 0.04),
          ),
        ),
        TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }
}
