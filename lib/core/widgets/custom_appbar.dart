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
    final user = FirebaseAuth.instance.currentUser;

    return AppBar(
      titleSpacing: 8,
      title: Row(
        children: [
          // أيقونة تمثل فكرة الموقع مع العنوان
          Icon(Icons.work_outline, size: 28, color: Colors.white),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Spacer(),

          // زر البحث
          IconButton(
            tooltip: 'بحث',
            onPressed: () => NavHelper.push(context, Routes.search),
            icon: Icon(Icons.search),
          ),

          // إذا المستخدم غير مسجل الدخول نعرض زر تسجيل الدخول وإنشاء حساب
          if (user == null) ...[
            TextButton(
              onPressed: () => NavHelper.push(context, Routes.login),
              child: Text('تسجيل الدخول', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 8),
            TextButton(
              onPressed: () => NavHelper.push(context, Routes.register),
              child: Text('إنشاء حساب', style: TextStyle(color: Colors.white)),
            ),
          ] else
            // إذا المستخدم مسجل الدخول، زر الملف الشخصي فقط
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () => NavHelper.push(context, Routes.profile),
                child: CircleAvatar(
                  backgroundColor: AppColors.teal,
                  child: Text(
                    (user.displayName != null && user.displayName!.isNotEmpty)
                        ? user.displayName![0]
                        : user.email![0].toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
      backgroundColor: AppColors.deepNavy,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
