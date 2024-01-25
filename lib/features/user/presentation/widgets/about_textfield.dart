import 'package:flutter/material.dart';

class AboutTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool? readOnly;
  final bool? disabled;
  final Widget? suffix;
  final TextInputType? keyboardType;

  const AboutTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.disabled = false,
    this.suffix,
    this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, right: 8),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white60),
            )
          ),
          const SizedBox(width: 24,),
          Expanded(
            child: TextFormField(
              key: Key(label),
              onTap: onTap,
              readOnly: readOnly!,
              textAlign: TextAlign.right,
              keyboardType: keyboardType,
              style: TextStyle(
                color: disabled! ? Colors.white24 : Colors.white
              ),
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: const BorderSide(width: 1, color: Colors.white24)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: const BorderSide(width: 1, color: Colors.white24)
                ),
                contentPadding: const EdgeInsets.only(right: 16),
                suffix: suffix
              ),
            ),
          ),
        ],
      ),
    );
  }
}