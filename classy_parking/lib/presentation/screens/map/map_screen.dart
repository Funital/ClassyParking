import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? currentPosition;

  // 경기도 예시 주차장 좌표 (원하는 데이터로 대체 가능)
  final List<LatLng> parkingLocations = [
    LatLng(37.3947, 127.1115), // 분당
    LatLng(37.2636, 127.0286), // 수원
    LatLng(37.3510, 126.7425), // 안산
    LatLng(37.5670, 127.0095), // 구리
    LatLng(37.4449, 127.1382), // 성남
  ];

  static const LatLng initialCenter = LatLng(37.5665, 126.9780); // 서울시청

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  /// 현재 위치 가져오기
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 위치 서비스 활성화 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    // 권한 확인 및 요청
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    // 현재 위치 가져오기
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });

    // 지도를 현재 위치로 이동
    _mapController.move(currentPosition!, _mapController.camera.zoom);
  }

  /// 현재 위치로 지도 이동
  void _recenterMap() {
    if (currentPosition != null) {
      _mapController.move(currentPosition!, _mapController.camera.zoom);
    }
  }

  /// 지도 확대
  void _zoomIn() {
    final center = _mapController.camera.center;
    final zoom = _mapController.camera.zoom;
    _mapController.move(center, zoom + 1);
  }

  /// 지도 축소
  void _zoomOut() {
    final center = _mapController.camera.center;
    final zoom = _mapController.camera.zoom;
    _mapController.move(center, zoom - 1);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("지도"),
        centerTitle: true,
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: const MapOptions(
          initialCenter: initialCenter,
          initialZoom: 14,
          interactionOptions: InteractionOptions(
            flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          ),
        ),
        children: [
          // OpenStreetMap 타일 레이어
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.funital.classyparking', // ← 앱 패키지명으로 교체
          ),

          // 마커 레이어
          MarkerLayer(
            markers: [
              // 내 위치 마커 (빨간색)
              if (currentPosition != null)
                Marker(
                  point: currentPosition!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.red,
                    size: 40,
                  ),
                ),

              // 경기도 예시 주차장 마커 (파란색)
              ...parkingLocations.map(
                    (loc) => Marker(
                  point: loc,
                  width: 36,
                  height: 36,
                  child: const Icon(
                    Icons.local_parking,
                    color: Colors.blue,
                    size: 36,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      // 현재 위치로 이동 버튼
      // 현재 위치로 이동, 확대, 축소 버튼들
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _recenterMap,
            tooltip: '현재 위치로 이동',
            child: const Icon(Icons.my_location),
            heroTag: 'recenter',
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            onPressed: _zoomIn,
            tooltip: '확대',
            child: const Icon(Icons.zoom_in),
            heroTag: 'zoomIn',
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            onPressed: _zoomOut,
            tooltip: '축소',
            child: const Icon(Icons.zoom_out),
            heroTag: 'zoomOut',
          ),
        ],
      ),
    );
  }
}