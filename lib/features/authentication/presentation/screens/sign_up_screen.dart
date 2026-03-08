import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/input_text_field.dart';
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
              InputTextField(
                label: "Full Name",
                hint: "John Doe",
                prefixIcon: AppIcons.profile,
              ),
              SizedBox(height: 16.h),
              InputTextField(
                label: "Email",
                hint: "john@example.com",
                prefixIcon: AppIcons.email,
              ),
              SizedBox(height: 16.h),
              InputTextField(
                label: "Password",
                hint: "••••••••",
                prefixIcon: AppIcons.lock,
                isPassword: true,
                suffix: SvgPicture.asset(AppIcons.obscure, width: 18.w),
              ),
              SizedBox(height: 16.h),
              InputTextField(
                label: "Confirm Password",
                hint: "••••••••",
                prefixIcon: AppIcons.confirmLock,
                isPassword: true,
                suffix: SvgPicture.asset(AppIcons.obscure, width: 18.w),
              ),
              SizedBox(height: 31.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.red, width: 100.w),
                    ),
                  ),
                  SizedBox(width: 8.w),
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

              PrimaryButton(
                text: "Sign Up",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.home);
                },
              ),
              SizedBox(height: 32.h),
              const OrDivider(),
              SizedBox(height: 32.h),
              Row(
                children: [
                  const SocialButton(icon: AppIcons.google, text: "Google"),
                  SizedBox(width: 16.w),
                  const SocialButton(icon: AppIcons.facebook, text: "Facebook"),
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
