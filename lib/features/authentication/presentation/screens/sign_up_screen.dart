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
import '../widgets/terms_dialog.dart';

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    activeColor: AppColors.primary,
                    side: BorderSide(color: AppColors.checkBoxBorder, width: 1),
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
                                  builder: (context) => TermsDialog(
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
                                  builder: (context) => TermsDialog(
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
