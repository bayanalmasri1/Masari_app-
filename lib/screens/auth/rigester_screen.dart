import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masari_masari/screens/auth/auth_widgets/auth_text_field.dart';
import 'package:masari_masari/screens/auth/auth_widgets/social_login_icon.dart';
import 'package:masari_masari/screens/home/home_screen.dart';
import '../../app_colors.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();

  bool loading = false;
  bool showPassword = false;

  FocusNode nameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passNode = FocusNode();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    super.dispose();
  }

  Future register() async {
    if (name.text.isEmpty || email.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("الرجاء ملء جميع الحقول")));
      return;
    }

    try {
      setState(() => loading = true);

      // إنشاء الحساب في Firebase Auth
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.text.trim(),
            password: password.text.trim(),
          );

      // حفظ البيانات في Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCred.user!.uid)
          .set({
            "name": name.text.trim(),
            "email": email.text.trim(),
            "created_at": DateTime.now(),
          });

      // الانتقال إلى الهوم ومنع العودة
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "حدث خطأ";
      if (e.code == 'email-already-in-use') {
        message = "هذا البريد مستخدم بالفعل";
      } else if (e.code == 'weak-password') {
        message = "كلمة المرور ضعيفة جداً";
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("خطأ: $e")));
    } finally {
      setState(() => loading = false);
    }
  }

  InputDecoration animatedDecoration(String label, FocusNode node) {
    bool focused = node.hasFocus;

    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: focused ? AppColors.teal : Colors.grey.shade200,
      labelStyle: TextStyle(
        color: focused ? Colors.white : Colors.black54,
        fontSize: 14,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.teal, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, AppColors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Icon(Icons.person_add_alt_1, size: 70, color: AppColors.teal),
                  SizedBox(height: 15),
                  AuthTextField(
                    controller: name,
                    focusNode: nameNode,
                    label: "الاسم الكامل",
                    icon: Icons.person_outline,
                    onTap: () => setState(() {}),
                  ),

                  SizedBox(height: 14),

                  AuthTextField(
                    controller: email,
                    focusNode: emailNode,
                    label: "البريد الإلكتروني",
                    icon: Icons.email_outlined,
                    onTap: () => setState(() {}),
                  ),

                  SizedBox(height: 14),

                  AuthTextField(
                    controller: password,
                    focusNode: passNode,
                    label: "كلمة المرور",
                    icon: Icons.lock_outline,
                    obscure: !showPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: passNode.hasFocus ? Colors.white : Colors.grey,
                      ),
                      onPressed: () =>
                          setState(() => showPassword = !showPassword),
                    ),
                    onTap: () => setState(() {}),
                  ),

                  SizedBox(height: 20),

                  // REGISTER BUTTON
                  ElevatedButton(
                    onPressed: loading ? null : register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teal,
                      minimumSize: Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      loading ? "جاري إنشاء الحساب..." : "إنشاء حساب",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),

                  SizedBox(height: 14),

                  Text("أو سجل بواسطة", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 12),

                  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    SocialLoginIcon(
      asset: "assets/images/google.png",
      onTap: (){},
    ),
    SizedBox(width: 10),
    SocialLoginIcon(
      asset: "assets/images/facebook.png",
      onTap: (){},
    ),
    SizedBox(width: 10),
    SocialLoginIcon(
      asset: "assets/images/Github.png",
      onTap: (){},
    ),
    SizedBox(width: 10),
    SocialLoginIcon(
      asset: "assets/images/linkedin.png",
      onTap: (){},
    ),
  ],
),

                  SizedBox(height: 18),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: Text("لديك حساب؟ تسجيل الدخول"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
    }