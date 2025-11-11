// map_screen.dart
import 'package:classy_parking/presentation/screens/map/parking_bottom_sheet.dart';
import 'package:classy_parking/presentation/screens/map/parking_lot_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
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

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });

    _mapController.move(currentPosition!, _mapController.camera.zoom);
  }

  /// 검색어로 위치 이동 (예: '안양')
  Future<void> _searchLocation(String query) async {
    try {
      final List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final LatLng newPosition = LatLng(
          locations.first.latitude,
          locations.first.longitude,
        );
        _mapController.move(newPosition, 15);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('검색 결과를 찾을 수 없습니다.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('검색 중 오류가 발생했습니다: $e')),
      );
    }
  }

  void _recenterMap() {
    if (currentPosition != null) {
      _mapController.move(currentPosition!, _mapController.camera.zoom);
    }
  }

  void _zoomIn() {
    final center = _mapController.camera.center;
    final zoom = _mapController.camera.zoom;
    _mapController.move(center, zoom + 1);
  }

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
            body: Stack(
              children: [
                /// 지도 본체
                FlutterMap(
                  mapController: _mapController,
                  options: const MapOptions(
                    initialCenter: initialCenter,
                    initialZoom: 14,
                    interactionOptions: InteractionOptions(
                      flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'com.funital.classyparking',
                    ),
                    MarkerLayer(
                      markers: [
                        if (currentPosition != null)
                          Marker(
                            point: currentPosition!,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.my_location,
                              color: AppColor.main,
                              size: 40,
                            ),
                          ),
                        ...viewModel.parkingLots.map(
                              (lot) => Marker(
                            point: lot.location,
                            width: 36,
                            height: 36,
                            child: GestureDetector(
                              onTap: () {
                                viewModel.selectLot(lot);
                                // **바텀 시트 수정: DraggableScrollableSheet 적용 (높이 조절 가능)**
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true, // 필수 설정
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16)),
                                  ),
                                  builder: (BuildContext context) {
                                    return DraggableScrollableSheet(
                                      initialChildSize: 0.35, // 초기 높이 (화면의 35%)
                                      minChildSize: 0.2,    // 최소 높이
                                      maxChildSize: 0.9,    // 최대 높이
                                      expand: false,
                                      builder: (context, scrollController) {
                                        return SingleChildScrollView(
                                          controller: scrollController,
                                          child: ParkingBottomSheet(
                                            location: lot.location,
                                            title: lot.name,
                                            address: lot.address,
                                            phone: lot.phone,
                                            totalSpaces: lot.totalSpaces,
                                            availableSpaces: lot.availableSpaces,
                                            feeInfo: lot.feeInfo,
                                            operationInfo: lot.operationInfo,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                Icons.local_parking,
                                // **마커 색상 적용**
                                color: lot.markerColor,
                                size: 36,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Positioned(
                  top: 10,
                  left: 16,
                  right: 16,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(12),
                    child: TextField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) => _searchLocation(value),
                      decoration: InputDecoration(
                        hintText: '위치를 검색하세요 (예: 안양시)',
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// 하단 버튼들
            floatingActionButton: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: _recenterMap,
                  tooltip: '현재 위치로 이동',
                  backgroundColor: Colors.white,
                  child: Icon(Icons.my_location, color: AppColor.main,),
                  heroTag: 'recenter',
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
                  onPressed: _zoomIn,
                  backgroundColor: Colors.white,
                  tooltip: '확대',
                  child: const Icon(Icons.zoom_in, color: AppColor.main),
                  heroTag: 'zoomIn',
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  backgroundColor: Colors.white,
                  tooltip: '축소',
                  child: const Icon(Icons.zoom_out, color: AppColor.main),
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