import 'package:flutter/material.dart';
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

    fadeAnim =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animCtrl, curve: Curves.easeOut));

    slideAnim = Tween<Offset>(
      begin: Offset(0, .2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animCtrl, curve: Curves.easeOut));

    animCtrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /// ------------------- BACKGROUND GRADIENT -------------------
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color(0xFF009A8A),
            ],
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
                    /// ------------------- BIG LOGO -------------------
                    Image.asset(
                      "assets/images/logo.png",
                      width: 300,
                      height: 260,
                    ),

                

                    /// ------------------- WHITE CARD -------------------
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
                          )
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

                          /// ------------------- EMAIL FIELD -------------------
                          AnimatedContainer(
                            duration: Duration(milliseconds: 250),
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              color: emailFocus.hasFocus
                                  ? Color(0xFF00897B)
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: TextField(
                              controller: emailCtrl,
                              focusNode: emailFocus,
                              style: TextStyle(
                                color: emailFocus.hasFocus
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                              decoration: InputDecoration(
                                labelText: "البريد الإلكتروني",
                                labelStyle: TextStyle(
                                  color: emailFocus.hasFocus
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: emailFocus.hasFocus
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                              onTap: () => setState(() {}),
                            ),
                          ),

                          SizedBox(height: 20),

                          /// ------------------- PASSWORD FIELD -------------------
                          AnimatedContainer(
                            duration: Duration(milliseconds: 250),
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              color: passFocus.hasFocus
                                  ? Color(0xFF00897B)
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: TextField(
                              controller: passCtrl,
                              focusNode: passFocus,
                              obscureText: obscure,
                              style: TextStyle(
                                color: passFocus.hasFocus
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                              decoration: InputDecoration(
                                labelText: "كلمة المرور",
                                labelStyle: TextStyle(
                                  color: passFocus.hasFocus
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: passFocus.hasFocus
                                      ? Colors.white
                                      : Colors.grey,
                                ),
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
                              ),
                              onTap: () => setState(() {}),
                            ),
                          ),

                          SizedBox(height: 25),

                          /// ------------------- LOGIN BUTTON -------------------
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF006A60),
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              "دخول",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),

                          SizedBox(height: 20),

                          /// ------------------- SOCIAL ICONS -------------------
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              socialIcon(Icons.facebook, Colors.blue),
                              SizedBox(width: 10),
                              socialIcon(Icons.camera_alt, Colors.purple),
                              SizedBox(width: 10),
                              socialIcon(Icons.g_mobiledata, Colors.red),
                              SizedBox(width: 10),
                              socialIcon(Icons.work_outline, Colors.blueGrey),
                            ],
                          ),

                          SizedBox(height: 15),

                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RegisterScreen()),
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget socialIcon(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Icon(icon, color: color, size: 28),
    );
  }
}
