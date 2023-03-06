import 'package:clipboard/clipboard.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flood_mobile/Api/feeds_contents_api.dart';
import 'package:flood_mobile/Api/update_feed_api.dart';
import 'package:flood_mobile/Model/single_feed_and_response_model.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flood_mobile/Components/flood_snackbar.dart';
import 'package:provider/provider.dart';
import '../Api/delete_feeds_and_rules.dart';
import '../Api/feed_api.dart';
import '../Api/rules_api.dart';
import '../Api/torrent_api.dart';
import '../Constants/theme_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../Provider/client_provider.dart';
import 'add_torrent_sheet.dart';

class RSSFeedHomePage extends StatefulWidget {
  @override
  State<RSSFeedHomePage> createState() => _RSSFeedHomePageState();
}

class _RSSFeedHomePageState extends State<RSSFeedHomePage>
    with TickerProviderStateMixin {
  final List<String> intervalunits = [
    'Minutes',
    'Hours',
    'Days',
  ];
  bool useAdBasePath = false;
  bool completed = false;
  bool sequentialDownload = false;

  final directoryController = TextEditingController();
  TextEditingController magnetUrlController = new TextEditingController();

  String updateFeedId = "";

  String? selectedValue;
  String? browsefeedSelected;
  String? applicableFeedSelected;

  final _formKey = GlobalKey<FormState>();
  final _browseformKey = GlobalKey<FormState>();
  final _applicablefeedformKey = GlobalKey<FormState>();

  bool isNewBrowseSelected = false;
  bool isUpdateFeedSelected = false;
  bool isUpdatedRuleSelected = false;
  bool isNewSelected = false;
  bool useAsBasePath = false;
  bool startOnLoad = false;
  bool isbrowseFeedsContentSelected = false;

  bool isNewApplicableFeedSelected = false;
  bool isNewDownloadRules = false;

  // editing the search term
  final searchTermController = TextEditingController();

  // adding new feed
  final labelController = TextEditingController();
  final urlController = TextEditingController();
  final intervalController = TextEditingController();

  // editing existing rule name c
  final existingFeedsController = TextEditingController();

  // adding new rules
  final labelRulesController = TextEditingController();
  final matchpatternController = TextEditingController();
  final excludepatternController = TextEditingController();
  final destinationController = TextEditingController();
  final tagsController = TextEditingController();

  @override
  void initState() {
    FeedsApi.listAllFeedsAndRules(context: context);
    super.initState();
  }
  
  // clearing the fields in Feeds tabs after tappping save button
  void clearFeedsFields() {
    labelController.clear();
    urlController.clear();
    intervalController.clear();
  }

  void clearDownloadRulesFields() {
    labelRulesController.clear();
    matchpatternController.clear();
    excludepatternController.clear();
    destinationController.clear();
    tagsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientSettingsProvider>(
        builder: (context, clientModel, child) {
      return Consumer<HomeProvider>(builder: (context, model, child) {
        return Container(
          height: 750,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            color: ThemeProvider.theme.primaryColorLight,
          ),
          child: ContainedTabBarView(
            key: Key('Tab view'),
            tabs: [
              Tab(key: Key('Feeds Tab'), text: "Feeds"),
              Tab(key: Key('Download Rules Tab'), text: "Download Rules"),
            ],
            tabBarProperties: TabBarProperties(
              indicatorColor: ThemeProvider.theme.textTheme.bodyText1?.color,
              indicatorWeight: 3.0,
              indicatorPadding: EdgeInsets.only(left: 12.0, right: 12.0),
            ),
            views: [
              SingleChildScrollView(
                child: Container(
                  color: ThemeProvider.theme.primaryColorLight,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Existing Feeds",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: ThemeProvider
                                  .theme.textTheme.bodyText1?.color),
                        ),
                      ),
                      (model.RssFeedsList.isNotEmpty)
                          ? Container(
                              key: Key("Feeds are fetched"),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white38),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                color: ThemeProvider.theme.primaryColorLight,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: model.RssFeedsList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        key: Key("Feed displayed"),
                                        minLeadingWidth: 0.1,
                                        minVerticalPadding: 0.1,
                                        horizontalTitleGap: 0.1,
                                        visualDensity: VisualDensity(
                                            horizontal: -3, vertical: -3),
                                        title: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(model
                                                        .RssFeedsList[index]
                                                        .label
                                                        .toString()),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(model.RssFeedsList[index]
                                                              .count !=
                                                          null
                                                      ? model
                                                              .RssFeedsList[
                                                                  index]
                                                              .count
                                                              .toString() +
                                                          " matches"
                                                      : "0 matches"),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 30,
                                                  child: IconButton(
                                                    icon: Icon(Icons.edit,
                                                        size: 18),
                                                    onPressed: () {
                                                      isNewSelected = true;
                                                      isUpdateFeedSelected =
                                                          true;
                                                      updateFeedId = model
                                                          .RssFeedsList[index]
                                                          .id
                                                          .toString();
                                                      urlController.text = model
                                                          .RssFeedsList[index]
                                                          .url
                                                          .toString();
                                                      labelController.text =
                                                          model
                                                              .RssFeedsList[
                                                                  index]
                                                              .label
                                                              .toString();
                                                      intervalController.text =
                                                          model
                                                              .RssFeedsList[
                                                                  index]
                                                              .interval
                                                              .toString();
                                                    },
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.delete,
                                                      size: 18),
                                                  onPressed: () {
                                                    DeleteFeedOrRulesApi
                                                        .deleteFeedsOrRules(
                                                            context: context,
                                                            id: model
                                                                .RssFeedsList[
                                                                    index]
                                                                .id
                                                                .toString());
                                                    FeedsApi
                                                        .listAllFeedsAndRules(
                                                            context: context);
                                                    final deleteFeedSnackbar =
                                                        addFloodSnackBar(
                                                            SnackbarType
                                                                .information,
                                                            'Feed deleted successfully',
                                                            'Dismiss');

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .clearSnackBars();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      deleteFeedSnackbar,
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        subtitle: Row(children: [
                                          Text(model.RssFeedsList[index].interval! / 60 > 24 &&
                                                  (model.RssFeedsList[index].interval! / 60)
                                                          .toString()
                                                          .split('.')[1] ==
                                                      "0"
                                              ? (((model.RssFeedsList[index].interval! / 60) / 24)
                                                      .toString()
                                                      .split('.')[0] +
                                                  ' Days')
                                              : model.RssFeedsList[index].interval! / 60 < 24 &&
                                                      model.RssFeedsList[index].interval! / 60 >
                                                          1 &&
                                                      (model.RssFeedsList[index].interval! / 60)
                                                              .toString()
                                                              .split('.')[1] ==
                                                          "0"
                                                  ? ((model.RssFeedsList[index].interval! / 60))
                                                          .toString()
                                                          .split('.')[0] +
                                                      ' Hours'
                                                  : model.RssFeedsList[index]
                                                          .interval
                                                          .toString() +
                                                      ' Minutes'),
                                          SizedBox(width: 10),
                                          Text(model.RssFeedsList[index].url
                                                      .toString()
                                                      .length >
                                                  25
                                              ? model.RssFeedsList[index].url
                                                      .toString()
                                                      .substring(0, 25) +
                                                  '...'
                                              : model.RssFeedsList[index].url
                                                  .toString()),
                                        ]),
                                      ),
                                      (index < model.RssFeedsList.length - 1)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Container(
                                                height: 1,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.white12,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 8,
                                            ),
                                    ],
                                  );
                                },
                              ),
                            )
                          : Container(
                              key:
                                  Key('No existing feeds displaying container'),
                              height: 60,
                              width: double.infinity,
                              color: ThemeProvider.theme.primaryColorLight,
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "No feeds defined.",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 230.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isNewSelected = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            primary: ThemeProvider.theme.accentColor,
                          ),
                          child: Center(
                            child: Text(
                              "New",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      (isNewSelected)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: TextField(
                                      key: Key('Label textfield'),
                                      style: TextStyle(
                                        color: ThemeProvider
                                            .theme.textTheme.bodyText1?.color,
                                      ),
                                      controller: labelController,
                                      decoration: InputDecoration(
                                        labelText: 'Label',
                                        hintText: 'Label',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 150,
                                        child: TextField(
                                          key: Key('Interval textfield'),
                                          controller: intervalController,
                                          style: TextStyle(
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color,
                                          ),
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'Interval',
                                            hintText: 'Interval',
                                            labelStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: ThemeProvider
                                                    .theme
                                                    .textTheme
                                                    .bodyText1
                                                    ?.color),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              DropdownButtonFormField2(
                                                key: Key(
                                                    'Interval type dropdown'),
                                                decoration: InputDecoration(
                                                  //Add isDense true and zero Padding.
                                                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  //Add more decoration as you want here
                                                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                ),
                                                isExpanded: true,
                                                hint: Text(
                                                  'Interval Unit',
                                                  style: TextStyle(
                                                      color: ThemeProvider
                                                          .theme
                                                          .textTheme
                                                          .bodyText1
                                                          ?.color),
                                                ),
                                                value: "Minutes",
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: ThemeProvider
                                                      .theme
                                                      .textTheme
                                                      .bodyText1
                                                      ?.color,
                                                ),
                                                buttonHeight: 58,
                                                buttonPadding:
                                                    const EdgeInsets.only(
                                                        left: 20, right: 10),
                                                dropdownDecoration:
                                                    BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12
                                                          .withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: ThemeProvider
                                                      .theme.primaryColorLight,
                                                ),
                                                items: intervalunits
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select a unit';
                                                  }
                                                },
                                                onChanged: (value) {
                                                  if (value.toString() ==
                                                      "Hours") {
                                                    intervalController
                                                        .text = (int.parse(
                                                                intervalController
                                                                    .text) *
                                                            60)
                                                        .toString();
                                                  }
                                                  if (value.toString() ==
                                                      "Days") {
                                                    intervalController
                                                        .text = (int.parse(
                                                                intervalController
                                                                    .text) *
                                                            24 *
                                                            60)
                                                        .toString();
                                                  }
                                                  selectedValue =
                                                      value.toString();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: TextField(
                                      key: Key('Url textfield'),
                                      controller: urlController,
                                      style: TextStyle(
                                        color: ThemeProvider
                                            .theme.textTheme.bodyText1?.color,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'URL',
                                        hintText: 'URL',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        suffix: GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Icon(Icons.paste,
                                                key: Key('Url paste icon')),
                                          ),
                                          onTap: () {
                                            FlutterClipboard.paste()
                                                .then((value) {
                                              setState(() {
                                                urlController.text = value;
                                              });
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                          width: 150,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                isNewSelected = false;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              primary: Colors.red,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 20),
                                        child: Container(
                                          width: 150,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if (isUpdateFeedSelected ==
                                                    false) {
                                                  FeedsApi.addFeeds(
                                                    type: "feed",
                                                    id: "43",
                                                    label: labelController.text,
                                                    feedurl: urlController.text,
                                                    interval: int.parse(
                                                        intervalController
                                                            .text),
                                                    count: 0,
                                                    context: context,
                                                  );
                                                }
                                                final addFeedSnackbar =
                                                    addFloodSnackBar(
                                                        SnackbarType
                                                            .information,
                                                        'New Feed added successfully',
                                                        'Dismiss');

                                                ScaffoldMessenger.of(context)
                                                    .clearSnackBars();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        addFeedSnackbar);
                                                FeedsApi.listAllFeedsAndRules(
                                                    context: context);
                                                if (isUpdateFeedSelected) {
                                                  UpdateFeedApi.updateFeed(
                                                      type: "feed",
                                                      id: updateFeedId,
                                                      label:
                                                          labelController.text,
                                                      feedurl:
                                                          urlController.text,
                                                      context: context,
                                                      interval: int.parse(
                                                          intervalController
                                                              .text),
                                                      count: 1);
                                                  FeedsApi.listAllFeedsAndRules(
                                                      context: context);
                                                }
                                              });
                                              clearFeedsFields();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              primary: ThemeProvider
                                                  .theme.primaryColorDark,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Save",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      (isNewSelected)
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      Text(
                        "Browse Feeds",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color:
                                ThemeProvider.theme.textTheme.bodyText1?.color),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Form(
                          key: _browseformKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButtonFormField2(
                                key: Key('Browse feeds dropdown'),
                                decoration: InputDecoration(
                                  //Add isDense true and zero Padding.
                                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: ThemeProvider
                                        .theme.textTheme.bodyText1?.color,
                                    size: 25,
                                  ),
                                  //Add more decoration as you want here
                                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                ),
                                isExpanded: true,
                                hint: Text(
                                  'Select Feed',
                                  style: TextStyle(
                                      color: ThemeProvider
                                          .theme.textTheme.bodyText1?.color),
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: ThemeProvider
                                      .theme.textTheme.bodyText1?.color,
                                ),
                                buttonHeight: 58,
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: ThemeProvider.theme.primaryColorLight,
                                ),
                                items: feedlabelgetter(model.RssFeedsList)
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a feed';
                                  }
                                },
                                onChanged: (value) {
                                  isbrowseFeedsContentSelected = true;
                                  browsefeedSelected = value.toString();
                                  FeedsContentsApi.listAllFeedsContents(
                                      context: context,
                                      id: feedidgetter(
                                          browsefeedSelected.toString(),
                                          model.RssFeedsList));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      (isbrowseFeedsContentSelected)
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 20),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            style: TextStyle(
                                              color: ThemeProvider.theme
                                                  .textTheme.bodyText1?.color,
                                            ),
                                            controller: searchTermController,
                                            decoration: InputDecoration(
                                              labelText: 'Search Term',
                                              hintText: 'Search Term',
                                              labelStyle: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: ThemeProvider
                                                      .theme
                                                      .textTheme
                                                      .bodyText1
                                                      ?.color),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Container(
                                            width: 100,
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                for (int i = 0;
                                                    i <
                                                        model
                                                            .RssFeedsContentsList
                                                            .length;
                                                    i++) {
                                                  if (model
                                                      .RssFeedsContentsList[i]
                                                      .title
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(
                                                          searchTermController
                                                              .text
                                                              .toLowerCase())) {
                                                    magnetUrlController.text =
                                                        model
                                                            .RssFeedsContentsList[
                                                                i]
                                                            .urls[0];
                                                  }
                                                }
                                                directoryController.text =
                                                    clientModel.clientSettings
                                                        .directoryDefault;
                                                showModalBottomSheet(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(15),
                                                      topLeft:
                                                          Radius.circular(15),
                                                    ),
                                                  ),
                                                  isScrollControlled: true,
                                                  context: context,
                                                  backgroundColor: ThemeProvider
                                                      .theme.primaryColorLight,
                                                  builder: (context) {
                                                    return ListView(
                                                        shrinkWrap: true,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 20),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 20,
                                                                      left: 20,
                                                                      bottom:
                                                                          5),
                                                                  child: Text(
                                                                    "Selected Magnet Link",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: ThemeProvider
                                                                            .theme
                                                                            .textTheme
                                                                            .bodyText1
                                                                            ?.color),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          20.0,
                                                                      right:
                                                                          20),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              magnetUrlController,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ThemeProvider.theme.textTheme.bodyText1?.color,
                                                                          ),
                                                                          decoration:
                                                                              InputDecoration(
                                                                            prefixIcon:
                                                                                Icon(
                                                                              Icons.link,
                                                                              color: ThemeProvider.theme.textTheme.bodyText1?.color,
                                                                            ),
                                                                            suffix:
                                                                                GestureDetector(
                                                                              child: Icon(Icons.paste),
                                                                              onTap: () {
                                                                                FlutterClipboard.paste().then((value) {
                                                                                  setState(() {
                                                                                    magnetUrlController = TextEditingController(text: value);
                                                                                  });
                                                                                });
                                                                              },
                                                                            ),
                                                                            labelText:
                                                                                'Torrent',
                                                                            hintText:
                                                                                'Torrent URL or Magnet Link',
                                                                            labelStyle:
                                                                                TextStyle(
                                                                              fontFamily: 'Montserrat',
                                                                              color: ThemeProvider.theme.textTheme.bodyText1?.color,
                                                                            ),
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                          validator:
                                                                              (String? value) {
                                                                            if (value == null ||
                                                                                (value.isEmpty)) {
                                                                              return 'Field cannot be empty';
                                                                            }
                                                                            return null;
                                                                          },
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  color: ThemeProvider
                                                                      .theme
                                                                      .primaryColorLight,
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          25,
                                                                      horizontal:
                                                                          20),
                                                                  child: Form(
                                                                    key:
                                                                        _formKey,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: <
                                                                          Widget>[
                                                                        TextField(
                                                                          controller:
                                                                              directoryController,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ThemeProvider.theme.textTheme.bodyText1?.color,
                                                                          ),
                                                                          decoration:
                                                                              InputDecoration(
                                                                            prefixIcon:
                                                                                Icon(
                                                                              Icons.folder,
                                                                              color: ThemeProvider.theme.textTheme.bodyText1?.color,
                                                                            ),
                                                                            labelText:
                                                                                'Destination',
                                                                            hintText:
                                                                                'Destination',
                                                                            labelStyle:
                                                                                TextStyle(fontFamily: 'Montserrat', color: ThemeProvider.theme.textTheme.bodyText1?.color),
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        CheckboxListTile(
                                                                          activeColor: ThemeProvider
                                                                              .theme
                                                                              .primaryColorDark,
                                                                          tileColor: ThemeProvider
                                                                              .theme
                                                                              .primaryColorLight,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                          title:
                                                                              Text(
                                                                            'Use as Base Path',
                                                                            style:
                                                                                TextStyle(fontSize: 14),
                                                                          ),
                                                                          value:
                                                                              useAdBasePath,
                                                                          onChanged:
                                                                              (bool? value) {
                                                                            setState(() {
                                                                              useAdBasePath = value ?? false;
                                                                            });
                                                                          },
                                                                        ),
                                                                        CheckboxListTile(
                                                                          activeColor: ThemeProvider
                                                                              .theme
                                                                              .primaryColorDark,
                                                                          tileColor: ThemeProvider
                                                                              .theme
                                                                              .primaryColorLight,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                          title:
                                                                              Text(
                                                                            'Sequential Download',
                                                                            style:
                                                                                TextStyle(fontSize: 14),
                                                                          ),
                                                                          value:
                                                                              sequentialDownload,
                                                                          onChanged:
                                                                              (bool? value) {
                                                                            setState(() {
                                                                              sequentialDownload = value ?? false;
                                                                            });
                                                                          },
                                                                        ),
                                                                        CheckboxListTile(
                                                                          activeColor: ThemeProvider
                                                                              .theme
                                                                              .primaryColorDark,
                                                                          tileColor: ThemeProvider
                                                                              .theme
                                                                              .primaryColorLight,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                          title:
                                                                              Text(
                                                                            'Completed',
                                                                            style:
                                                                                TextStyle(fontSize: 14),
                                                                          ),
                                                                          value:
                                                                              completed,
                                                                          onChanged:
                                                                              (bool? value) {
                                                                            setState(() {
                                                                              completed = value ?? false;
                                                                            });
                                                                          },
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.06,
                                                                          decoration:
                                                                              BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                                                          child:
                                                                              ElevatedButton(
                                                                            onPressed:
                                                                                () async {
                                                                              //The file has been chosen
                                                                              TorrentApi.addTorrentMagnet(magnetUrl: magnetUrlController.text, destination: directoryController.text, isBasePath: useAdBasePath, isSequential: sequentialDownload, isCompleted: completed, context: context);
                                                                              Navigator.pop(context);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              elevation: 0,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(14.0),
                                                                              ),
                                                                              primary: ThemeProvider.theme.primaryColorDark,
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                "Add Torrent",
                                                                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ]);
                                                  },
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                primary: ThemeProvider
                                                    .theme.primaryColorDark,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Download",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white38),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                      color:
                                          ThemeProvider.theme.primaryColorLight,
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount:
                                          model.RssFeedsContentsList.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            (model.RssFeedsContentsList[index]
                                                    .title
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains(
                                                        searchTermController
                                                            .text
                                                            .toLowerCase())
                                                ? Column(
                                                    children: [
                                                      ListTile(
                                                        minLeadingWidth: 0.1,
                                                        minVerticalPadding: 0.1,
                                                        horizontalTitleGap: 0.1,
                                                        visualDensity:
                                                            VisualDensity(
                                                                horizontal: -3,
                                                                vertical: -3),
                                                        title: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      model.RssFeedsContentsList[index].title.toString().length <
                                                                              38
                                                                          ? model
                                                                              .RssFeedsContentsList[
                                                                                  index]
                                                                              .title
                                                                              .toString()
                                                                          : model.RssFeedsContentsList[index].title.toString().substring(0, 38) +
                                                                              "..",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14)),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      (index <
                                                              model.RssFeedsContentsList
                                                                      .length -
                                                                  1)
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                              child: Container(
                                                                height: 1,
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white12,
                                                                ),
                                                              ),
                                                            )
                                                          : Container(
                                                              height: 8,
                                                            ),
                                                    ],
                                                  )
                                                : Container()),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  color: ThemeProvider.theme.primaryColorLight,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Existing Rules",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: ThemeProvider
                                  .theme.textTheme.bodyText1?.color),
                        ),
                      ),
                      (model.RssRulesList.isNotEmpty)
                          ? Container(
                              key: Key("Rules Displayed"),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white38),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                color: ThemeProvider.theme.primaryColorLight,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: model.RssRulesList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        minLeadingWidth: 0.1,
                                        minVerticalPadding: 0.1,
                                        horizontalTitleGap: 0.1,
                                        visualDensity: VisualDensity(
                                            horizontal: -0.1, vertical: -0.1),
                                        title: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(model
                                                        .RssRulesList[index]
                                                        .label
                                                        .toString()),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(model.RssRulesList[index]
                                                              .count !=
                                                          null
                                                      ? model
                                                              .RssRulesList[
                                                                  index]
                                                              .count
                                                              .toString() +
                                                          " matches"
                                                      : "0 matches"),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(12),
                                                        topLeft:
                                                            Radius.circular(12),
                                                        bottomLeft:
                                                            Radius.circular(12),
                                                        bottomRight:
                                                            Radius.circular(12),
                                                      ),
                                                      color: ThemeProvider
                                                          .theme.primaryColor,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        "Tags: " +
                                                            model
                                                                .RssRulesList[
                                                                    index]
                                                                .tags[0]
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  width: 30,
                                                  child: IconButton(
                                                    icon: Icon(Icons.edit,
                                                        size: 18),
                                                    onPressed: () {
                                                      isNewDownloadRules = true;
                                                      isUpdatedRuleSelected =
                                                          true;
                                                      labelRulesController
                                                              .text =
                                                          model
                                                              .RssRulesList[
                                                                  index]
                                                              .label
                                                              .toString();
                                                      matchpatternController
                                                              .text =
                                                          model
                                                              .RssRulesList[
                                                                  index]
                                                              .match
                                                              .toString();
                                                      excludepatternController
                                                              .text =
                                                          model
                                                              .RssRulesList[
                                                                  index]
                                                              .exclude
                                                              .toString();
                                                      destinationController
                                                              .text =
                                                          model
                                                              .RssRulesList[
                                                                  index]
                                                              .destination
                                                              .toString();
                                                      tagsController.text =
                                                          model
                                                              .RssRulesList[
                                                                  index]
                                                              .tags[0]
                                                              .toString();
                                                      useAsBasePath = model
                                                          .RssRulesList[index]
                                                          .isBasePath;
                                                      startOnLoad = model
                                                          .RssRulesList[index]
                                                          .startOnLoad;
                                                      DeleteFeedOrRulesApi
                                                          .deleteFeedsOrRules(
                                                              context: context,
                                                              id: model
                                                                  .RssRulesList[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                    },
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.delete,
                                                      size: 18),
                                                  onPressed: () {
                                                    DeleteFeedOrRulesApi
                                                        .deleteFeedsOrRules(
                                                            context: context,
                                                            id: model
                                                                .RssRulesList[
                                                                    index]
                                                                .id
                                                                .toString());
                                                    FeedsApi
                                                        .listAllFeedsAndRules(
                                                            context: context);
                                                    final deleteRuleSnackbar =
                                                        addFloodSnackBar(
                                                            SnackbarType
                                                                .information,
                                                            'Rule deleted successfully',
                                                            'Dismiss');

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .clearSnackBars();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      deleteRuleSnackbar,
                                                    );
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        subtitle: Row(children: [
                                          Text(model.RssRulesList[index].match
                                                      .toString()
                                                      .length >
                                                  10
                                              ? "Match: " +
                                                  model
                                                      .RssRulesList[index].match
                                                      .toString()
                                                      .substring(0, 10) +
                                                  "..."
                                              : "Match: " +
                                                  model
                                                      .RssRulesList[index].match
                                                      .toString()),
                                          SizedBox(width: 10),
                                          Text(model.RssRulesList[index].exclude
                                                      .toString()
                                                      .length >
                                                  10
                                              ? "Exclude: " +
                                                  model.RssRulesList[index]
                                                      .exclude
                                                      .toString()
                                                      .substring(0, 10) +
                                                  '...'
                                              : "Exclude: " +
                                                  model.RssRulesList[index]
                                                      .exclude
                                                      .toString()),
                                        ]),
                                      ),
                                      (index < model.RssRulesList.length - 1)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Container(
                                                height: 1,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.white12,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 8,
                                            ),
                                    ],
                                  );
                                },
                              ),
                            )
                          : Container(
                              key: Key('No rules defined'),
                              height: 60,
                              width: double.infinity,
                              color: ThemeProvider.theme.primaryColorLight,
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "No rules defined.",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 230.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isNewDownloadRules = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            primary: ThemeProvider.theme.accentColor,
                          ),
                          child: Center(
                            child: Text(
                              "New",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      (isNewDownloadRules)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: TextField(
                                      key: Key('Rules label textfield'),
                                      controller: labelRulesController,
                                      style: TextStyle(
                                        color: ThemeProvider
                                            .theme.textTheme.bodyText1?.color,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Label',
                                        hintText: 'Label',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: _applicablefeedformKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DropdownButtonFormField2(
                                          decoration: InputDecoration(
                                            //Add isDense true and zero Padding.
                                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: ThemeProvider.theme
                                                  .textTheme.bodyText1?.color,
                                              size: 25,
                                            ),
                                            //Add more decoration as you want here
                                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                          ),
                                          key: Key('applicable feed dropdown'),
                                          isExpanded: true,
                                          hint: Text(
                                            'Applicable Feed',
                                            style: TextStyle(
                                                color: ThemeProvider
                                                    .theme
                                                    .textTheme
                                                    .bodyText1
                                                    ?.color),
                                          ),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color,
                                          ),
                                          buttonHeight: 58,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 20, right: 10),
                                          dropdownDecoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: ThemeProvider
                                                .theme.primaryColorLight,
                                          ),
                                          items: feedlabelgetter(
                                                  model.RssFeedsList)
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select a feed';
                                            }
                                          },
                                          onChanged: (value) {
                                            applicableFeedSelected =
                                                value.toString();
                                            FeedsContentsApi
                                                .listAllFeedsContents(
                                                    context: context,
                                                    id: feedidgetter(
                                                        applicableFeedSelected
                                                            .toString(),
                                                        model.RssFeedsList));
                                          },
                                          onSaved: (value) {
                                            applicableFeedSelected =
                                                value.toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: TextField(
                                            key: Key('Match pattern textfield'),
                                            controller: matchpatternController,
                                            style: TextStyle(
                                              color: ThemeProvider.theme
                                                  .textTheme.bodyText1?.color,
                                            ),
                                            decoration: InputDecoration(
                                              labelText: 'Match Pattern',
                                              hintText: 'RegEx',
                                              labelStyle: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: ThemeProvider
                                                      .theme
                                                      .textTheme
                                                      .bodyText1
                                                      ?.color),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          child: TextField(
                                            key: Key(
                                                'Exclude pattern textfield'),
                                            controller:
                                                excludepatternController,
                                            style: TextStyle(
                                              color: ThemeProvider.theme
                                                  .textTheme.bodyText1?.color,
                                            ),
                                            decoration: InputDecoration(
                                              labelText: 'Exclude Pattern',
                                              hintText: 'RegEx',
                                              labelStyle: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: ThemeProvider
                                                      .theme
                                                      .textTheme
                                                      .bodyText1
                                                      ?.color),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: TextField(
                                      key: Key('Torrent destination textfield'),
                                      controller: destinationController,
                                      style: TextStyle(
                                        color: ThemeProvider
                                            .theme.textTheme.bodyText1?.color,
                                      ),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.folder,
                                          color: ThemeProvider
                                              .theme.textTheme.bodyText1?.color,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.search,
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color,
                                          ),
                                          onPressed: () {},
                                        ),
                                        labelText: 'Torrent Destination',
                                        hintText: 'Destination',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: TextField(
                                      key: Key('Apply tags textfield'),
                                      controller: tagsController,
                                      style: TextStyle(
                                        color: ThemeProvider
                                            .theme.textTheme.bodyText1?.color,
                                      ),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.tag,
                                          color: ThemeProvider
                                              .theme.textTheme.bodyText1?.color,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color,
                                          ),
                                          onPressed: () {},
                                        ),
                                        labelText: 'Apply Tags',
                                        hintText: 'Tags',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FilterChip(
                                          key: Key(
                                              'use as base path filterchip'),
                                          backgroundColor: Colors.grey,
                                          avatar: Container(
                                            height: 30,
                                            width: 30,
                                            child: CircleAvatar(
                                              backgroundColor: ThemeProvider
                                                  .theme.accentColor,
                                              child: Icon(
                                                Icons.home_rounded,
                                                color: ThemeProvider.theme
                                                    .textTheme.bodyText1?.color,
                                              ),
                                            ),
                                          ),
                                          label: Text(
                                            'Use as Base Path',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 13,
                                                color: ThemeProvider
                                                    .theme
                                                    .textTheme
                                                    .bodyText1
                                                    ?.color),
                                          ),
                                          labelPadding: EdgeInsets.only(
                                              top: 4,
                                              bottom: 4,
                                              left: 2,
                                              right: 10),
                                          selected: useAsBasePath,
                                          selectedColor: ThemeProvider
                                              .theme.primaryColorDark,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              if (selected) {
                                                useAsBasePath = true;
                                              } else {
                                                useAsBasePath = false;
                                              }
                                            });
                                          },
                                        ),
                                        FilterChip(
                                          key: Key('starts on load filterchip'),
                                          backgroundColor: Colors.grey,
                                          avatar: Container(
                                            height: 30,
                                            width: 30,
                                            child: CircleAvatar(
                                              backgroundColor: ThemeProvider
                                                  .theme.accentColor,
                                              child: Icon(
                                                Icons.download_rounded,
                                                color: ThemeProvider.theme
                                                    .textTheme.bodyText1?.color,
                                              ),
                                            ),
                                          ),
                                          labelPadding: EdgeInsets.only(
                                              top: 4,
                                              bottom: 4,
                                              left: 2,
                                              right: 35),
                                          label: Text(
                                            'Start on load',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 13,
                                                color: ThemeProvider
                                                    .theme
                                                    .textTheme
                                                    .bodyText1
                                                    ?.color),
                                          ),
                                          selected: startOnLoad,
                                          selectedColor: ThemeProvider
                                              .theme.primaryColorDark,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              if (selected) {
                                                startOnLoad = true;
                                              } else {
                                                startOnLoad = false;
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                          width: 150,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                isNewDownloadRules = false;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              primary: Colors.red,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 20),
                                        child: Container(
                                          width: 150,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                isNewDownloadRules = true;
                                                RulesApi.addRules(
                                                  type: "rule",
                                                  label:
                                                      labelRulesController.text,
                                                  feedIDs: [
                                                    feedidgetter(
                                                            applicableFeedSelected
                                                                .toString(),
                                                            model.RssFeedsList)
                                                        .toString()
                                                  ],
                                                  field: "test",
                                                  matchpattern:
                                                      matchpatternController
                                                          .text,
                                                  excludepattern:
                                                      excludepatternController
                                                          .text,
                                                  destination:
                                                      destinationController
                                                          .text,
                                                  tags: [tagsController.text],
                                                  startOnLoad: startOnLoad,
                                                  isBasePath: useAsBasePath,
                                                  count: 0,
                                                  context: context,
                                                );
                                                final addRuleSnackbar =
                                                    addFloodSnackBar(
                                                        SnackbarType
                                                            .information,
                                                        'New Rule added successfully',
                                                        'Dismiss');

                                                ScaffoldMessenger.of(context)
                                                    .clearSnackBars();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        addRuleSnackbar);
                                                FeedsApi.listAllFeedsAndRules(
                                                    context: context);
                                              });
                                              clearDownloadRulesFields();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              primary: ThemeProvider
                                                  .theme.primaryColorDark,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Save",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      (isNewDownloadRules)
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
            onChange: (index) {},
          ),
        );
      });
    });
  }

  String feedidgetter(String newlabel, List<FeedsAndRulesModel> newmodel) {
    String feed_id = "test";
    for (int i = 0; i < newmodel.length; i++) {
      if (newmodel[i].label.toString() == newlabel) {
        feed_id = newmodel[i].id.toString();
      }
    }
    return feed_id;
  }

  List feedlabelgetter(List<FeedsAndRulesModel> newmodel) {
    List feedslabel = [];
    for (int i = 0; i < newmodel.length; i++) {
      feedslabel.add(newmodel[i].label);
    }
    return feedslabel;
  }
}
