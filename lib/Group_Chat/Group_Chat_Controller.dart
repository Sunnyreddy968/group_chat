import 'package:chat_app/Group_Chat/model/msg_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class GroupChatController {
  IO.Socket? socket;
  List<MsgModel> listmsg = [];

  void connect() {
    socket = IO.io('http://192.168.234.232:3000', <String, dynamic>{
      "transports": ["websocket"],
      "autoconnect": false,
    });
    socket!.connect();
    socket!.onConnect((_) {
      print('connect successfully');
      socket!.on("SendMsgServer", (data){
        print(data);
        // not creating any json
       var datafrom= MsgModel(msg: data['msg'], type: data['type'], sender: data['sendername']);
      // GroupChatScreen(msglist: datafrom,);
      });
      
    });
    socket!.onDisconnect((_) => print('disconnect'));
  }

  void sendmsg(String text,String sendername){
    
    // MsgModel ownmsg=MsgModel(msg: text,type: "own",sender: sendername);
    // //  print(ownmsg);
    // //  listmsg.add(ownmsg);
    //GroupChatScreen(msglist: ownmsg,);
    socket!.emit('Msg',{
        "type":"ownmsg",
        "msg":text,
        "sendername":sendername

      });

  }
}



class useful {
  // socket!.connect(); // it will help to connect with backend
  //   socket!.onConnect((_) {                   // after connect backend the function onConnect with call
  //     print('connect successfully');

  //     //socket!.emit('sendmsg', 'send to back end'); // send the data to backend
  //     // at the back end we are using on method
  //     // emit(event,data)  the event the same in frondend as well as backend then only it will get the data

  //   });
}
