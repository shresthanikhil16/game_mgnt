import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/app/di/di.dart';
import 'package:game_mgnt/features/chat/domain/entity/chat_entity.dart';
import 'package:game_mgnt/features/chat/presentation/view_model/chat_bloc.dart';
import 'package:game_mgnt/features/chat/presentation/view_model/chat_event.dart';
import 'package:game_mgnt/features/chat/presentation/view_model/chat_state.dart';

class CommentsView extends StatefulWidget {
  const CommentsView({super.key});

  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  final TextEditingController _controller = TextEditingController();
  late CommentsBloc _commentsBloc;
  late String _userId;
  late String _loggedInUserId;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _commentsBloc = getIt.get<CommentsBloc>();

    // Fetch user IDs from getIt
    _userId = getIt.get<String>(instanceName: 'userId');
    _loggedInUserId = getIt.get<String>(instanceName: 'loggedInUserId');

    // Validate userId before making request
    if (_userId.isEmpty || !RegExp(r'^[a-fA-F0-9]{24}$').hasMatch(_userId)) {
      print('Error: Invalid User ID -> $_userId');
    } else {
      _commentsBloc.add(GetMessagesEvent(_userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF990000),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CommentsBloc, CommentsState>(
                bloc: _commentsBloc,
                builder: (context, state) {
                  if (state is CommentsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CommentsLoaded) {
                    return ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return _buildMessageBubble(
                          message,
                          message.sender == _loggedInUserId,
                        );
                      },
                    );
                  } else if (state is CommentsError) {
                    return Center(
                        child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ));
                  } else {
                    return const Center(child: Text('No messages yet.'));
                  }
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(MessageEntity message, bool isMe) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMe ? const Color(0xFF990000) : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isMe ? 'You' : 'Other User',
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                message.text,
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

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF990000),
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      _commentsBloc.add(SendMessageEvent(_userId, _controller.text.trim()));
      _controller.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0, // Scroll to the top since list is reversed
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
