import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logindemo/controller/address_controller.dart';
import 'package:logindemo/models/address_model.dart';

class CityBottomSheetWidget extends StatefulWidget {
  const CityBottomSheetWidget({Key? key}) : super(key: key);
  @override
  State<CityBottomSheetWidget> createState() => _CityBottomSheetWidgetState();
}

class _CityBottomSheetWidgetState extends State<CityBottomSheetWidget> {
  var indexProvince;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                  var item = Get.put(ProvinceController()).address.value?.data;
                  indexProvince = item?.indexWhere((element) =>
                      element.level1Id ==
                      Get.put(ProvinceController()).idProvinceSelected);
                  return ListView.builder(
                    itemCount: controller
                        .address.value?.data?[indexProvince].level2S?.length,
                    itemBuilder: (context, index) {
                      var item = controller
                          .address.value?.data?[indexProvince].level2S?[index];
                      return GestureDetector(
                        onTap: () {
                          controller.updateSeletedCity(
                              item?.name, item?.level2Id);
                          Navigator.of(context).pop();
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
              )
              // ListView(
              //   children: arr
              //       .map(
              //         (e) => Padding(
              //           padding: const EdgeInsets.all(15.0),
              //           child: Text('${e}'),
              //         ),
              //       )
              //       .toList(),
              // ),
              ),
        ],
      ),
    );
  }
}
