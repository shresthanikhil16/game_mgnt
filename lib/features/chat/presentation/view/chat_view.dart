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

  @override
  void initState() {
    super.initState();
    _commentsBloc = getIt.get<CommentsBloc>();
    _userId = getIt.get<String>(instanceName: 'userId');
    _loggedInUserId = getIt.get<String>(instanceName: 'loggedInUserId');

    _commentsBloc.add(GetMessagesEvent(_userId));
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
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
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
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    color: const Color(0xFF990000),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        _commentsBloc.add(
                          SendMessageEvent(_userId, _controller.text),
                        );
                        _controller.clear();
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

  Widget _buildMessageBubble(MessageEntity message, bool isMe) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isMe ? const Color(0xFF990000) : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isMe ? 'You' : 'Other User',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                message.text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
