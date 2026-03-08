import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class AppIcons {
  AppIcons._();

  static const String _basePath = "assets/icons/";

  static const String booked = "${_basePath}booked.svg";
  static const String british = "${_basePath}british.svg";
  static const String calendar = "${_basePath}calender.svg";
  static const String confirmLock = "${_basePath}confirm_lock.svg";
  static const String email = "${_basePath}email.svg";
  static const String energySaver = "${_basePath}energy_saver.svg";
  static const String facebook = "${_basePath}facebook.svg";
  static const String favourite = "${_basePath}favourite.svg";
  static const String filter = "${_basePath}filter.svg";
  static const String france = "${_basePath}france.svg";
  static const String google = "${_basePath}google.svg";
  static const String home = "${_basePath}home.svg";
  static const String landing = "${_basePath}landing.svg";
  static const String legroom = "${_basePath}legroom.svg";
  static const String lock = "${_basePath}lock.svg";
  static const String logout = "${_basePath}logout.svg";
  static const String obscure = "${_basePath}obsecure.svg";
  static const String profile = "${_basePath}profile.svg";
  static const String search = "${_basePath}search.svg";
  static const String usb = "${_basePath}usb.svg";
  static const String video = "${_basePath}video.svg";
  static const String wifi = "${_basePath}wifi.svg";
  static const String backIcon = "${_basePath}back.svg";
  static const Icon chevronRight = Icon(
    Icons.chevron_right,
    color: AppColors.checkBoxBorder,
  );
  static const String aeroplane = "${_basePath}aeroplane.svg";
  static const String economy = "${_basePath}economy.svg";
  static Icon close = Icon(
    Icons.close,
    size: 24.sp,
    color: AppColors.textSecondary,
  );
}
