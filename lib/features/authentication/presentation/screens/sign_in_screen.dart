import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/input_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/or_divider.dart';
import '../widgets/social_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SvgPicture.asset(AppIcons.france, width: 28),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Skiee",
                    style: AppTextStyles.authTitle.copyWith(
                      fontSize: 20,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 52),
              Text("Welcome Back", style: AppTextStyles.authTitle),
              const SizedBox(height: 8),
              Text(
                "Sign in to continue booking your next adventure",
                style: AppTextStyles.authSubtitle,
              ),
              const SizedBox(height: 32),
              InputTextField(
                label: "Email",
                hint: "name@example.com",
                prefixIcon: AppIcons.email,
              ),
              const SizedBox(height: 20),
              InputTextField(
                label: "Password",
                hint: "Enter your password",
                prefixIcon: AppIcons.lock,
                isPassword: true,
                suffix: SvgPicture.asset(AppIcons.obscure, width: 20),
              ),
              const SizedBox(height: 34),
              PrimaryButton(text: "Sign In", onTap: () {}),
              const SizedBox(height: 28),
              const OrDivider(),
              const SizedBox(height: 32),
              Row(
                children: const [
                  SocialButton(icon: AppIcons.google, text: "Google"),
                  SizedBox(width: 16),
                  SocialButton(icon: AppIcons.facebook, text: "Facebook"),
                ],
              ),
              const SizedBox(height: 39.5),
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
    );
  }
}
