import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../logic/cubit/auth_cubit.dart';
import '../widgets/input_text_field.dart';
import '../widgets/or_divider.dart';
import '../widgets/social_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // Clear form on successful login
          _emailController.clear();
          _passwordController.clear();
          // Navigate to home
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: SvgPicture.asset(AppIcons.france, width: 28.w),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "Skiee",
                      style: AppTextStyles.title.copyWith(
                        fontSize: 20.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 52.h),
                Text("Welcome Back", style: AppTextStyles.title),
                SizedBox(height: 8.h),
                Text(
                  "Sign in to continue booking your next adventure",
                  style: AppTextStyles.subtitle,
                ),
                SizedBox(height: 32.h),

                // Email Field
                InputTextField(
                  controller: _emailController,
                  label: "Email",
                  hint: "name@example.com",
                  prefixIcon: AppIcons.email,
                ),
                SizedBox(height: 20.h),

                // Password Field
                // Password Field
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Password", style: AppTextStyles.inputLabel),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Contact support to reset password'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: AppTextStyles.primaryLink.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                InputTextField(
                  controller: _passwordController,
                  showLabel: false,
                  label: "",
                  hint: "Enter your password",
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

                SizedBox(height: 34.h),

                // Sign In Button
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return PrimaryButton(
                      text: state is AuthLoading ? "Signing In..." : "Sign In",
                      onTap: state is AuthLoading
                          ? null
                          : () {
                              _validateAndSignIn(context);
                            },
                    );
                  },
                ),
                SizedBox(height: 28.h),
                const OrDivider(),
                SizedBox(height: 32.h),
                Row(
                  children: const [
                    SocialButton(icon: AppIcons.google, text: "Google"),
                    SizedBox(width: 16),
                    SocialButton(icon: AppIcons.facebook, text: "Facebook"),
                  ],
                ),
                SizedBox(height: 40.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: AppTextStyles.primaryLink,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, AppRoutes.signUp);
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

  void _validateAndSignIn(BuildContext context) {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your password'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    context.read<AuthCubit>().signIn(email: email, password: password);
  }
}
