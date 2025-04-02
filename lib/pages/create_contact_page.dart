import 'package:d4_7_12/models/contact_model.dart';
import 'package:flutter/material.dart';

class CreateContactPage extends StatefulWidget {
  final ContactModel? contact;

  const CreateContactPage({super.key, required this.contact});

  @override
  State<CreateContactPage> createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
