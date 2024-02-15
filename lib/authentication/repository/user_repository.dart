import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/user/user_main.dart';
//import 'package:waste_manage/functions/firebaseFunctions.dart';

class AuthServices {
  static signupUser(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print("Before updateDisplayName: ${userCredential.user!.displayName}");
      await userCredential.user!.updateDisplayName(name);
      print("After updateDisplayName: ${userCredential.user!.displayName}");

// Store user data directly in the contributors collection
      await FirestoreServices.saveContributor(
          name, email, userCredential.user!.uid);

// Initialize solidWaste and liquidWaste fields with zero
      await FirebaseFirestore.instance
          .collection('UserDB')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'Address': '',
        'Landmark': '',
        'Pincode': '',
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration Successful')));
    } on FirebaseAuthException catch (e) {
      // Handle exceptions
      print(e.toString());
    } catch (e) {
      // Handle other exceptions
    }
  }

  static signinUser(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Check if the user account still exists
      if (userCredential.user != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('You are Logged in')));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => ScreenHome()));
      }
    } on FirebaseAuthException catch (e) {
      // Handle exceptions (if needed)
      print(e.toString());
      
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Invalid credentials')));
    } catch (e) {
      // Handle other exceptions (if needed)
    }
  }
}

class AdminAuthServices {
  static Future<UserCredential?> signupAdmin(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print("Before updateDisplayName: ${userCredential.user!.displayName}");
      await userCredential.user!.updateDisplayName(name);
      print("After updateDisplayName: ${userCredential.user!.displayName}");

      // Store user data directly in the admins collection (replace 'admins' with your collection name)
      await FirebaseFirestore.instance
          .collection('admins')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        // Add other data if needed
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration Successful')));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle exceptions
      print("Error creating admin account: $e");
      return null;
    } catch (e) {
      // Handle other exceptions
      print("Other error creating admin account: $e");
      return null;
    }
  }
}

class FirestoreServices {
  static saveContributor(String name, String email, String uid) async {
    await FirebaseFirestore.instance
        .collection('UserDB')
        .doc(uid)
        .set({'email': email, 'name': name});
  }
}

//   static Future<UserCredential?> signinAdmin(
//       String email, String password, BuildContext context) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);

//       // Check if the user account still exists
//       if (userCredential.user != null) {
//         // You can perform additional checks here if needed
//         ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text('Admin logged in')));
//         return userCredential;
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Invalid admin credentials')));
//         return null;
//       }
//     } on FirebaseAuthException catch (e) {
//       // Handle exceptions
//       print("Error signing in as admin: $e");
//       return null;
//     }
//   }

//   static Future<void> signoutAdmin(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Admin logged out')));
//       // Redirect to login page or desired destination
//     } catch (e) {
//       // Handle exceptions
//       print("Error signing out admin: $e");
//     }
//   }
// }



// class UserRepository extends GetxController {
//   static UserRepository get instance => Get.find();

//   final _db = FirebaseFirestore.instance;

//   createUser(UserModel user) async {
//     await _db
//         .collection("Users")
//         .add(user.toJson())
//         .whenComplete(() => Get.snackbar(
//             "Success", "Your account has been created.",
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.green.withOpacity(0.1),
//             colorText: Colors.green))
//         .catchError((error, stackTrace) {
//       () {
//         Get.snackbar("Error", "Something went Wrong. Try again",
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.redAccent.withOpacity(0.1),
//             colorText: Colors.red);
//         print(error.toString());
//       };
//     });
//   }
// }
