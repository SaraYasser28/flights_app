import 'package:dartz/dartz.dart';
import '../../models/user_model.dart';
import '../../services/auth/auth_service.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({required AuthService authService})
    : _authService = authService;

  @override
  Future<Either<String, UserModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty) {
        return const Left('Email cannot be empty');
      }
      if (password.isEmpty) {
        return const Left('Password cannot be empty');
      }
      if (password.length < 6) {
        return const Left('Password must be at least 6 characters');
      }

      final user = await _authService.signIn(email: email, password: password);

      if (user != null) {
        return Right(user);
      } else {
        return const Left('Invalid email or password');
      }
    } catch (e) {
      return Left('Sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, UserModel>> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      if (fullName.isEmpty) {
        return const Left('Full name cannot be empty');
      }
      if (email.isEmpty) {
        return const Left('Email cannot be empty');
      }
      if (!_isValidEmail(email)) {
        return const Left('Please enter a valid email address');
      }
      if (password.isEmpty) {
        return const Left('Password cannot be empty');
      }
      if (password.length < 6) {
        return const Left('Password must be at least 6 characters');
      }

      final user = await _authService.signUp(
        fullName: fullName,
        email: email,
        password: password,
      );

      if (user != null) {
        return Right(user);
      } else {
        return const Left('Email already exists');
      }
    } catch (e) {
      return Left('Sign up failed: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> signOut() async {
    try {
      await _authService.signOut();
      return const Right(null);
    } catch (e) {
      return Left('Sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, UserModel?>> getCurrentUser() async {
    try {
      final user = await _authService.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left('Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      return await _authService.isSignedIn();
    } catch (e) {
      return false;
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
