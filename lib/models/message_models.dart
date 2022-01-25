import 'message_model.dart';
class message_models{
  List<Message_model> _messages;
  message_models(
  {
    List<Message_model>messages,
    }
      )
  {
    this._messages = messages;
  }
  List<Message_model> get messages => _messages;
  set posts(List<Message_model> messagess) => _messages = messagess;

  factory message_models.fromJson(List<dynamic> json) => message_models(
      messages: List<Message_model>.from(json.map((x) => Message_model.fromJson(x))));
}