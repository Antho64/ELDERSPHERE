import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final List<String> _users = ['User 1', 'User 2', 'User 3']; // Add more users as needed
  late String _selectedUser;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedUser = _users[0]; // Set the initial selected user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat ($_selectedUser)'),
        backgroundColor: Colors.black87,
        actions: [
          _buildUserDropdown(),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Add settings functionality
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[900]!, Colors.grey[800]!],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true, // Display messages in reverse order
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            _buildInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDropdown() {
    return DropdownButton<String>(
      value: _selectedUser,
      onChanged: (String? newUser) {
        setState(() {
          _selectedUser = newUser!;
        });
      },
      items: _users.map((String user) {
        return DropdownMenuItem<String>(
          value: user,
          child: Text(user),
        );
      }).toList(),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.transparent,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.image, color: Colors.cyan),
            onPressed: () {
              // Add image picker functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.videocam, color: Colors.cyan),
            onPressed: () {
              // TODO: Implement video call logic
            },
          ),
          IconButton(
            icon: Icon(Icons.phone, color: Colors.cyan),
            onPressed: () {
              // TODO: Implement voice call logic
            },
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              textInputAction: TextInputAction.send,
              onSubmitted: _handleSubmitted,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[700]!.withOpacity(0.5),
                contentPadding: const EdgeInsets.all(12.0),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: Icon(Icons.send, color: Colors.cyan),
            onPressed: () {
              _handleSubmitted(_textController.text);
            },
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    if (text.isNotEmpty) {
      ChatMessage message = ChatMessage(
        text: text,
        isUser: true, // You can change this based on sender
      );
      setState(() {
        _messages.insert(0, message);
      });
      _simulateBotReply(); // Simulate a reply from the bot
    }
  }

  void _simulateBotReply() {
    Future.delayed(const Duration(seconds: 1), () {
      ChatMessage botReply = ChatMessage(
        text: 'Hello, $_selectedUser',
        isUser: false,
      );
      setState(() {
        _messages.insert(0, botReply);
      });
    });
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({Key? key, required this.text, required this.isUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isUser ? Colors.indigo : Colors.grey[700],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ChatScreen(),
  ));
}
