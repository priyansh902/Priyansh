import 'package:flutter/material.dart';
import '../../core/api_service.dart';



class ContactSlide extends StatefulWidget {
  const ContactSlide({super.key});

  @override
  State<ContactSlide> createState() => _ContactSlideState();
}

class _ContactSlideState extends State<ContactSlide> {
  final api = ApiService();

  final name = TextEditingController();
  final email = TextEditingController();
  final message = TextEditingController();

  bool sending = false;

  Future<void> submit() async {
    setState(() => sending = true);

    await api.post('/api/public/contact', {
      'name': name.text,
      'email': email.text,
      'message': message.text,
    });

    setState(() => sending = false);

    name.clear();
    email.clear();
    message.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message sent successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Contact Me',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: name,
                  decoration:
                      const InputDecoration(labelText: 'Your name'),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: email,
                  decoration:
                      const InputDecoration(labelText: 'Your email'),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: message,
                  maxLines: 3,
                  decoration:
                      const InputDecoration(labelText: 'Message'),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: sending ? null : submit,
                    child: sending
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Send Message'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
