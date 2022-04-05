import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logindemo/controller/address_controller.dart';
import 'package:logindemo/models/lnglat_model.dart';
import 'package:logindemo/screens/map_screen.dart';
import 'package:logindemo/widget/address_bottomsheet.dart';
import 'package:logindemo/widget/city_bottomsheet.dart';
import 'package:logindemo/widget/district_bottomsheet.dart';

class TabMap1 extends StatefulWidget {
  const TabMap1({Key? key}) : super(key: key);

  @override
  State<TabMap1> createState() => _TabMap1State();
}

class _TabMap1State extends State<TabMap1> {
  late GoogleMapController _googleMapController;
  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _initialCameraPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Marker> myMarker = [];
  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GetBuilder<ProvinceController>(
        init: ProvinceController(),
        builder: (controller) {
          _initialCameraPosition = CameraPosition(
              target: LatLng(
                controller.lat ?? 21.0467979,
                controller.lng ?? 105.8481116,
              ),
              zoom: 12);
          print('lngLatLayout : ${_initialCameraPosition} + ${controller.lng}');
          return Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  controller.updateSearchInput(text);
                },
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return const BottomSheetWidget();
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.provinceSelected),
                        Icon(Icons.arrow_drop_down_outlined),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    controller.provinceSelected == 'Select a province ...'
                        ? null
                        : showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return CityBottomSheetWidget();
                            },
                          ),
                child: Container(
                  margin: EdgeInsets.only(top: 15.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.citySelected),
                        Icon(Icons.arrow_drop_down_outlined),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.provinceSelected == 'Select a city ...'
                    ? null
                    : showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return DistrictBottomSheetWidget(
                            googleMapController: _googleMapController,
                            controllerCompleter: _controller,
                            myMarker: myMarker,
                          );
                        },
                      ),
                child: Container(
                  margin: EdgeInsets.only(top: 15.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.districtSelected),
                        Icon(Icons.arrow_drop_down_outlined),
                      ],
                    ),
                  ),
                ),
              ),
              //AIzaSyDXo8NiqDGfyCHLgNUPPof0RKQ2OUWyLEw
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () async {
                    await controller.fetchLngLat();
                    final GoogleMapController controllerGG =
                        await _controller.future;
                    controllerGG.moveCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                      target: LatLng(
                        controller.lat ?? 10.7930961,
                        controller.lng ?? 106.6902952,
                      ),
                      zoom: 18.0,
                    )));
                    setState(() {
                      myMarker.add(
                        Marker(
                          markerId: MarkerId('id-1'),
                          position: LatLng(
                            controller.lat ?? 10.7930961,
                            controller.lng ?? 106.6902952,
                          ),
                          infoWindow: InfoWindow(
                            title: 'Your location',
                          ),
                        ),
                      );
                    });
                  },
                  child: Container(
                    color: Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Find location',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SizedBox(
                  height: 180.0,
                  child: GoogleMap(
                      initialCameraPosition: _initialCameraPosition,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: true,
                      markers: Set.from(myMarker),
                      onTap: _handleTap,
                      onMapCreated: (GoogleMapController controllerGg) {
                        _controller.complete(controllerGg);

                        _googleMapController = controllerGg;
                        setState(() {
                          _googleMapController
                              .animateCamera(CameraUpdate.newCameraPosition(
                            const CameraPosition(
                              target: LatLng(10.7395205, 106.6764755),
                              zoom: 18.0,
                            ),
                          ));
                          myMarker.add(
                            const Marker(
                              markerId: MarkerId('id-1'),
                              position: LatLng(
                                10.7395205,
                                106.6764755,
                              ),
                              infoWindow: InfoWindow(
                                title: 'Your location',
                              ),
                            ),
                          );
                        });
                      }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _handleTap(LatLng tappedPoint) {
    Get.put(ProvinceController())
        .fetchLocation(tappedPoint.longitude, tappedPoint.latitude);
    setState(() {
      myMarker = [];
      myMarker.add(
        Marker(
          markerId: MarkerId(
            tappedPoint.toString(),
          ),
          position: tappedPoint,
          draggable: true,
          onDragEnd: (dragEndPosition) {
            print('end point : ${dragEndPosition}');
          },
        ),
      );
      print('tab point : ${tappedPoint.latitude}');
    });
  }
}
