import '../../models/user_model.dart';
import 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  static final Map<String, UserModel> _users = {};
  static UserModel? _currentUser;

  @override
  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final user = _users.values.firstWhere(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
      orElse: () => throw Exception('User not found'),
    );

    if (user.email == email && user.password == password) {
      _currentUser = user;
      return user;
    }
    return null;
  }

  @override
  Future<UserModel?> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final existingUser = _users.values.any(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );

    if (existingUser) {
      return null;
    }

    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: fullName,
      email: email.toLowerCase(),
      password: password,
      profilePicture: 'assets/images/profile_photo.png',
      membershipTier: 'GOLD MEMBER',
      favoriteFlightIds: [],
    );

    _users[email.toLowerCase()] = newUser;
    _currentUser = newUser;

    return newUser;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _currentUser;
  }

  @override
  Future<bool> isSignedIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _currentUser != null;
  }

  List<UserModel> getAllUsers() {
    return _users.values.toList();
  }

  UserModel? getUserByEmail(String email) {
    return _users[email.toLowerCase()];
  }
}
