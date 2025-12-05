import 'package:flutter/material.dart';
import 'package:masari_masari/core/halpers/navigation.dart';
import '../../routes.dart';


class SearchBarInline extends StatefulWidget {
  final String hint;
  const SearchBarInline({Key? key, this.hint = 'ابحث عن تدريب أو وظيفة...'}) : super(key: key);

  @override
  State<SearchBarInline> createState() => _SearchBarInlineState();
}

class _SearchBarInlineState extends State<SearchBarInline> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: TextField(
        controller: _controller,
        onSubmitted: (q) {
          // Go to search screen with query
          NavHelper.push(context, Routes.search, args: q);
        },
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
