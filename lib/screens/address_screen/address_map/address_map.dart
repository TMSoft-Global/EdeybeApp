import 'dart:async';

import 'package:edeybe/controllers/address_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/screens/address_screen/address_map/map_widget_bottom_bar/map_wiget_bottom_bar.dart';
import 'package:edeybe/utils/app_geolocation.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressMapWidget extends StatefulWidget {
  final Function(Map<String, dynamic> address) setAddress;
  AddressMapWidget({Key key, this.setAddress}) : super(key: key);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(5.55602, -0.1969),
    zoom: 10.4746,
  );

  @override
  _AddressMapWidgetState createState() => _AddressMapWidgetState();
}

class _AddressMapWidgetState extends State<AddressMapWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor markerIcon;
  var _addressController = Get.find<AddressController>();
  static const LatLng _center = const LatLng(5.55602, -0.1969);
  final MapType _currentMapType = MapType.normal;
  Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  String _mark;
  @override
  void initState() {
    _getMapMarker();
    super.initState();
  }

  Future<void> _getMapMarker() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(120.w, 150.w)),
        "assets/images/map_marker.png",
        mipmaps: false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          brightness: Brightness.dark,
          iconTheme: Get.theme.iconTheme.copyWith(color: Colors.white),
          title: Text(S.of(context).addAddress,
              style: TextStyle(color: Colors.white))),
      bottomNavigationBar: MapWidgetBottomBar(
        onConfirmLocation: () {
          if (widget.setAddress != null)
            _addressController.getClosestAddress({
              "long": _lastMapPosition.longitude,
              "lat": _lastMapPosition.latitude
            }, callback: (data) {
              widget.setAddress(data);
              Get.back();
            });
        },
        onGetLocation: _getCurrentLocation,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            zoomControlsEnabled: false,
            compassEnabled: false,
            mapType: _currentMapType,
            initialCameraPosition: AddressMapWidget._kGooglePlex,
            onMapCreated: _onMapCreated,
            markers: _markers,
            onCameraMove: _onCameraMove,
            onTap: _onTap,
          ),
          if (_mark != null)
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Container(
                constraints: BoxConstraints(minHeight: 40.w),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3.4.w,
                        offset: Offset(0, 3.4.w),
                        color: Constants.boxShadow)
                  ],
                  borderRadius: BorderRadius.circular(8.0.w),
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      color: Get.theme.primaryColor,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Text(
                          _mark,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onCameraMove(CameraPosition position) async {
    _lastMapPosition = position.target;
  }

  void _onTap(LatLng position) async {
    _lastMapPosition = position;
    List<Placemark> mark = await AppGeoLocation.instance
        .placeMarkFromCordinates(
            startLat: _lastMapPosition.latitude,
            endLong: _lastMapPosition.longitude);
    _mark =
        "${mark[0].name}-${mark[0].thoroughfare}-${mark[0].subAdministrativeArea}-${mark[0].country}";
    _onAddMarker();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> _getCurrentLocation() async {
    AppGeoLocation.instance.getDeviceLocation().then((Position position) async {
      final GoogleMapController controller = await _controller.future;
      _lastMapPosition = LatLng(position.latitude, position.longitude);
      List<Placemark> mark = await AppGeoLocation.instance
          .placeMarkFromCordinates(
              startLat: position.latitude, endLong: position.longitude);
      _mark =
          "${mark[0].name}-${mark[0].thoroughfare}-${mark[0].subAdministrativeArea}-${mark[0].country}";
      _onAddMarker();
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 192.8334901395799,
          target: _lastMapPosition,
          tilt: 59.440717697143555,
          zoom: 17.151926040649414)));
    });
  }

  void _onAddMarker() async {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        icon: markerIcon,
      ));
    });
  }
}
