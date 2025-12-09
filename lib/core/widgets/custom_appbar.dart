// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masari_masari/core/halpers/navigation.dart';
import '../../app_colors.dart';
import '../../routes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({Key? key, this.title = 'مساري'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 8,
      backgroundColor: AppColors.deepNavy,
      title: Row(
        children: [
          Icon(Icons.work_outline, size: 28, color: Colors.white),
          SizedBox(width: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Spacer(),

          // زر البحث
          IconButton(
            tooltip: 'بحث',
            onPressed: () => NavHelper.push(context, Routes.search),
            icon: Icon(Icons.search),
          ),

          /// ------------------------------------------------------------
          /// StreamBuilder لمراقبة حالة تسجيل الدخول بشكل مباشر
          /// ------------------------------------------------------------
          StreamBuilder<User?>(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (context, snapshot) {
    final user = snapshot.data;

    // -------------------------------
    // إذا لا يوجد مستخدم أو المستخدم زائر
    // -------------------------------
    if (user == null || user.isAnonymous) {
      return Row(
        children: [
          TextButton(
            onPressed: () => NavHelper.push(context, Routes.login),
            child: Text('تسجيل الدخول', style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 8),
          TextButton(
            onPressed: () => NavHelper.push(context, Routes.register),
            child: Text('إنشاء حساب', style: TextStyle(color: Colors.white)),
          ),

          // لو تحب نظهر أيقونة الزائر أيضًا:
          if (user != null && user.isAnonymous)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                backgroundColor: AppColors.teal,
                child: Text(
                  "ز",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      );
    }

    // -------------------------------
    // مستخدم مسجل دخول بشكل طبيعي
    // -------------------------------
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => NavHelper.push(context, Routes.profile),
        child: CircleAvatar(
          backgroundColor: AppColors.teal,
          child: Text(
            user.displayName?.isNotEmpty == true
                ? user.displayName![0].toUpperCase()
                : (user.email != null
                    ? user.email![0].toUpperCase()
                    : "?"),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  },
)

        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
