import 'package:finalyear/components/constants.dart';
import 'package:finalyear/screens/signup/widgets/methods.dart';
import 'package:finalyear/widgets/my_text_button.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class StaffForm extends StatefulWidget {
  const StaffForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StaffFormState createState() => _StaffFormState();
}

class _StaffFormState extends State<StaffForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Name",
            style: kBodyText.copyWith(fontSize: 13),
          ),
          MyTextField(
            hintText: "Name..",
            inputType: TextInputType.text,
            formKey: _formKey,
            isEditable: true,
            onChanged: (value) {},
          ),
          Text(
            "Location",
            style: kBodyText.copyWith(fontSize: 13),
          ),
          MyTextField(
            hintText: 'Location',
            controller: _locationController,
            inputType: TextInputType.text,
            onDropdownPressed: () {
              location(context, _locationController);
            },
            formKey: _formKey,
            showDropdownIcon: true,
            isEditable: false,
            onChanged: (value) {},
          ),
          Text(
            "Number",
            style: kBodyText.copyWith(fontSize: 13),
          ),
          MyTextField(
            hintText: "Number..",
            inputType: TextInputType.text,
            formKey: _formKey,
            isEditable: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a number';
              }
              if (int.tryParse(value) == null) {
                return 'Please enter a valid integer';
              }
              return null;
            },
            onChanged: (value) {},
          ),
          MyTextButton(
            buttonName: 'Add',
            onPressed: () {},
            bgColor: const Color(0xFF0D9752),
            textColor: Colors.black,
          )
        ],
      ),
    );
  }
}
