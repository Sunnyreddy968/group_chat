import 'package:chat_app/Group_Chat/ChatPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  var uuid = Uuid();

  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Group Chat App',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'Please enter your name',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        content: TextFormField(
                          controller: name,
                          maxLines: 5,
                          minLines: 1,
                          //maxLength: 20, // beyond that it will not go
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              hintText: 'Enter name',
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                name.clear(); //when you click again the data doesnot delete by using this we can dekete the data
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(
                                    context); //because when we back to scrren the alert dialog not show

                                // Get.to(GroupChatScreen(
                                //   name: name.text,
                                // ));
                                Get.to(ChatPage(
                                  username: name.text,
                                  uniquei: uuid.v1(),
                                ));
                                name.clear();
                              },
                              child: const Text(
                                'Enter',
                                style:
                                    TextStyle(color: Colors.teal, fontSize: 25),
                              ))
                        ],
                      ));
            },
            child: const Text(
              'Initiate Group Chat',
              style: TextStyle(color: Colors.tealAccent, fontSize: 25),
            )),
      ),
    );
  }

//   void connectAndListen(){
//   IO.Socket socket = IO.io('http://localhost:3000',
//       OptionBuilder()
//        .setTransports(['websocket']).build());

//     socket.onConnect((_) {
//      print('connect');
//      socket.emit('msg', 'test');
//     });

//     //When an event recieved from server, data is added to the stream

//     socket.onDisconnect((_) => print('disconnect'));

// }
}
