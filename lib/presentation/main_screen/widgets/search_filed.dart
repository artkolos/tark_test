import 'package:flutter/material.dart';
import 'package:tark_test/presentation/extensions/sizes_ext.dart';

class SearchFiled extends StatelessWidget {
  const SearchFiled({
    super.key,
    required this.textController,
    required this.onChanged,
  });

  final TextEditingController textController;

  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: 'Search coin pairs',
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: 'Barlow',
          color: Color(0x4DFFFFFF),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 24,
        ),
        fillColor: const Color(0xFF29303D),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              context.sizes.size5x,
            ),
          ),
          borderSide: const BorderSide(
            color: Color(0xFF29303D),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              context.sizes.size5x,
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
