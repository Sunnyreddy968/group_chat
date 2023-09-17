import 'package:chat_app/Group_Chat/Group_Chat_Controller.dart';
import 'package:chat_app/Group_Chat/foundation/message_widget/othermessage.dart';
import 'package:chat_app/Group_Chat/foundation/message_widget/ownmessage.dart';
import 'package:chat_app/Group_Chat/model/msg_model.dart';
import 'package:flutter/material.dart';

class GroupChatScreen extends StatefulWidget {
  final String? name;
  final MsgModel? msglist;
  const GroupChatScreen({this.msglist, this.name, super.key});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  List<MsgModel> listofmessages = [];
  TextEditingController messsagecontroller = TextEditingController();
  GroupChatController _chatController = GroupChatController();
  //  Text(widget.name)// in order to get the data we have use widget otherwise we get an error
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //it will display at the bottom
        // bottomNavigationBar: TextButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: const Text(
        //       'Cancel',
        //       style: TextStyle(color: Colors.black, fontSize: 25),
        //     )),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            "Group Chat",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: listofmessages.length,
                    itemBuilder: (context, index) {
                      if (listofmessages[index].type == 'ownmsg') {
                        return OwnMsg(
                            msg: listofmessages[index].msg.toString(),
                            sender: listofmessages[index].sender.toString());
                      } else {
                        return OtherMsg(
                            msg: listofmessages[index].msg.toString(),
                            sender: listofmessages[index].sender.toString());
                      }
                    })),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 55,
                      child: TextFormField(
                          controller: messsagecontroller,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Type a message',
                            hintStyle: TextStyle(fontSize: 20),
                            contentPadding:
                                EdgeInsets.only(bottom: 5, left: 15),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {
                        String msg = messsagecontroller.text;

                        if (msg.isNotEmpty) {
                          _chatController.connect();
                          _chatController.sendmsg(msg, widget.name.toString());

                          messsagecontroller.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 35,
                      ))
                ],
              ),
            )
          ],
        ));
  }
}
