library flutter_client_sse;

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
part 'sse_event_model.dart';

class SSEClient {
  static http.Client _client;
  static Stream<SSEModel> subscribeToSSE(String url, String token) {
    //Regex to be used
    var lineRegex = RegExp(r'^([^:]*)(?::)?(?: )?(.*)?$');
    var removeEndingNewlineRegex = RegExp(r'^((?:.|\n)*)\n$');

    //Creating a instance of the SSEModel
    var currentSSEModel = SSEModel(data: '', id: '', event: '');

    // ignore: close_sinks
    StreamController<SSEModel> streamController = new StreamController();
    print("--SUBSCRIBING TO SSE---");
    while (true) {
      try {
        _client = http.Client();
        var request = new http.Request("GET", Uri.parse(url));
        request.headers["Cache-Control"] = "no-cache";
        request.headers["Accept"] = "text/event-stream";
        request.headers["Cookie"] = token;
        Future<http.StreamedResponse> response = _client.send(request);

        //Listening to the response as a stream
        response.asStream().listen((data) {
          //Applying transforms and listening to it
          data.stream
            ..transform(Utf8Decoder())
                .transform(LineSplitter())
                .listen((dataLine) {
              if (dataLine.isEmpty) {
                streamController.add(currentSSEModel);
                currentSSEModel = SSEModel(data: '', id: '', event: '');
                return;
              }
              Match match = lineRegex.firstMatch(dataLine);
              var field = match.group(1);
              if (field.isEmpty) {
                return;
              }
              var value = '';
              if (field == 'data') {
                value = dataLine.substring(
                  5,
                );
              } else {
                value = match.group(2) ?? '';
              }
              switch (field) {
                case 'event':
                  currentSSEModel.event = value;
                  break;
                case 'data':
                  currentSSEModel.data =
                      (currentSSEModel.data ?? '') + value + '\n';
                  break;
                case 'id':
                  currentSSEModel.id = value;
                  break;
                case 'retry':
                  break;
              }
            });
        });
      } catch (e) {
        print('---ERROR---');
        print(e);
        streamController.add(SSEModel(data: '', id: '', event: ''));
      }

      Future.delayed(Duration(seconds: 1), () {});
      return streamController.stream;
    }
  }

  static void unsubscribeFromSSE() {
    _client.close();
  }
}
