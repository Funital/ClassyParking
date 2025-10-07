import 'package:classy_parking/presentation/screens/map/parking_bottom_sheet.dart';
import 'package:classy_parking/presentation/screens/map/parking_lot_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? currentPosition;

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
    return ChangeNotifierProvider(
      create: (_) => ParkingLotViewModel(),
      child: Consumer<ParkingLotViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
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
                  userAgentPackageName: 'com.funital.classyparking',
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

                    // ViewModel의 주차장 리스트 기반 마커
                    ...viewModel.parkingLots.map(
                          (lot) => Marker(
                        point: lot.location,
                        width: 36,
                        height: 36,
                        child: GestureDetector(
                          onTap: () {
                            viewModel.selectLot(lot);
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                              ),
                              builder: (BuildContext context) {
                                return ParkingBottomSheet(
                                  location: lot.location,
                                  title: lot.name,
                                  address: lot.address,
                                  phone: lot.phone,
                                  totalSpaces: lot.totalSpaces,
                                  availableSpaces: lot.availableSpaces,
                                  feeInfo: lot.feeInfo,
                                  operationInfo: lot.operationInfo,
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.local_parking,
                            color: Colors.blue,
                            size: 36,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // 현재 위치로 이동, 확대/축소 버튼
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
        },
      ),
    );
  }
}