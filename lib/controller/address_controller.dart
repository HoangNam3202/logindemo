import 'package:get/get.dart';
import 'package:logindemo/models/address_model.dart';
import 'package:logindemo/models/detail_model.dart';
import 'package:logindemo/models/lnglat_model.dart';
import 'package:logindemo/services/remote_service.dart';

class ProvinceController extends GetxController {
  Rx<AddressModel?> address = AddressModel().obs;
  Rx<LngLatModel?> lngLat = LngLatModel().obs;
  String provinceSelected = 'Select a province ...';
  String citySelected = 'Select a city ...';
  String districtSelected = 'Select a district ...';
  String searchInput = '';
  String idProvinceSelected = '';
  String idCitySelected = '';
  double? lat = 10.7930968;
  double? lng = 106.6902951;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAddress();
  }

  void fetchAddress() async {
    var addressFetch = await RemotesServices.fetchAddress();
    if (addressFetch != null) {
      address.value = addressFetch;
    }
    update();
  }

  fetchLocation(double lng, double lat) async {
    var locationFetch = await RemotesServices.fetchLocation(lng, lat);
    List<String>? addressArr =
        locationFetch.results?[0].formattedAddress?.split(',');
    print(addressArr);
    provinceSelected = addressArr![3];
    citySelected = addressArr![2];
    districtSelected = addressArr![1];
    searchInput = addressArr![0];
    update();
  }

  fetchLngLat() async {
    String fullAddress = provinceSelected +
        ',' +
        citySelected +
        ',' +
        districtSelected +
        ',' +
        searchInput;
    var lnglatFetch = await RemotesServices.fetchLngLat(fullAddress);
    if (lnglatFetch != null) {
      lngLat.value = lnglatFetch;
      lng = lnglatFetch.results?[0].geometry?.location?.lng;
      lat = lnglatFetch.results?[0].geometry?.location?.lat;
      print('lngLat : ${lat} + ${lng}');
    }
    update();
  }

  void updateSearchInput(String? input) async {
    searchInput = input!;
    update();
  }

  void updateSeletedProvince(String? provinceString, String? idString) async {
    idProvinceSelected = idString!;
    provinceSelected = provinceString!;
    update();
  }

  void updateSeletedCity(String? cityString, String? idString) async {
    citySelected = cityString!;
    idCitySelected = idString!;
    update();
  }

  void updateSeletedDistrict(String? districtString) async {
    districtSelected = districtString!;
    update();
  }
}
