import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  void initState() {
    super.initState();
  }

  Future register() async {
    try {
      setState(() => loading = true);

      UserCredential userCred =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCred.user!.uid)
          .set({
        "name": name.text.trim(),
        "email": email.text.trim(),
        "created_at": DateTime.now(),
      });

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("خطأ: $e")));
    }
    setState(() => loading = false);
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
            colors: [
              const Color.fromARGB(255, 255, 255, 255),
              AppColors.teal,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 300, // تصغير عرض البطاقة
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  // LOGO
                  SizedBox(height: 10),
                  Icon(Icons.person_add_alt_1,
                      size: 70, color: AppColors.teal), // تصغير الشعار قليلاً
                  SizedBox(height: 15),

                  // FULL NAME
                  FocusScope(
                    child: Focus(
                      onFocusChange: (_) => setState(() {}),
                      child: TextField(
                        controller: name,
                        focusNode: nameNode,
                        decoration:
                            animatedDecoration("الاسم الكامل", nameNode),
                      ),
                    ),
                  ),
                  SizedBox(height: 14),

                  // EMAIL
                  FocusScope(
                    child: Focus(
                      onFocusChange: (_) => setState(() {}),
                      child: TextField(
                        controller: email,
                        focusNode: emailNode,
                        decoration:
                            animatedDecoration("البريد الإلكتروني", emailNode),
                      ),
                    ),
                  ),
                  SizedBox(height: 14),

                  // PASSWORD
                  FocusScope(
                    child: Focus(
                      onFocusChange: (_) => setState(() {}),
                      child: TextField(
                        controller: password,
                        focusNode: passNode,
                        obscureText: !showPassword,
                        style: TextStyle(
                            color: passNode.hasFocus
                                ? Colors.white
                                : Colors.black87),
                        decoration: animatedDecoration(
                                "كلمة المرور", passNode)
                            .copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color:
                                  passNode.hasFocus ? Colors.white : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
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

                  // SOCIAL ICONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialIcon(Icons.facebook, Colors.blue),
                      _socialIcon(Icons.g_mobiledata, Colors.red),
                      _socialIcon(Icons.linked_camera, Colors.blueAccent),
                      _socialIcon(Icons.camera, Colors.purple),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.15),
      ),
      child: Icon(icon, color: color, size: 28),
    );
  }
}
