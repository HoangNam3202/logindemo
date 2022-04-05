import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logindemo/controller/address_controller.dart';
import 'package:logindemo/models/address_model.dart';

class DistrictBottomSheetWidget extends StatefulWidget {
  const DistrictBottomSheetWidget({
    Key? key,
    required this.googleMapController,
    required this.controllerCompleter,
    required this.myMarker,
  }) : super(key: key);
  final GoogleMapController googleMapController;
  final Completer<GoogleMapController> controllerCompleter;
  final List<Marker> myMarker;

  @override
  State<DistrictBottomSheetWidget> createState() =>
      _DistrictBottomSheetWidgetState();
}

class _DistrictBottomSheetWidgetState extends State<DistrictBottomSheetWidget> {
  var indexProvince, indexCity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<Datum>? item = Get.put(ProvinceController()).address.value?.data;
    indexProvince = item?.indexWhere((element) =>
        element.level1Id == Get.put(ProvinceController()).idProvinceSelected);
    List<Level2>? itemCity = Get.put(ProvinceController())
        .address
        .value
        ?.data?[indexProvince]
        .level2S;
    indexCity = itemCity?.indexWhere((element) =>
        element.level2Id == Get.put(ProvinceController()).idCitySelected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 18.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Pick a city',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: Color(0xFF979797),
                  ),
                ),
                GestureDetector(
                  child: const Icon(
                    Icons.close,
                    color: Color(0xFF979797),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Container(
              height: 240.0,
              child: GetBuilder<ProvinceController>(
                init: ProvinceController(),
                builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.address.value?.data?[indexProvince]
                        .level2S?[indexCity].level3S?.length,
                    itemBuilder: (context, index) {
                      var item = controller.address.value?.data?[indexProvince]
                          .level2S?[indexCity].level3S?[index];
                      return GestureDetector(
                        onTap: () async {
                          controller.updateSeletedDistrict(item?.name);
                          Navigator.of(context).pop();
                          // await controller.fetchLngLat();
                          // final GoogleMapController controllerGG =
                          //     await widget.controllerCompleter.future;
                          // controllerGG.moveCamera(
                          //     CameraUpdate.newCameraPosition(CameraPosition(
                          //   target: LatLng(
                          //     controller.lat ?? 10.7930961,
                          //     controller.lng ?? 106.6902952,
                          //   ),
                          //   zoom: 18.0,
                          // )));
                          // widget.myMarker.add(
                          //   Marker(
                          //     markerId: MarkerId('id-1'),
                          //     position: LatLng(
                          //       controller.lat ?? 10.7930961,
                          //       controller.lng ?? 106.6902952,
                          //     ),
                          //     infoWindow: InfoWindow(
                          //       title: 'Your location',
                          //     ),
                          //   ),
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          )),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text('${item?.name}'),
                          ),
                        ),
                      );
                    },
                  );
                },
              )),
        ],
      ),
    );
  }
}
