import 'package:flutter/material.dart';
import '../../core/widgets/custom_appbar.dart';

class SearchScreen extends StatelessWidget {
  final String? initialQuery;
  const SearchScreen({Key? key, this.initialQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments;
    final q = arg is String ? arg : initialQuery ?? '';
    return Scaffold(
      appBar: CustomAppBar(title: 'نتائج البحث'),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(children: [
          Text('نتائج البحث عن: "$q"', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Expanded(child: Center(child: Text('قائمة نتائج البحث ستظهر هنا'))),
        ]),
      ),
    );
  }
}
