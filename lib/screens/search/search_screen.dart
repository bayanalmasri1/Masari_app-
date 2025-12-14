import 'package:flutter/material.dart';
import '../../core/widgets/custom_appbar.dart';

class SearchScreen extends StatefulWidget {
  final String? initialQuery;
  const SearchScreen({Key? key, this.initialQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;
  String query = '';

  @override
  void initState() {
    super.initState();
    query = widget.initialQuery ?? '';
    _controller = TextEditingController(text: query);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearch(String value) {
    setState(() {
      query = value;
    });
    // هنا لاحقًا تضيف منطق البحث الحقيقي
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is String && arg.isNotEmpty) {
      query = arg;
      _controller.text = arg;
    }

    return Scaffold(
      appBar: CustomAppBar(title: 'نتائج البحث'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 حقل البحث
            TextField(
              controller: _controller,
              onSubmitted: _onSearch,
              decoration: InputDecoration(
                hintText: 'ابحث عن فرصة، شركة، مدينة...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 16),

            /// عنوان النتائج
            Text(
              'نتائج البحث عن: "$query"',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            /// النتائج
            Expanded(
              child: Center(
                child: Text(
                  query.isEmpty
                      ? 'ابدأ بكتابة كلمة البحث'
                      : 'قائمة نتائج البحث ستظهر هنا',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
