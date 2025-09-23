import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 서울 시청(37.5665, 126.9780)를 초기 중심으로 설정
    const initialCenter = LatLng(37.5665, 126.9780);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('지도'),
      //   centerTitle: true,
      // ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: initialCenter,
          initialZoom: 14,
          // 회전 비활성화 (원하면 제거)
          interactionOptions: InteractionOptions(
            flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          ),
        ),
        children: [
          // OSM 타일 레이어
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            // OSM 정책상 User-Agent 설정 권장(본인 앱 패키지명으로 교체)
            userAgentPackageName: 'com.example.classy_parking',
          ),

          // 초기 마커(예: 서울 시청)
          MarkerLayer(
            markers: const [
              Marker(
                point: initialCenter,
                width: 40,
                height: 40,
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}