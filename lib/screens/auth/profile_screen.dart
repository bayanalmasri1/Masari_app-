import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الملف الشخصي")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          var data = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text("الاسم: ${data['name']}", style: TextStyle(fontSize: 20)),
                Text("البريد: ${data['email']}", style: TextStyle(fontSize: 18)),
                SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("تسجيل الخروج"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
