import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../widgets/input_text_field.dart';
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

              InputTextField(
                label: "Email",
                hint: "name@example.com",
                prefixIcon: AppIcons.email,
              ),

              SizedBox(height: 20.h),

              InputTextField(
                label: "Password",
                hint: "Enter your password",
                prefixIcon: AppIcons.lock,
                isPassword: true,
                suffix: SvgPicture.asset(AppIcons.obscure, width: 18.w),
              ),

              SizedBox(height: 34.h),

              PrimaryButton(
                text: "Sign In",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.home);
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
    );
  }
}
