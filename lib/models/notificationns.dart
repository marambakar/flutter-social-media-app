import 'package:pronz/models/notification.dart';
import 'package:pronz/models/post.dart';

class Notificationns {
  List<Notificationn> _Nots;

  Notificationns({
    List<Notificationn>Nots
  })
  {
    this._Nots = Nots;
  }
  List<Notificationn> get Nots => _Nots;
  set Nots(List<Notificationn> Notss) => _Nots = Notss;

  factory Notificationns.fromJson(List<dynamic> json) => Notificationns(
      Nots: List<Notificationn>.from(json.map((x) => Notificationn.fromJson(x))));
}