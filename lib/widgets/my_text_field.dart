import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.hintText,
    required this.inputType,
    this.controller,
    this.validator,
    required this.formKey,
    this.showDropdownIcon = false,
    this.onDropdownPressed,
    required this.isEditable,
    required Null Function(dynamic value)
        onChanged, // Optional parameter to control visibility of dropdown icon
  });

  final String hintText;
  final TextInputType inputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final GlobalKey<FormState> formKey;
  final bool showDropdownIcon;
  final VoidCallback? onDropdownPressed;
  final bool
      isEditable; // Flag to determine whether to show dropdown icon or not

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: inputType,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            readOnly: !isEditable,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.all(20),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black87, fontSize: 12),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(82, 183, 136, 2),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(82, 183, 136, 2),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: showDropdownIcon
                  ? IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: onDropdownPressed,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
