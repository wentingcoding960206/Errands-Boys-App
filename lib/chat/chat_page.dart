import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errands_boys/auth_service.dart';
import 'package:errands_boys/chat/chat_bubble.dart';
import 'package:errands_boys/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverName;
  final String receiverID;

  const ChatPage({
    super.key, 
    required this.receiverName, 
    required this.receiverID, 
    required timestamp,
    required message,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // for textfield focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // add listner to focus node
    myFocusNode.addListener(() {
      if(myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
       _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1) ,
      curve: Curves.fastOutSlowIn
    );
  }

  // send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.SendMessage(widget.receiverID, _messageController.text);

      _messageController.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverName)),
      body: Column(
        children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: _buildMessageList(),
          )), _builderUserInput()],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // align message to the right if the sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: 
          isCurrentUser ? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data['message'], 
            isCurrentUser: isCurrentUser
          )
        ],
      ),
    );
  }

  Widget _builderUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(60, 158, 158, 158),
                ),
                child: TextField(
                  controller: _messageController,
                  focusNode: myFocusNode,
                  obscureText: false,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Type a message",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ),
          ),

      
          Container(
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage, 
              icon: Icon(
                Icons.arrow_upward,
                color: Colors.white
              )
            )),
        ],
      ),
    );
  }
}
