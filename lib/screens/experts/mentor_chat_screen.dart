import 'package:flutter/material.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../app_colors.dart';

class MentorChatScreen extends StatefulWidget {
  const MentorChatScreen({Key? key}) : super(key: key);

  @override
  State<MentorChatScreen> createState() => _MentorChatScreenState();
}

class _MentorChatScreenState extends State<MentorChatScreen> {
  final mentors = const [
    {'name': 'أ. نورة', 'title': 'خبيرة توظيف'},
    {'name': 'د. عبدالله', 'title': 'مرشد مهني'},
  ];

  int selectedMentor = 0;

  /// لكل مرشد محادثة مستقلة
  final Map<int, List<Map<String, dynamic>>> chats = {
    0: [
      {'mentor': true, 'msg': 'مرحباً! كيف أساعدك؟'},
    ],
    1: [
      {'mentor': true, 'msg': 'مرحباً! أنا هنا لدعمك مهنياً.'},
    ],
  };

  final msgCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'المرشدون'),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Row(
          children: [
            /// ----------------- قائمة المرشدين -----------------
            Flexible(
              flex: 1,
              child: Card(
                child: ListView(
                  padding: EdgeInsets.all(12),
                  children: List.generate(mentors.length, (i) {
                    final m = mentors[i];
                    final selected = i == selectedMentor;

                    return ListTile(
                      leading: CircleAvatar(child: Text(m['name']![0])),
                      title: Text(m['name']!),
                      subtitle: Text(m['title']!),
                      tileColor: selected ? AppColors.pale : null,
                      onTap: () {
                        setState(() => selectedMentor = i);
                      },
                      trailing: ElevatedButton(
                        onPressed: () {
                          setState(() => selectedMentor = i);
                        },
                        child: Text('دردشة'),
                      ),
                    );
                  }),
                ),
              ),
            ),

            SizedBox(width: 12),

            /// ----------------- شاشة المحادثة -----------------
            Flexible(
              flex: 2,
              child: Card(
                child: Column(
                  children: [
                    /// Header
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Text(mentors[selectedMentor]['name']![0]),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'دردشة مع ${mentors[selectedMentor]['name']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),

                    Divider(),

                    /// Messages
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(12),
                        children: chats[selectedMentor]!
                            .map((msg) => Align(
                                  alignment: msg['mentor']
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: _chatBubble(msg['msg'], msg['mentor']),
                                ))
                            .toList(),
                      ),
                    ),

                    Divider(),

                    /// Input
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: msgCtrl,
                              decoration:
                                  InputDecoration(hintText: 'اكتب رسالة...'),
                            ),
                          ),
                          IconButton(
                            onPressed: sendMessage,
                            icon: Icon(Icons.send, color: AppColors.teal),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ------------ دالة إرسال الرسائل + الرد التلقائي البسيط -------------
  void sendMessage() {
    final text = msgCtrl.text.trim();
    if (text.isEmpty) return;

    setState(() {
      chats[selectedMentor]!.add({'mentor': false, 'msg': text});
    });

    msgCtrl.clear();

    /// رد تلقائي بسيط
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        chats[selectedMentor]!.add({
          'mentor': true,
          'msg': 'تم استلام رسالتك 👍\nسأساعدك قدر المستطاع!'
        });
      });
    });
  }

  Widget _chatBubble(String text, bool mentor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: mentor ? AppColors.pale : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [AppColors.softShadow],
      ),
      child: Text(text),
    );
  }
}
