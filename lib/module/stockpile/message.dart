class Message{
  String title;
  String message;
  String id;

  Message({this.id,this.title,this.message});

  factory Message.fromJson(Map map){
    return Message(id: map['id'],message: map['message'],title: map['title']);
  }
}