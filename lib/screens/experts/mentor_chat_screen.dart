import 'package:flutter/material.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../app_colors.dart';

class MentorChatScreen extends StatelessWidget {
  const MentorChatScreen({Key? key}) : super(key: key);

  final mentors = const [
    {'name': 'أ. نورة', 'title': 'خبيرة توظيف'},
    {'name': 'د. عبدالله', 'title': 'مرشد مهني'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'المرشدون'),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Row(children: [
          Flexible(
            flex: 1,
            child: Card(
              child: ListView(padding: EdgeInsets.all(12), children: mentors.map((m) => ListTile(leading: CircleAvatar(child: Text(m['name']![0])), title: Text(m['name']!), subtitle: Text(m['title']!), trailing: ElevatedButton(onPressed: () {}, child: Text('دردشة')))).toList()),
            ),
          ),
          SizedBox(width: 12),
          Flexible(
            flex: 2,
            child: Card(
              child: Column(children: [
                Container(padding: EdgeInsets.all(16), child: Row(children: [CircleAvatar(child: Text('ن')), SizedBox(width: 12), Text('دردشة تجريبية مع المرشد', style: TextStyle(fontWeight: FontWeight.bold)), Spacer(), IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))])),
                Divider(),
                Expanded(child: ListView(padding: EdgeInsets.all(12), children: [Align(alignment: Alignment.centerRight, child: _chatBubble('مرحباً! كيف أساعدك؟', true)), Align(alignment: Alignment.centerLeft, child: _chatBubble('أريد نصائح عن السيرة الذاتية', false))])),
                Divider(),
                Padding(padding: EdgeInsets.all(8), child: Row(children: [Expanded(child: TextField(decoration: InputDecoration(hintText: 'اكتب رسالة...'))), IconButton(onPressed: () {}, icon: Icon(Icons.send, color: AppColors.teal))])),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _chatBubble(String text, bool mentor) {
    return Container(margin: EdgeInsets.symmetric(vertical: 6), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: mentor ? AppColors.pale : Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [AppColors.softShadow]), child: Text(text));
  }
}
