import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/widgets/custom_appbar.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);

  final events = const [
    {'title': 'ورشة كتابة السيرة', 'date': '2026-01-15'},
    {'title': 'محاكاة مقابلات', 'date': '2026-02-05'},
  ];

  void _showRegisterDialog(BuildContext context, String eventTitle) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController specialtyController = TextEditingController();
    final TextEditingController ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('تسجيل في $eventTitle'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'الاسم'),
                    validator: (value) =>
                        value!.isEmpty ? 'الرجاء إدخال الاسم' : null,
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(labelText: 'رقم الهاتف'),
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        value!.isEmpty ? 'الرجاء إدخال رقم الهاتف' : null,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value!.isEmpty ? 'الرجاء إدخال البريد الإلكتروني' : null,
                  ),
                  TextFormField(
                    controller: specialtyController,
                    decoration: InputDecoration(labelText: 'التخصص'),
                    validator: (value) =>
                        value!.isEmpty ? 'الرجاء إدخال التخصص' : null,
                  ),
                  TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(labelText: 'العمر'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'الرجاء إدخال العمر' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // إرسال البيانات إلى Firebase
                  await FirebaseFirestore.instance.collection('event_registrations').add({
                    'event': eventTitle,
                    'name': nameController.text,
                    'phone': phoneController.text,
                    'email': emailController.text,
                    'specialty': specialtyController.text,
                    'age': ageController.text,
                    'timestamp': Timestamp.now(),
                  });

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تم التسجيل بنجاح!')),
                  );
                }
              },
              child: Text('تسجيل'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'ورش وفعاليات'),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: events
              .map(
                (e) => Card(
                  child: ListTile(
                    title: Text(e['title']!),
                    subtitle: Text(e['date']!),
                    trailing: ElevatedButton(
                      onPressed: () => _showRegisterDialog(context, e['title']!),
                      child: Text('سجل'),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
