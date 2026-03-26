import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data/models/user_model.dart';
import '../../../../core/data/repositories/auth/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    checkAuthStatus();
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());

    if (email.isEmpty) {
      emit(const AuthError('Email cannot be empty'));
      return;
    }
    if (password.isEmpty) {
      emit(const AuthError('Password cannot be empty'));
      return;
    }
    if (password.length < 6) {
      emit(const AuthError('Password must be at least 6 characters'));
      return;
    }

    final result = await _authRepository.signIn(
      email: email,
      password: password,
    );

    result.fold(
      (error) => emit(AuthError(error)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(AuthLoading());

    if (fullName.isEmpty) {
      emit(const AuthError('Full name cannot be empty'));
      return;
    }
    if (email.isEmpty) {
      emit(const AuthError('Email cannot be empty'));
      return;
    }
    if (!_isValidEmail(email)) {
      emit(const AuthError('Please enter a valid email address'));
      return;
    }
    if (password.isEmpty) {
      emit(const AuthError('Password cannot be empty'));
      return;
    }
    if (password.length < 6) {
      emit(const AuthError('Password must be at least 6 characters'));
      return;
    }
    if (password != confirmPassword) {
      emit(const AuthError('Passwords do not match'));
      return;
    }

    final result = await _authRepository.signUp(
      fullName: fullName,
      email: email,
      password: password,
    );

    result.fold(
      (error) => emit(AuthError(error)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    final result = await _authRepository.signOut();
    result.fold(
      (error) => emit(AuthError(error)),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> checkAuthStatus() async {
    final isSignedIn = await _authRepository.isSignedIn();
    if (isSignedIn) {
      final result = await _authRepository.getCurrentUser();
      result.fold((error) => emit(AuthError(error)), (user) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      });
    } else {
      emit(AuthUnauthenticated());
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
