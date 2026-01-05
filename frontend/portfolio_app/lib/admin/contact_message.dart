
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import '../core/api_service.dart';

class ContactMessages extends StatefulWidget {
  const ContactMessages({super.key});

  @override
  State<ContactMessages> createState() => _ContactMessagesState();
}

class _ContactMessagesState extends State<ContactMessages> {
  final api = ApiService();
  List messages = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  Future<void> loadMessages() async {
    final token = context.read<AuthService>().token!;

    final data = await api.get(
      '/api/admin/contact',
      token: token,
    );

    setState(() {
      messages = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (messages.isEmpty) {
      return const Center(child: Text('No messages yet'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (_, i) {
        final m = messages[i];
        return Card(
          child: ListTile(
            title: Text(m['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m['email']),
                const SizedBox(height: 8),
                Text(m['message']),
              ],
            ),
          ),
        );
      },
    );
  }
}
