import 'dart:convert';
import 'package:flood_mobile/Model/download_rate_model.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Services/byte_to_gbmb_converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:provider/provider.dart';

class EventHandlerApi {
  //Sets the transfer rate if the event returned is TRANSFER_SUMMARY_DIFF_CHANGE
  static void setTransferRate({SSEModel model, BuildContext context}) {
    String data = model.data;
    if (data != '[]') {
      String upSpeed = '0';
      String downSpeed = '0';
      List<dynamic> dat = json.decode(data);
      List<RateModel> rateList = [];
      for (var i in dat) {
        rateList.add(RateModel.fromJson(i));
      }
      for (RateModel model in rateList) {
        if (model.path == '/downRate') {
          downSpeed = byteToGbMbKbConverter(byte: model.value.toDouble());
        } else if (model.path == '/upRate') {
          upSpeed = byteToGbMbKbConverter(byte: model.value.toDouble());
        }
      }
      print('RATE');
      print(model.event);
      print(upSpeed);
      print(downSpeed);
      Provider.of<HomeProvider>(context, listen: false)
          .setSpeed(upSpeed, downSpeed);
    }
  }
}
