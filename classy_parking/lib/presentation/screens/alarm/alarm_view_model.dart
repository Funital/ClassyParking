import 'package:flutter/material.dart';
import 'alarm_model.dart';

class AlarmViewModel extends ChangeNotifier {
  final List<AlarmModel> _alarms = [
    AlarmModel(
      id: '1',
      content: '주차 요금 결제가 완료되었습니다.',
      time: '방금 전',
      isRead: false,
      type: AlarmType.payment,
    ),
    AlarmModel(
      id: '2',
      content: '예약하신 주차장 입차 시간이 10분 남았습니다.',
      time: '15분 전',
      isRead: false,
      type: AlarmType.reservation,
    ),
    AlarmModel(
      id: '3',
      content: '주차 시간이 곧 만료됩니다. 연장을 원하시면 결제 버튼을 눌러주세요.',
      time: '30분 전',
      isRead: false,
      type: AlarmType.expiration,
    ),
    AlarmModel(
      id: '4',
      content: '주차장에서 출차가 완료되었습니다. 이용해주셔서 감사합니다.',
      time: '1시간 전',
      isRead: true,
      type: AlarmType.exit,
    ),
    AlarmModel(
      id: '5',
      content: 'SKT 타워 주차장에 빈자리 5개가 남았습니다.',
      time: '2시간 전',
      isRead: true,
      type: AlarmType.availability,
    ),
  ];
  List<AlarmModel> get unreadAlarms =>
      _alarms.where((a) => !a.isRead).toList();

  List<AlarmModel> get readAlarms =>
      _alarms.where((a) => a.isRead).toList();

  void markAsRead(String id) {
    final index = _alarms.indexWhere((a) => a.id == id);
    if (index != -1) {
      _alarms[index] = AlarmModel(
        id: _alarms[index].id,
        content: _alarms[index].content,
        time: _alarms[index].time,
        isRead: true,
        type: _alarms[index].type,
        imageUrl: _alarms[index].imageUrl,
      );
      notifyListeners();
    }
  }
}