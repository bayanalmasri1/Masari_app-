import 'package:flutter/material.dart';
import '../../core/widgets/custom_appbar.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? selectedCity;
  String? selectedType;

  final cities = ['الرياض', 'القصيم', 'الدمام'];
  final types = ['تدريب', 'دوام جزئي', 'دوام كامل'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'تصفية الفرص'),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'المدينة'),
            items: cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => selectedCity = v),
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'نوع الوظيفة'),
            items: types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
            onChanged: (v) => setState(() => selectedType = v),
          ),
          SizedBox(height: 16),
          Row(children: [
            ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('تطبيق')),
            SizedBox(width: 8),
            OutlinedButton(onPressed: () => setState(() { selectedCity = null; selectedType = null; }), child: Text('مسح')),
          ])
        ]),
      ),
    );
  }
}
