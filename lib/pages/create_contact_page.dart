import 'package:d4_7_12/models/contact_model.dart';
import 'package:d4_7_12/service/network_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateContactPage extends StatefulWidget {
  final ContactModel? contact;

  const CreateContactPage({super.key, required this.contact});

  @override
  State<CreateContactPage> createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  final nameController = TextEditingController();
  final nameFocus = FocusNode();
  final telController = TextEditingController();
  final telFocus = FocusNode();
  bool isLoading = false;

  @override
  void initState() {
    nameController.text = widget.contact?.name ?? "";
    telController.text = widget.contact?.tel ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                focusNode: nameFocus,
                decoration: InputDecoration(
                  hintText: "Fullname...",
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: telController,
                focusNode: telFocus,
                decoration: InputDecoration(
                  hintText: "Phone Number...",
                ),
              ),
              SizedBox(height: 20),
              CupertinoButton(
                color: Colors.indigo,
                onPressed: isLoading ? null : () async {
                        isLoading = true;
                        setState(() {});
                        final contact = ContactModel(
                          name: nameController.text,
                          tel: telController.text,
                        );
                        if (widget.contact == null) {
                          await NetworkService.create(contact);
                        } else {
                          contact.id = widget.contact!.id;
                          await NetworkService.update(contact);
                        }
                        isLoading = false;
                        setState(() {});
                        Get.back();
                      },
                child: Center(
                    child: isLoading
                        ? CupertinoActivityIndicator()
                        : Text("Save")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
