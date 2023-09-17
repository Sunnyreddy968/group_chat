class MsgModel {
  String? type;
  String? msg;
  String? sender;
  MsgModel({required this.msg, required this.type, required this.sender});

  Map<String, dynamic> toJson() => {'type': type, 'msg': msg, 'sender': sender};
}
