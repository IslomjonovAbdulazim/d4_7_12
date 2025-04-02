import 'package:d4_7_12/models/contact_model.dart';
import 'package:d4_7_12/pages/create_contact_page.dart';
import 'package:d4_7_12/service/network_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContactModel> contacts = [];
  bool isLoading = false;

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    isLoading = true;
    setState(() {});
    contacts = await NetworkService.read();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contacts"),
        actions: [
          CupertinoButton(
            onPressed: () async {
              await Get.to(CreateContactPage(contact: null));
              load();
            },
            child: Icon(CupertinoIcons.add, size: 30),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CupertinoActivityIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final model = contacts[index];
                return Card(
                  child: ListTile(
                    onTap: () async {
                      await Get.to(CreateContactPage(contact: model));
                      load();
                    },
                    title: Text(model.name),
                    subtitle: Text(model.tel),
                    trailing: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        isLoading = true;
                        setState(() {});
                        await NetworkService.delete(model);
                        contacts = await NetworkService.read();
                        isLoading = false;
                        setState(() {});
                      },
                      child: Icon(
                        CupertinoIcons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
