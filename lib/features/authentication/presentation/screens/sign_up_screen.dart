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

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              const SizedBox(height: 32),
              Text("Create Account", style: AppTextStyles.authTitle),
              const SizedBox(height: 8),
              Text(
                "Join us and start exploring the world",
                style: AppTextStyles.authSubtitle,
              ),
              const SizedBox(height: 24),
              InputTextField(
                label: "Full Name",
                hint: "John Doe",
                prefixIcon: AppIcons.profile,
              ),
              const SizedBox(height: 16),
              InputTextField(
                label: "Email",
                hint: "john@example.com",
                prefixIcon: AppIcons.email,
              ),
              const SizedBox(height: 16),
              InputTextField(
                label: "Password",
                hint: "••••••••",
                prefixIcon: AppIcons.lock,
                isPassword: true,
                suffix: SvgPicture.asset(AppIcons.obscure, width: 20),
              ),
              const SizedBox(height: 16),
              InputTextField(
                label: "Confirm Password",
                hint: "••••••••",
                prefixIcon: AppIcons.confirmLock,
                isPassword: true,
                suffix: SvgPicture.asset(AppIcons.obscure, width: 20),
              ),
              const SizedBox(height: 31),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.red, width: 100),
                    ),
                  ),
                  const SizedBox(width: 8),
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
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          const TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: AppTextStyles.primaryLink,
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          const TextSpan(text: "."),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              PrimaryButton(text: "Sign Up", onTap: () {}),
              const SizedBox(height: 32),
              const OrDivider(),
              const SizedBox(height: 32),
              Row(
                children: const [
                  SocialButton(icon: AppIcons.google, text: "Google"),
                  SizedBox(width: 16),
                  SocialButton(icon: AppIcons.facebook, text: "Facebook"),
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
    );
  }
}
