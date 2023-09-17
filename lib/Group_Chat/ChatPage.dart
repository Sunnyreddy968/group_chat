import 'package:chat_app/Group_Chat/foundation/message_widget/othermessage.dart';
import 'package:chat_app/Group_Chat/foundation/message_widget/ownmessage.dart';
import 'package:chat_app/Group_Chat/model/chatmsg_model.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  final String? username;
  final String? uniquei;
  const ChatPage({this.uniquei, this.username, super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  IO.Socket? socket;
  TextEditingController messageController = TextEditingController();
  List<ChatMessage> messages = [];
  List<ChatMessage> ownmessages = [];
  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  void dispose() {
    super.dispose();
    socket!.disconnect();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    if (messages[index].type == 'ownmsg') {
                      return OwnMsg(
                          msg: messages[index].text.toString(),
                          sender: messages[index].username.toString());
                    } else {
                      return OtherMsg(
                          msg: messages[index].text.toString(),
                          sender: messages[index].username.toString());
                    }
                  })),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 55,
                    child: TextFormField(
                        controller: messageController,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Type a message',
                          hintStyle: TextStyle(fontSize: 20),
                          contentPadding: EdgeInsets.only(bottom: 5, left: 15),
                        )),
                  ),
                ),
                IconButton(
                  icon:const  Icon(Icons.send),
                  onPressed: () {
                    String messageText = messageController.text;
                    if (messageText.isNotEmpty) {
                      sendMessage(
                          messageText, widget.username.toString(), 'ownmsg');
                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  connect() {
    socket = IO.io('http://192.168.234.232:3000', <String, dynamic>{
      "transports": ["websocket"],
      "autoconnect": false,
    });
    socket!.onConnect((_) {
      print('Connected to chat server');
    });

    // Listen to incoming messages.
    socket!.on('sendermessage', (data) {
      if (data['userid'] != widget.uniquei) {
        setState(() {
          messages.add(ChatMessage(data['text'].toString(),
              data['username'].toString(), data['type']));
        });
      }
    });

    socket!.connect();
  }

  void sendMessage(String messageText, String username, String type) {
    setState(() {
      messages.add(
          ChatMessage(messageText.toString(), username.toString(), "ownmsg"));
    });

    socket!.emit('send_message', {
      'text': messageText,
      'username': username,
      'type': type,
      'userid': widget.uniquei
    });
  }
}



/*
Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.bottomRight,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width -
                            60 // to leave space left side
                        ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.teal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              messages[index].username,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              messages[index].text,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              messages[index].type,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String messageText = messageController.text;
                    if (messageText.isNotEmpty) {
                      sendMessage(
                          messageText, widget.username.toString(), 'ownmsg');
                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
    */
