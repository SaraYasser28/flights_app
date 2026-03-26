import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../logic/cubit/auth_cubit.dart';
import '../widgets/input_text_field.dart';
import '../widgets/or_divider.dart';
import '../widgets/social_button.dart';
import '../widgets/terms_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _termsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // Clear form on successful registration
          _nameController.clear();
          _emailController.clear();
          _passwordController.clear();
          _confirmPasswordController.clear();
          setState(() {
            _termsAccepted = false;
          });
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created successfully!'),
              backgroundColor: AppColors.green,
              duration: Duration(seconds: 2),
            ),
          );
          // Navigate to home
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          backgroundColor: AppColors.white,
          showBackButton: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                Text("Create Account", style: AppTextStyles.title),
                SizedBox(height: 8.h),
                Text(
                  "Join us and start exploring the world",
                  style: AppTextStyles.subtitle,
                ),
                SizedBox(height: 24.h),

                // Full Name
                InputTextField(
                  controller: _nameController,
                  label: "Full Name",
                  hint: "John Doe",
                  prefixIcon: AppIcons.profile,
                ),
                SizedBox(height: 16.h),

                // Email
                InputTextField(
                  controller: _emailController,
                  label: "Email",
                  hint: "john@example.com",
                  prefixIcon: AppIcons.email,
                ),
                SizedBox(height: 16.h),

                // Password
                InputTextField(
                  controller: _passwordController,
                  label: "Password",
                  hint: "••••••••",
                  prefixIcon: AppIcons.lock,
                  isPassword: !_isPasswordVisible,
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 18.w,
                      color: AppColors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Confirm Password
                InputTextField(
                  controller: _confirmPasswordController,
                  label: "Confirm Password",
                  hint: "••••••••",
                  prefixIcon: AppIcons.confirmLock,
                  isPassword: !_isConfirmPasswordVisible,
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 18.w,
                      color: AppColors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 31.h),

                // Terms and Conditions
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          _termsAccepted = value ?? false;
                        });
                      },
                      activeColor: AppColors.primary,
                      side: BorderSide(
                        color: AppColors.checkBoxBorder,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "By signing up, you agree to our ",
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: "Terms of Service",
                              style: AppTextStyles.primaryLink,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const TermsDialog(
                                      title: "Terms of Service",
                                      content:
                                          "1. Acceptance of Terms: By creating an account, you agree to follow these rules and all applicable laws."
                                          "\n\n2. Account Responsibility: You are responsible for your account, password, and all activity under it."
                                          "\n\n3. Prohibited Conduct: You may not use the app for illegal purposes, harassment, spamming, or uploading harmful content."
                                          "\n\n4. Content Ownership: Any content you post remains yours, but you grant us permission to display it in the app."
                                          "\n\n5. Termination: We may suspend or terminate your account if you violate these terms."
                                          "\n\n6. Changes to Terms: We may update these terms occasionally. Continued use means you accept the changes.",
                                    ),
                                  );
                                },
                            ),
                            const TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: AppTextStyles.primaryLink,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const TermsDialog(
                                      title: "Privacy Policy",
                                      content:
                                          "1. Information Collection: We collect your name, email, and other information you provide during sign-up."
                                          "\n\n2. Use of Information: Your data is used to provide services, personalize content, and improve your experience."
                                          "\n\n3. Data Sharing: We do not sell your personal information. We may share data with trusted partners to provide services."
                                          "\n\n4. Data Security: We take reasonable steps to protect your information, but no system is 100% secure."
                                          "\n\n5. User Rights: You can request access, correction, or deletion of your data at any time."
                                          "\n\n6. Cookies and Tracking: We use cookies to improve functionality and performance..",
                                    ),
                                  );
                                },
                            ),
                            const TextSpan(text: "."),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Sign Up Button
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return PrimaryButton(
                      text: state is AuthLoading
                          ? "Creating Account..."
                          : "Sign Up",
                      onTap: state is AuthLoading
                          ? null
                          : () {
                              _validateAndSignUp(context);
                            },
                    );
                  },
                ),
                SizedBox(height: 32.h),
                const OrDivider(),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    const SocialButton(icon: AppIcons.google, text: "Google"),
                    SizedBox(width: 16.w),
                    const SocialButton(
                      icon: AppIcons.facebook,
                      text: "Facebook",
                    ),
                  ],
                ),
                const SizedBox(height: 49),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: AppTextStyles.primaryLink,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, AppRoutes.signIn);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateAndSignUp(BuildContext context) {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your full name'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }
    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a password'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 6 characters'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }
    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    context.read<AuthCubit>().signUp(
      fullName: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
