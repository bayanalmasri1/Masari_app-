import 'package:flutter/material.dart';
import '../../core/widgets/custom_appbar.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);

  final events = const [
    {'title': 'ورشة كتابة السيرة', 'date': '2026-01-15'},
    {'title': 'محاكاة مقابلات', 'date': '2026-02-05'},
  ];

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
                      onPressed: () {},
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
