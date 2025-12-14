import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masari_masari/screens/auth/auth_widgets/auth_text_field.dart';
import 'package:masari_masari/screens/auth/auth_widgets/social_login_icon.dart';
import 'package:masari_masari/screens/home/home_screen.dart';
import 'rigester_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool loading = false;
  bool obscure = true;

  late AnimationController animCtrl;
  late Animation<double> fadeAnim;
  late Animation<Offset> slideAnim;

  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    animCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: animCtrl, curve: Curves.easeOut));

    slideAnim = Tween<Offset>(
      begin: Offset(0, .2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animCtrl, curve: Curves.easeOut));

    animCtrl.forward();
  }

  Future<void> login() async {
    setState(() => loading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "حدث خطأ")));
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> guestLogin() async {
    setState(() => loading = true);
    try {
      await FirebaseAuth.instance.signInAnonymously();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "حدث خطأ")));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFF009A8A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: FadeTransition(
              opacity: fadeAnim,
              child: SlideTransition(
                position: slideAnim,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 300,
                      height: 260,
                    ),
                    Container(
                      width: 350,
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 25),

                          AuthTextField(
                            controller: emailCtrl,
                            focusNode: emailFocus,
                            label: "البريد الإلكتروني",
                            icon: Icons.email_outlined,
                            onTap: () => setState(() {}),
                          ),

                          SizedBox(height: 20),

                          AuthTextField(
                            controller: passCtrl,
                            focusNode: passFocus,
                            label: "كلمة المرور",
                            icon: Icons.lock_outline,
                            obscure: obscure,
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: passFocus.hasFocus
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                              onPressed: () =>
                                  setState(() => obscure = !obscure),
                            ),
                            onTap: () => setState(() {}),
                          ),
    SizedBox(height: 10),
                          /// LOGIN BUTTON
                          ElevatedButton(
                            onPressed: loading ? null : login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF006A60),
                              padding: EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 50,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: loading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    "دخول",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),

                          SizedBox(height: 10),

                          /// GUEST LOGIN BUTTON
                          TextButton(
                            onPressed: loading ? null : guestLogin,
                            child: Text(
                              "الدخول كزائر",
                              style: TextStyle(
                                color: Color(0xFF006A60),
                                fontSize: 16,
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          /// SOCIAL IMAGES
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

                          SizedBox(height: 15),

                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "إنشاء حساب جديد",
                              style: TextStyle(
                                color: Color(0xFF006A60),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// دالة عرض صورة داخل دائرة
  Widget socialImage(String path) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Image.asset(path, width: 28, height: 28),
    );
  }
}
