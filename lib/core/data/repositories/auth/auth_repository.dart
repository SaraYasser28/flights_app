import 'package:dartz/dartz.dart';
import '../../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<String, UserModel>> signIn({
    required String email,
    required String password,
  });

  Future<Either<String, UserModel>> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<Either<String, void>> signOut();

  Future<Either<String, UserModel?>> getCurrentUser();

  Future<bool> isSignedIn();
}
