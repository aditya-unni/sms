import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sms/constants/controllers.dart';
import 'package:sms/constants/style.dart';
import 'package:sms/pages/admin/residents/resident_table.dart';
import 'package:sms/services/resident.dart';
import 'package:sms/widgets/custom_text.dart';

import '../../../helper/responsiveness.dart';

class ResidentsPage extends StatefulWidget {
  const ResidentsPage({Key? key}) : super(key: key);

  @override
  State<ResidentsPage> createState() => _ResidentsPageState();
}

class _ResidentsPageState extends State<ResidentsPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;
  late final TextEditingController _address;
  late final TextEditingController _contact;

  //form key
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    _address = TextEditingController();
    _contact = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    _address.dispose();
    _contact.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 86 : 6,
                      left: ResponsiveWidget.isSmallScreen(context) ? 26 : 0),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  )),
            ],
          ),
        ),
        ResidentsTable(),
        Container(
            // margin: EdgeInsets.only(
            //     top: ResponsiveWidget.isSmallScreen(context) ? 86 : 6,
            //     left: ResponsiveWidget.isSmallScreen(context) ? 26 : 0),
            child: CustomText(
          text: "Create a New Resident",
          size: 24,
          weight: FontWeight.bold,
        )),
        Form(
          key: _formKey,
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Enter your email here',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (!RegExp(
                            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
                        .hasMatch(value)) {
                      return 'Please enter a Password which has Minimum 1 Upper case Minimum 1 lowercaseMinimum 1 Numeric NumberMinimum 1 Special Character';
                    }
                    return null;
                  },
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: 'Enter your password here',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                      hintText: 'Enter your name here',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                TextField(
                  controller: _address,
                  decoration: InputDecoration(
                      hintText: 'Enter your address here',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                TextField(
                  controller: _contact,
                  decoration: InputDecoration(
                      hintText: 'Enter your contact number here',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final email = _email.text;
                      final password = _password.text;
                      final name = _name.text;
                      final address = _address.text;
                      final contact = _contact.text;
                      Map result = await ResidentServices().createResident(
                          name: name,
                          address: address,
                          contact: int.parse(contact),
                          email: email,
                          password: password);
                      if (result['success']) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Resident added successfully")));
                      }
                      if (!result['success']) {
                        if (result['message'] == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Email Alreay In Use")));
                        } else if (result['message'] == 'weak-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Weak Password")));
                        }
                      }
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: active, borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: CustomText(
                      text: "Login",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
