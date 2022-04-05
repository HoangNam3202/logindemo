import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logindemo/controller/address_controller.dart';
import 'package:logindemo/models/address_model.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key? key, String? type}) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  List<int> arr = [1, 2, 3, 4, 5, 1, 2, 3, 4, 5];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<Level2>? cityData =
        Get.put(ProvinceController()).address.value?.data?[0].level2S;
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
                  'Pick a province',
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
                    itemCount: controller.address.value?.data?.length,
                    itemBuilder: (context, index) {
                      var item = controller.address.value?.data?[index];
                      return GestureDetector(
                        onTap: () {
                          controller.updateSeletedProvince(
                            item?.name,
                            item?.level1Id,
                          );
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
