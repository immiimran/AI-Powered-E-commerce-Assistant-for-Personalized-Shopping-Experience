import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Account created successfully!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Logged in successfully!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> logout() async => await auth.signOut();
}
