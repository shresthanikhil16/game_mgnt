import 'package:flutter/material.dart';

class CommentsView extends StatefulWidget {
  const CommentsView({super.key});

  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  // Controller for typing new messages
  final TextEditingController _controller = TextEditingController();

  // List to store the messages (for demonstration purposes)
  final List<Map<String, String>> _messages = [
    {'sender': 'John', 'message': 'Hey there! How are you?'},
    {'sender': 'You', 'message': 'I am doing great, thanks!'},
    {'sender': 'John', 'message': 'Awesome! Let\'s catch up soon.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments / Chat'),
        backgroundColor: const Color(0xFF990000), // Match with dashboard color
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Message List
            Expanded(
              child: ListView.builder(
                reverse:
                    true, // To display the most recent message at the bottom
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessageBubble(
                      message['sender']!, message['message']!);
                },
              ),
            ),
            // Text Input for sending messages
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  // Text Input Field
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Send Button
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        setState(() {
                          _messages.insert(
                            0,
                            {
                              'sender': 'You',
                              'message': _controller.text
                            }, // Add new message at the top
                          );
                          _controller.clear(); // Clear input field
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable widget for individual message bubbles
  Widget _buildMessageBubble(String sender, String message) {
    final bool isMe =
        sender == 'You'; // Determine if the message is from the user

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isMe ? const Color(0xFF990000) : const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sender,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
