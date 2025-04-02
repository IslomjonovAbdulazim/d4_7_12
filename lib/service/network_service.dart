import 'dart:convert';

import 'package:d4_7_12/models/contact_model.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  static const baseUrl = "https://67ed2ad04387d9117bbc89ac.mockapi.io";

  static Future<void> create(ContactModel contact) async {
    Uri uri = Uri.parse("$baseUrl/list");
    final response = await http.post(
      uri,
      body: jsonEncode(contact.toJson()),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print("CREATE: ${response.statusCode} ");
  }

  static Future<List<ContactModel>> read() async {
    Uri uri = Uri.parse("$baseUrl/list");
    final response = await http.get(uri);
    print("READ: ${response.statusCode}");

    if (response.statusCode >= 205) {
      return [];
    } else {
      String data = response.body;
      List jsonList = List.from(jsonDecode(data));
      final contacts =
          jsonList.map((json) => ContactModel.fromJson(json)).toList();
      return contacts;
    }
  }

  static Future<void> update(ContactModel contact) async {
    Uri uri = Uri.parse("$baseUrl/list/${contact.id}");
    final response = await http.put(
      uri,
      body: jsonEncode(contact.toJson()),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print("UPDATE: ${response.statusCode} ");
  }

  static Future<void> delete(ContactModel contact) async {
    Uri uri = Uri.parse("$baseUrl/list/${contact.id}");
    final response = await http.delete(uri);
    print("DELETE: ${response.statusCode} ");
  }
}




