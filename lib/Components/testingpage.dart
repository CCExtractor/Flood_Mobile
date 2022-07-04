import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Api/feed_api.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({Key? key}) : super(key: key);

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  @override


  @override
  void initState() {

    FeedsApi.listAllFeedsAndRules(context: context);
    super.initState();
  }
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, model, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(model.RssFeedsList[index].id),
              );
            },
            itemCount: model.RssFeedsList.length,
          );
        });
  }
}
