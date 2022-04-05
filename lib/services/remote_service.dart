import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logindemo/models/address_model.dart';
import 'package:logindemo/models/detail_model.dart';
import 'package:logindemo/models/infor_model.dart';
import 'package:logindemo/models/lnglat_model.dart';

class RemotesServices {
  static var client = http.Client();
  static Future<String> fetchLogin(String name, String password) async {
    Map<String, String> body = {'username': name, 'password': password};
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json"
    };
    var response = await client.post(
      Uri.parse(
          'https://dev.annam-gourmet.com/rest/V1/integration/customer/token'),
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      var jsonString = json.decode(response.body);
      return jsonString;
      // return movieModelFromJson(jsonString);
    } else {
      return 'null';
    }
  }

  static Future<InforModel> fetchInfor(String? token) async {
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
      "Authorization": "Bearer ${token}",
    };
    var response = await client.get(
      Uri.parse('https://dev.annam-gourmet.com/rest/V1/customers/me'),
      headers: headers,
    );
    print('status code ${response.statusCode}');
    if (response.statusCode == 200) {
      InforModel jsonString = inforModelFromJson(response.body);
      return jsonString;
      // return movieModelFromJson(jsonString);
    } else {
      return InforModel();
    }
  }

  static Future<AddressModel> fetchAddress() async {
    var response = await client.get(
      Uri.parse(
          'https://raw.githubusercontent.com/daohoangson/dvhcvn/master/data/dvhcvn.json'),
    );
    if (response.statusCode == 200) {
      AddressModel jsonString = addressModelFromJson(response.body);
      return jsonString;
    } else {
      return AddressModel();
    }
  }

  static Future<LngLatModel> fetchLngLat(String? fullAddress) async {
    var response = await client.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?address=${fullAddress}&key=AIzaSyAw6pevzOGDTD_XirlQ8H5Xysuz8pkFjy4'),
    );
    if (response.statusCode == 200) {
      LngLatModel jsonString = lngLatModelFromJson(response.body);
      return jsonString;
    } else {
      return LngLatModel();
    }
  }

  static Future<DetailModel> fetchLocation(double lng, double lat) async {
    var response = await client.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&key=AIzaSyAw6pevzOGDTD_XirlQ8H5Xysuz8pkFjy4'),
    );
    if (response.statusCode == 200) {
      DetailModel jsonString = detailModelFromJson(response.body);
      return jsonString;
    } else {
      return DetailModel();
    }
  }
}
