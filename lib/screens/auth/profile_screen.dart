import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masari_masari/app_colors.dart';
import '../../routes.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> _editProfile(Map<String, dynamic> data) async {
    final nameCtrl = TextEditingController(text: data['name']);
    final emailCtrl = TextEditingController(text: data['email']);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("تعديل البيانات", style: TextStyle(fontWeight: FontWeight.bold)),
        content: SizedBox(
          height: 150,
          child: Column(
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(labelText: "الاسم"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(labelText: "البريد"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("إلغاء")),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(user!.uid)
                  .update({
                "name": nameCtrl.text,
                "email": emailCtrl.text,
              });

              Navigator.pop(context);
            },
            child: Text("حفظ"),
          ),
        ],
      ),
    );
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final file = File(image.path);

    final ref = FirebaseStorage.instance
        .ref()
        .child("profile_images/${user!.uid}.jpg");

    await ref.putFile(file);
    final url = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
      "profileImage": url,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("الملف الشخصي"),
        backgroundColor: AppColors.deepNavy,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(user!.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data()!;
          final imageUrl = data['profileImage'];

          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // -------------------- صورة البروفايل ------------------------
                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 8),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 65,
                          backgroundImage: imageUrl != null
                              ? NetworkImage(imageUrl)
                              : AssetImage("assets/default_user.png") as ImageProvider,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _uploadImage,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.tealDark,
                            child: Icon(Icons.camera_alt, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),

                // -------------------- بطاقة البيانات ------------------------
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person, color: AppColors.deepNavy),
                            SizedBox(width: 10),
                            Text("الاسم:", style: TextStyle(fontSize: 18)),
                            Spacer(),
                            Text(data['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Icon(Icons.email, color:AppColors.deepNavy ),
                            SizedBox(width: 10),
                            Text("البريد:", style: TextStyle(fontSize: 18)),
                            Spacer(),
                            Text(data['email'], style: TextStyle(fontSize: 17)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // -------------------- زر تعديل البيانات ------------------------
                ElevatedButton.icon(
                  onPressed: () => _editProfile(data),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tealDark,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  icon: Icon(Icons.edit,color: Colors.white,),
                  label: Text("تعديل البيانات",style: TextStyle(color: Colors.white),),
                ),

                SizedBox(height: 10),

                // -------------------- الانتقال إلى صفحة CV ------------------------
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, Routes.cvBuilder),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  icon: Icon(Icons.assignment,color: Colors.white,),
                  label: Text("الانتقال إلى CV",style: TextStyle(color: Colors.white),),
                ),

                SizedBox(height: 10),

                // -------------------- تسجيل الخروج ------------------------
                ElevatedButton.icon(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 171, 6, 6),
                    minimumSize: Size(double.infinity, 50),
                    padding: EdgeInsets.symmetric(horizontal: 60),
                  ),
                  icon: Icon(Icons.logout,color: Colors.white,),
                  label: Text("تسجيل الخروج",style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
