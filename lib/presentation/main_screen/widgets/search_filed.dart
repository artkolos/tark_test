import 'package:flutter/material.dart';
import 'package:tark_test/presentation/common/fonts.dart';
import 'package:tark_test/presentation/extensions/sizes_ext.dart';

class SearchFiled extends StatelessWidget {
  const SearchFiled({
    super.key,
    required this.textController,
    required this.onChanged,
  });

  static const String _HINT_TEXT = 'Search coin pairs';

  final TextEditingController textController;

  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: Colors.white,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.BARLOW,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search_outlined,
          color: Color(0x33FFFFFF),
        ),
        hintText: _HINT_TEXT,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: AppFonts.BARLOW,
          color: Color(0x4DFFFFFF),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: context.sizes.sizeMedium,
        ),
        fillColor: const Color(0xFF29303D),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              context.sizes.sizeLarge,
            ),
          ),
          borderSide: const BorderSide(
            color: Color(0xFF29303D),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              context.sizes.sizeLarge,
            ),
          ),
          borderSide: const BorderSide(
            color: Color(0xFF29303D),
          ),
        ),
      ),
    );
  }
}
