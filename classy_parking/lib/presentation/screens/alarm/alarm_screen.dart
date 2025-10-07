import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alarm_model.dart';
import 'alarm_view_model.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  late final AlarmViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AlarmViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: const _AlarmView(),
    );
  }
}

class _AlarmView extends StatelessWidget {
  const _AlarmView({super.key});

  IconData _getAlarmIcon(AlarmType type) {
    switch (type) {
      case AlarmType.payment:
        return Icons.payment;
      case AlarmType.reservation:
        return Icons.event_available;
      case AlarmType.expiration:
        return Icons.timer;
      case AlarmType.exit:
        return Icons.exit_to_app;
      case AlarmType.availability:
        return Icons.local_parking;
    }
  }

  Color _getAlarmColor(AlarmType type) {
    switch (type) {
      case AlarmType.payment:
        return Colors.green; // 결제 완료
      case AlarmType.reservation:
        return Colors.orange; // 예약 알림
      case AlarmType.expiration:
        return Colors.redAccent; // 만료 임박
      case AlarmType.exit:
        return Colors.blueGrey; // 출차 완료
      case AlarmType.availability:
        return Colors.blue; // 잔여 자리 안내
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AlarmViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomSubAppBar(title: '알림'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _buildSectionTitle('읽지 않음'),
          ...viewModel.unreadAlarms.map(
                (alarm) => _buildAlarmTile(alarm, context),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('읽음'),
          ...viewModel.readAlarms.map(
                (alarm) => _buildAlarmTile(alarm, context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAlarmTile(AlarmModel alarm, BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<AlarmViewModel>().markAsRead(alarm.id);
      },
      leading: _buildLeadingIcon(alarm),
      title: Text(
        alarm.content,
        style: TextStyle(
          fontSize: 14,
          color: alarm.isRead ? Colors.grey[600] : Colors.black,
        ),
      ),
      subtitle: Text(
        alarm.time,
        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
      ),
    );
  }

  Widget _buildLeadingIcon(AlarmModel alarm) {
    if (alarm.imageUrl != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(alarm.imageUrl!),
        radius: 18,
      );
    }
    return CircleAvatar(
      radius: 18,
      backgroundColor:
      alarm.isRead ? Colors.grey.shade200 : Colors.grey.shade300,
      child: Icon(
        _getAlarmIcon(alarm.type),
        color: _getAlarmColor(alarm.type),
        size: 18,
      ),
    );
  }
}