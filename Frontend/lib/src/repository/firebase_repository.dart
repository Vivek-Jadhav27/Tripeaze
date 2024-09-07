import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripeaze/src/model/user_model.dart';

import '../model/itinerary_model.dart';
import '../model/trip_model.dart';

class FirebaseRepository {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    // Password validation
    if (!RegExp(r'^(?=.*[A-Z])(?=.*\d).{8,}$').hasMatch(password)) {
      throw FirebaseAuthException(
        code: 'weak-password',
        message:
            'Password must be at least 8 characters long, contain at least one upper case letter and one number.',
      );
    }

    try {
      // Create user with email and password
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the newly created user
      User? user = userCredential.user;

      // Save user details in Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'uid': user.uid,
        });

        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Password validation
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return true;
      }
      return false;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<bool> verifyEmail({required String email}) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: email)
        .get();
    if (query.docs.isNotEmpty) {
      return true; // Email is valid
    } else {
      return false; // Email is not valid
    }
  }

  Future<bool> updateProfile(
      {required String name,
      required String email,
      required String dob,
      required String profilePic}) {
    try {
      return _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .update({
            'name': name,
            'email': email,
            'dob': dob,
            'profilePic': profilePic
          })
          .then((value) => true)
          .catchError((error) => false);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<UserModel> getProfile() async {
    try {
      var query = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      return UserModel.fromJson(query.data() as Map<String, dynamic>);
    } catch (e) {
      throw e;
    }
  }

  Future<String> uploadProfileImage(XFile image) async {
    try {
      File file = File(image.path);
      if (!await file.exists()) {
        throw Exception('File does not exist');
      }

      // Upload image to Firebase Storage
      Reference reference = _storage
          .ref()
          .child('profile_images')
          .child(_firebaseAuth.currentUser!.uid);
      UploadTask uploadTask = reference.putFile(file);

      // Get the download URL
      String downloadUrl =
          await uploadTask.then((value) => value.ref.getDownloadURL());

      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .update({
        'profilePic': downloadUrl,
      });

      // Return the download URL
      return downloadUrl;
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveTrip(String tripName, List<Itinerary> itinerary) async {
    try {
      // 1. Add the trip to the "trips" collection
      final tripDoc = await FirebaseFirestore.instance.collection('trips').add({
        'tripName': tripName,
        'itinerary': itinerary.map((it) => it.toJson()).toList(),
      });

      // 2. Get the trip ID
      final tripId = tripDoc.id;

      final String userId = _firebaseAuth.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'trips': FieldValue.arrayUnion([tripId])
      });

      print('Trip saved successfully!');
    } catch (e) {
      print('Failed to save trip: $e');
    }
  }

  Future<List<Trip>> fetchUserTrips() async {
    try {
      // Get the user document
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();

      // Extract the list of trip IDs from the user document
      List<dynamic> tripIds = userDoc.get('trips') ?? [];

      // Fetch the trip details from the "trips" collection
      List<Trip> trips = [];
      for (String tripId in tripIds) {
        DocumentSnapshot tripDoc = await FirebaseFirestore.instance
            .collection('trips')
            .doc(tripId)
            .get();
        if (tripDoc.exists) {
          Map<String, dynamic> data = tripDoc.data() as Map<String, dynamic>;
          trips.add(Trip.fromJson(
              data)); // Assuming Trip.fromJson is a method to create a Trip object from JSON
        }
      }

      return trips;
    } catch (e) {
      print('Failed to fetch user trips: $e');
      return [];
    }
  }
}
