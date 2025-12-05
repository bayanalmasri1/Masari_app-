import 'package:flutter/material.dart';
import '../../core/widgets/custom_appbar.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  final posts = const [
    {'title': 'كيف كتبت سيرتي؟', 'author': 'أحمد'},
    {'title': 'تجربة مقابلة لدى شركة X', 'author': 'سارة'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'مجتمع مساري'),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: posts
              .map(
                (p) => Card(
                  child: ListTile(
                    title: Text(p['title']!),
                    subtitle: Text('بواسطة ${p['author']}'),
                    trailing: TextButton(onPressed: () {}, child: Text('عرض')),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
