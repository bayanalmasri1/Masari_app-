import 'package:flutter/material.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../models/opportunity_model.dart';
import '../../app_colors.dart'; // ألوان المشروع

class OpportunityApplyScreen extends StatefulWidget {
  const OpportunityApplyScreen({Key? key}) : super(key: key);

  @override
  State<OpportunityApplyScreen> createState() => _OpportunityApplyScreenState();
}

class _OpportunityApplyScreenState extends State<OpportunityApplyScreen> {
  final _formKey = GlobalKey<FormState>();
  String fullName = '';
  String email = '';
  String note = '';

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments;
    final Opportunity op = arg as Opportunity? ??
        Opportunity(id: 'na', title: 'فرصة', company: '', location: '', description: '');

    // لتحديد عرض البطاقة حسب حجم الشاشة
    double maxCardWidth = 500; // الحد الأقصى للعرض

    return Scaffold(
      appBar: CustomAppBar(title: 'تقديم على ${op.title}'),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxCardWidth),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'تقديم على الفرصة',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepNavy,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'الاسم الكامل',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onSaved: (v) => fullName = v ?? '',
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onSaved: (v) => email = v ?? '',
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'ملاحظة',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        maxLines: 4,
                        onSaved: (v) => note = v ?? '',
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity, // الزر يبقى ممتد داخل البطاقة فقط
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.teal,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            _formKey.currentState?.save();
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('تم الإرسال'),
                                content: Text('تم تقديم طلبك على "${op.title}" بنجاح (محاكاة).'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('حسناً'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text(
                            'إرسال التقديم',
                            style: TextStyle(fontSize: 16, color: AppColors.pale),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
