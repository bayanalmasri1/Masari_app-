import 'package:flutter/material.dart';
import 'package:masari_masari/core/widgets/custom_appbar.dart';


class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  final sample = const [
    {'title': 'تمت إضافة فرصة تدريب جديدة', 'date': '2026-01-10'},
    {'title': 'تذكير: ورشة كتابة السيرة', 'date': '2026-01-12'},
    {'title': 'تمت الموافقة على طلبك للتدريب', 'date': '2026-01-15'},
    {'title': 'فرصة عمل جديدة متاحة في شركتك المفضلة', 'date': '2026-01-18'},
    {'title': 'تحديث: مواعيد ورش العمل القادمة', 'date': '2026-01-20'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'الإشعارات'),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: ListView.builder(
          itemCount: sample.length,
          itemBuilder: (c, i) {
            final n = sample[i];
            return Card(
              child: ListTile(
                title: Text(n['title']!),
                subtitle: Text(n['date']!),
                trailing: ElevatedButton(onPressed: () {}, child: Text('عرض')),
              ),
            );
          },
        ),
      ),
    );
  }
}
