import 'package:flutter/material.dart';
import 'package:masari_masari/core/widgets/custom_appbar.dart';

class AppColors {
  static const deepNavy = Color(0xFF081630);
  static const tealDark = Color(0xFF125358);
  static const teal = Color(0xFF3B878C);
  static const lightGray = Color(0xFFC2C3C5);
  static const pale = Color(0xFFEBEBED);

  static const onPrimary = Colors.white;

  static LinearGradient primaryGradient = LinearGradient(
    colors: [teal, tealDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxShadow softShadow = BoxShadow(
    color: Colors.black26,
    blurRadius: 12,
    offset: Offset(0, 6),
  );
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, String>> notifications = [
    {
      'title': 'تمت إضافة فرصة تدريب جديدة',
      'date': '2026-01-10',
      'content': 'محتوى كامل للإشعار الأول هنا.'
    },
    {
      'title': 'تذكير: ورشة كتابة السيرة',
      'date': '2026-01-12',
      'content': 'محتوى كامل للإشعار الثاني هنا.'
    },
    {
      'title': 'تمت الموافقة على طلبك للتدريب',
      'date': '2026-01-15',
      'content': 'محتوى كامل للإشعار الثالث هنا.'
    },
    {
      'title': 'فرصة عمل جديدة متاحة في شركتك المفضلة',
      'date': '2026-01-18',
      'content': 'محتوى كامل للإشعار الرابع هنا.'
    },
    {
      'title': 'تحديث: مواعيد ورش العمل القادمة',
      'date': '2026-01-20',
      'content': 'محتوى كامل للإشعار الخامس هنا.'
    },
  ];

  void _showNotificationDetail(BuildContext context, Map<String, String> notification, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [AppColors.softShadow],
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 6,
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Text(
                notification['title']!,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepNavy,
                ),
              ),
              SizedBox(height: 8),
              Text(
                notification['date']!,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.tealDark,
                ),
              ),
              SizedBox(height: 16),
              Text(
                notification['content']!,
                style: TextStyle(fontSize: 16, color: AppColors.deepNavy),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // زر الحذف
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          notifications.removeAt(index);
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('تم حذف الإشعار')),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.redAccent, Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [AppColors.softShadow],
                        ),
                        child: Center(
                          child: Text('حذف', style: TextStyle(color: AppColors.onPrimary, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  // زر القراءة
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('تم وضع علامة "تمت القراءة" على الإشعار')),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        margin: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [AppColors.softShadow],
                        ),
                        child: Center(
                          child: Text('تمت القراءة', style: TextStyle(color: AppColors.onPrimary, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'الإشعارات'),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: notifications.isEmpty
            ? Center(
                child: Text(
                  'لا توجد إشعارات',
                  style: TextStyle(fontSize: 18, color: AppColors.deepNavy),
                ),
              )
            : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (c, i) {
                  final n = notifications[i];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(n['title']!),
                      subtitle: Text(n['date']!),
                      trailing: ElevatedButton(
                        onPressed: () => _showNotificationDetail(context, n, i),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.teal,
                        ),
                        child: Text('عرض', style: TextStyle(color: AppColors.onPrimary)),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
