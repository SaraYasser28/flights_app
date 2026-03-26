import '../../models/user_model.dart';

abstract class AuthService {
  Future<UserModel?> signIn({required String email, required String password});

  Future<UserModel?> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<UserModel?> getCurrentUser();

  Future<bool> isSignedIn();
}
