import 'package:flutter/material.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../app_colors.dart';

class CVBuilderScreen extends StatefulWidget {
  const CVBuilderScreen({Key? key}) : super(key: key);

  @override
  State<CVBuilderScreen> createState() => _CVBuilderScreenState();
}

class _CVBuilderScreenState extends State<CVBuilderScreen> {
  String name = '';
  String title = '';
  String summary = '';
  final skills = <String>[];
  final skillController = TextEditingController();

  @override
  void dispose() {
    skillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'بناء السيرة الذاتية'),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Row(children: [
          Expanded(
            flex: 2,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  TextFormField(decoration: InputDecoration(labelText: 'الاسم'), onChanged: (v) => setState(() => name = v)),
                  TextFormField(decoration: InputDecoration(labelText: 'المسمى'), onChanged: (v) => setState(() => title = v)),
                  TextFormField(decoration: InputDecoration(labelText: 'ملخص'), maxLines: 4, onChanged: (v) => setState(() => summary = v)),
                  SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: TextField(controller: skillController, decoration: InputDecoration(hintText: 'أضف مهارة'))),
                    SizedBox(width: 8),
                    ElevatedButton(onPressed: () {
                      final v = skillController.text.trim();
                      if (v.isNotEmpty) { setState(() { skills.add(v); skillController.clear(); }); }
                    }, child: Text('إضافة')),
                  ]),
                  SizedBox(height: 12),
                  Wrap(spacing: 8, children: skills.map((s) => Chip(label: Text(s), onDeleted: () => setState(() => skills.remove(s)))).toList()),
                  Spacer(),
                  ElevatedButton(onPressed: () {}, child: Text('حفظ')),
                ]),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(width: double.infinity, padding: EdgeInsets.symmetric(vertical: 16), decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text(name.isEmpty ? 'الاسم الكامل' : name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), SizedBox(height: 4), Text(title, style: TextStyle(color: Colors.white70))])),
                  SizedBox(height: 12),
                  Text('نبذة', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text(summary.isEmpty ? 'ملخص...' : summary, maxLines: 5, overflow: TextOverflow.ellipsis),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
