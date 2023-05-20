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

class RSSFeedHomePage extends StatefulWidget {
  final int index;

  const RSSFeedHomePage({Key? key, required this.index}) : super(key: key);
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

  final _feedformKey = GlobalKey<FormState>();
  final _browseformKey = GlobalKey<FormState>();
  final _rulesformKey = GlobalKey<FormState>();

  bool isNewBrowseSelected = false;
  bool isUpdateFeedSelected = false;
  bool isUpdatedRuleSelected = false;
  bool isNewSelected = false;
  bool useAsBasePath = false;
  bool startOnLoad = false;
  bool isbrowseFeedsContentSelected = false;

  bool isNewApplicableFeedSelected = false;
  bool isNewDownloadRules = false;

  final searchTermController = TextEditingController();
  final labelController = TextEditingController();
  final urlController = TextEditingController();
  final intervalController = TextEditingController();
  final existingFeedsController = TextEditingController();
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
            color: ThemeProvider.theme(widget.index).primaryColorLight,
          ),
          child: ContainedTabBarView(
            key: Key('Tab view'),
            tabs: [
              Tab(key: Key('Feeds Tab'), text: "Feeds"),
              Tab(key: Key('Download Rules Tab'), text: "Download Rules"),
            ],
            tabBarProperties: TabBarProperties(
              indicatorColor:
                  ThemeProvider.theme(widget.index).textTheme.bodyLarge?.color,
              indicatorWeight: 3.0,
              indicatorPadding: EdgeInsets.only(left: 12.0, right: 12.0),
            ),
            views: [
              SingleChildScrollView(
                child: Container(
                  color: ThemeProvider.theme(widget.index).primaryColorLight,
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
                              color: ThemeProvider.theme(widget.index)
                                  .textTheme
                                  .bodyLarge
                                  ?.color),
                        ),
                      ),
                      (model.rssFeedsList.isNotEmpty)
                          ? Container(
                              key: Key("Feeds are fetched"),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ThemeProvider.theme(widget.index)
                                        .disabledColor),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                color: ThemeProvider.theme(widget.index)
                                    .primaryColorLight,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: model.rssFeedsList.length,
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
                                                        .rssFeedsList[index]
                                                        .label
                                                        .toString()),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(model.rssFeedsList[index]
                                                              .count !=
                                                          null
                                                      ? model
                                                              .rssFeedsList[
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
                                                          .rssFeedsList[index]
                                                          .id
                                                          .toString();
                                                      urlController.text = model
                                                          .rssFeedsList[index]
                                                          .url
                                                          .toString();
                                                      labelController.text =
                                                          model
                                                              .rssFeedsList[
                                                                  index]
                                                              .label
                                                              .toString();
                                                      intervalController.text =
                                                          model
                                                              .rssFeedsList[
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
                                                                .rssFeedsList[
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
                                          Text(model.rssFeedsList[index].interval! / 60 > 24 &&
                                                  (model.rssFeedsList[index].interval! / 60)
                                                          .toString()
                                                          .split('.')[1] ==
                                                      "0"
                                              ? (((model.rssFeedsList[index].interval! / 60) / 24)
                                                      .toString()
                                                      .split('.')[0] +
                                                  ' Days')
                                              : model.rssFeedsList[index].interval! / 60 < 24 &&
                                                      model.rssFeedsList[index].interval! / 60 >
                                                          1 &&
                                                      (model.rssFeedsList[index].interval! / 60)
                                                              .toString()
                                                              .split('.')[1] ==
                                                          "0"
                                                  ? ((model.rssFeedsList[index].interval! / 60))
                                                          .toString()
                                                          .split('.')[0] +
                                                      ' Hours'
                                                  : model.rssFeedsList[index]
                                                          .interval
                                                          .toString() +
                                                      ' Minutes'),
                                          SizedBox(width: 10),
                                          Text(model.rssFeedsList[index].url
                                                      .toString()
                                                      .length >
                                                  25
                                              ? model.rssFeedsList[index].url
                                                      .toString()
                                                      .substring(0, 25) +
                                                  '...'
                                              : model.rssFeedsList[index].url
                                                  .toString()),
                                        ]),
                                      ),
                                      (index < model.rssFeedsList.length - 1)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Container(
                                                height: 1,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: ThemeProvider.theme(
                                                          widget.index)
                                                      .dividerColor,
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
                              color: ThemeProvider.theme(widget.index)
                                  .primaryColorLight,
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
                                            color: ThemeProvider.theme(
                                                    widget.index)
                                                .textTheme
                                                .bodyLarge
                                                ?.color),
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
                            backgroundColor: ThemeProvider.theme(widget.index)
                                .colorScheme
                                .secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
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
                          ? Form(
                              key: _feedformKey,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: TextFormField(
                                        key: Key('Label textformfield'),
                                        style: TextStyle(
                                          color:
                                              ThemeProvider.theme(widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                        ),
                                        controller: labelController,
                                        decoration: InputDecoration(
                                          labelText: 'Label',
                                          hintText: 'Label',
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.theme(
                                                      widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "You must specify a label.";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: TextFormField(
                                            key: Key('Interval textformfield'),
                                            controller: intervalController,
                                            style: TextStyle(
                                              color: ThemeProvider.theme(
                                                      widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                            ),
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                labelText: 'Interval',
                                                hintText: 'Interval',
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: ThemeProvider.theme(
                                                            widget.index)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.color),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                errorMaxLines: 2),
                                            validator: (value) {
                                              if (!RegExp(r'^[0-9]+$')
                                                  .hasMatch(value!)) {
                                                return "The interval must be a positive number.";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              DropdownButtonFormField2(
                                                key: Key(
                                                    'Interval type dropdown'),
                                                decoration: InputDecoration(
                                                  //Add isDense true and zero Padding.
                                                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextFormField Button become clickable, and also the dropdown menu open under The whole TextFormField Button.
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
                                                      color:
                                                          ThemeProvider.theme(
                                                                  widget.index)
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.color),
                                                ),
                                                value: "Minutes",
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: ThemeProvider.theme(
                                                          widget.index)
                                                      .textTheme
                                                      .bodyLarge
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
                                                  color: ThemeProvider.theme(
                                                          widget.index)
                                                      .primaryColorLight,
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
                                                  return null;
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
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: TextFormField(
                                        key: Key('Url textformfield'),
                                        controller: urlController,
                                        style: TextStyle(
                                          color:
                                              ThemeProvider.theme(widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'URL',
                                          hintText: 'URL',
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.theme(
                                                      widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color),
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
                                        validator: (value) {
                                          if (!RegExp(
                                                r"^(http|https):\/\/[^\s/$.?#]+.[^\s]*$",
                                              ).hasMatch(value!) ||
                                              value.isEmpty) {
                                            return "You must specify a valid feed URL.";
                                          }
                                          return null;
                                        },
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
                                                backgroundColor: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
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
                                                if (_feedformKey.currentState!
                                                        .validate() ==
                                                    true) {
                                                  setState(() {
                                                    if (isUpdateFeedSelected ==
                                                        false) {
                                                      FeedsApi.addFeeds(
                                                        type: "feed",
                                                        id: "43",
                                                        label: labelController
                                                            .text,
                                                        feedurl:
                                                            urlController.text,
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

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            addFeedSnackbar);
                                                    FeedsApi
                                                        .listAllFeedsAndRules(
                                                            context: context);
                                                    if (isUpdateFeedSelected) {
                                                      UpdateFeedApi.updateFeed(
                                                          type: "feed",
                                                          id: updateFeedId,
                                                          label: labelController
                                                              .text,
                                                          feedurl: urlController
                                                              .text,
                                                          context: context,
                                                          interval: int.parse(
                                                              intervalController
                                                                  .text),
                                                          count: 1);
                                                      FeedsApi
                                                          .listAllFeedsAndRules(
                                                              context: context);
                                                    }
                                                  });
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    ThemeProvider.theme(
                                                            widget.index)
                                                        .primaryColorDark,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
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
                            color: ThemeProvider.theme(widget.index)
                                .textTheme
                                .bodyLarge
                                ?.color),
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
                                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextFormField Button become clickable, and also the dropdown menu open under The whole TextFormField Button.
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: ThemeProvider.theme(widget.index)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                                    size: 25,
                                  ),
                                  //Add more decoration as you want here
                                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                ),
                                isExpanded: true,
                                hint: Text(
                                  'Select Feed',
                                  style: TextStyle(
                                      color: ThemeProvider.theme(widget.index)
                                          .textTheme
                                          .bodyLarge
                                          ?.color),
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: ThemeProvider.theme(widget.index)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
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
                                  color: ThemeProvider.theme(widget.index)
                                      .primaryColorLight,
                                ),
                                items: feedlabelgetter(model.rssFeedsList)
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
                                  return null;
                                },
                                onChanged: (value) {
                                  isbrowseFeedsContentSelected = true;
                                  browsefeedSelected = value.toString();
                                  FeedsContentsApi.listAllFeedsContents(
                                      context: context,
                                      id: feedidgetter(
                                          browsefeedSelected.toString(),
                                          model.rssFeedsList));
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
                                          child: TextFormField(
                                            style: TextStyle(
                                              color: ThemeProvider.theme(
                                                      widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                            ),
                                            controller: searchTermController,
                                            decoration: InputDecoration(
                                              labelText: 'Search Term',
                                              hintText: 'Search Term',
                                              labelStyle: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: ThemeProvider.theme(
                                                          widget.index)
                                                      .textTheme
                                                      .bodyLarge
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
                                                            .rssFeedsContentsList
                                                            .length;
                                                    i++) {
                                                  if (model
                                                      .rssFeedsContentsList[i]
                                                      .title
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(
                                                          searchTermController
                                                              .text
                                                              .toLowerCase())) {
                                                    magnetUrlController.text =
                                                        model
                                                            .rssFeedsContentsList[
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
                                                  backgroundColor:
                                                      ThemeProvider.theme(
                                                              widget.index)
                                                          .primaryColorLight,
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
                                                                        color: ThemeProvider.theme(widget.index)
                                                                            .textTheme
                                                                            .bodyLarge
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
                                                                                ThemeProvider.theme(widget.index).textTheme.bodyLarge?.color,
                                                                          ),
                                                                          decoration:
                                                                              InputDecoration(
                                                                            prefixIcon:
                                                                                Icon(
                                                                              Icons.link,
                                                                              color: ThemeProvider.theme(widget.index).textTheme.bodyLarge?.color,
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
                                                                              color: ThemeProvider.theme(widget.index).textTheme.bodyLarge?.color,
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
                                                                  color: ThemeProvider.theme(
                                                                          widget
                                                                              .index)
                                                                      .primaryColorLight,
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          25,
                                                                      horizontal:
                                                                          20),
                                                                  child: Form(
                                                                    key:
                                                                        _feedformKey,
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
                                                                        TextFormField(
                                                                          controller:
                                                                              directoryController,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ThemeProvider.theme(widget.index).textTheme.bodyLarge?.color,
                                                                          ),
                                                                          decoration:
                                                                              InputDecoration(
                                                                            prefixIcon:
                                                                                Icon(
                                                                              Icons.folder,
                                                                              color: ThemeProvider.theme(widget.index).textTheme.bodyLarge?.color,
                                                                            ),
                                                                            labelText:
                                                                                'Destination',
                                                                            hintText:
                                                                                'Destination',
                                                                            labelStyle:
                                                                                TextStyle(fontFamily: 'Montserrat', color: ThemeProvider.theme(widget.index).textTheme.bodyLarge?.color),
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
                                                                          activeColor:
                                                                              ThemeProvider.theme(widget.index).primaryColorDark,
                                                                          tileColor:
                                                                              ThemeProvider.theme(widget.index).primaryColorLight,
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
                                                                          activeColor:
                                                                              ThemeProvider.theme(widget.index).primaryColorDark,
                                                                          tileColor:
                                                                              ThemeProvider.theme(widget.index).primaryColorLight,
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
                                                                          activeColor:
                                                                              ThemeProvider.theme(widget.index).primaryColorDark,
                                                                          tileColor:
                                                                              ThemeProvider.theme(widget.index).primaryColorLight,
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
                                                                              backgroundColor: ThemeProvider.theme(widget.index).primaryColorDark,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(14.0),
                                                                              ),
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
                                                backgroundColor:
                                                    ThemeProvider.theme(
                                                            widget.index)
                                                        .primaryColorDark,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
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
                                      color: ThemeProvider.theme(widget.index)
                                          .primaryColorLight,
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount:
                                          model.rssFeedsContentsList.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            (model.rssFeedsContentsList[index]
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
                                                                      model.rssFeedsContentsList[index].title.toString().length <
                                                                              38
                                                                          ? model
                                                                              .rssFeedsContentsList[
                                                                                  index]
                                                                              .title
                                                                              .toString()
                                                                          : model.rssFeedsContentsList[index].title.toString().substring(0, 38) +
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
                                                              model.rssFeedsContentsList
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
                  color: ThemeProvider.theme(widget.index).primaryColorLight,
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
                              color: ThemeProvider.theme(widget.index)
                                  .textTheme
                                  .bodyLarge
                                  ?.color),
                        ),
                      ),
                      (model.rssRulesList.isNotEmpty)
                          ? Container(
                              key: Key("Rules Displayed"),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ThemeProvider.theme(widget.index)
                                        .disabledColor),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                color: ThemeProvider.theme(widget.index)
                                    .primaryColorLight,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: model.rssRulesList.length,
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
                                                        .rssRulesList[index]
                                                        .label
                                                        .toString()),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(model.rssRulesList[index]
                                                              .count !=
                                                          null
                                                      ? model
                                                              .rssRulesList[
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
                                                      color:
                                                          ThemeProvider.theme(
                                                                  widget.index)
                                                              .primaryColor,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        "Tags: " +
                                                            model
                                                                .rssRulesList[
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
                                                              .rssRulesList[
                                                                  index]
                                                              .label
                                                              .toString();
                                                      matchpatternController
                                                              .text =
                                                          model
                                                              .rssRulesList[
                                                                  index]
                                                              .match
                                                              .toString();
                                                      excludepatternController
                                                              .text =
                                                          model
                                                              .rssRulesList[
                                                                  index]
                                                              .exclude
                                                              .toString();
                                                      destinationController
                                                              .text =
                                                          model
                                                              .rssRulesList[
                                                                  index]
                                                              .destination
                                                              .toString();
                                                      tagsController.text =
                                                          model
                                                              .rssRulesList[
                                                                  index]
                                                              .tags[0]
                                                              .toString();
                                                      useAsBasePath = model
                                                          .rssRulesList[index]
                                                          .isBasePath;
                                                      startOnLoad = model
                                                          .rssRulesList[index]
                                                          .startOnLoad;
                                                      DeleteFeedOrRulesApi
                                                          .deleteFeedsOrRules(
                                                              context: context,
                                                              id: model
                                                                  .rssRulesList[
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
                                                                .rssRulesList[
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
                                          Text(model.rssRulesList[index].match
                                                      .toString()
                                                      .length >
                                                  10
                                              ? "Match: " +
                                                  model
                                                      .rssRulesList[index].match
                                                      .toString()
                                                      .substring(0, 10) +
                                                  "..."
                                              : "Match: " +
                                                  model
                                                      .rssRulesList[index].match
                                                      .toString()),
                                          SizedBox(width: 10),
                                          Text(model.rssRulesList[index].exclude
                                                      .toString()
                                                      .length >
                                                  10
                                              ? "Exclude: " +
                                                  model.rssRulesList[index]
                                                      .exclude
                                                      .toString()
                                                      .substring(0, 10) +
                                                  '...'
                                              : "Exclude: " +
                                                  model.rssRulesList[index]
                                                      .exclude
                                                      .toString()),
                                        ]),
                                      ),
                                      (index < model.rssRulesList.length - 1)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Container(
                                                height: 1,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: ThemeProvider.theme(
                                                          widget.index)
                                                      .dividerColor,
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
                              color: ThemeProvider.theme(widget.index)
                                  .primaryColorLight,
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
                                            color: ThemeProvider.theme(
                                                    widget.index)
                                                .textTheme
                                                .bodyLarge
                                                ?.color),
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
                            backgroundColor: ThemeProvider.theme(widget.index)
                                .colorScheme
                                .secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
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
                              child: Form(
                                key: _rulesformKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: TextFormField(
                                        key: Key('Rules label textformfield'),
                                        controller: labelRulesController,
                                        style: TextStyle(
                                          color:
                                              ThemeProvider.theme(widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Label',
                                          hintText: 'Label',
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.theme(
                                                      widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "You must specify a label.";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DropdownButtonFormField2(
                                          decoration: InputDecoration(
                                            //Add isDense true and zero Padding.
                                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextFormField Button become clickable, and also the dropdown menu open under The whole TextFormField Button.
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: ThemeProvider.theme(
                                                      widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
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
                                                color: ThemeProvider.theme(
                                                        widget.index)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.color),
                                          ),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: ThemeProvider.theme(
                                                    widget.index)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
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
                                            color: ThemeProvider.theme(
                                                    widget.index)
                                                .primaryColorLight,
                                          ),
                                          items: feedlabelgetter(
                                                  model.rssFeedsList)
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
                                            return null;
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
                                                        model.rssFeedsList));
                                          },
                                          onSaved: (value) {
                                            applicableFeedSelected =
                                                value.toString();
                                          },
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 150,
                                            child: TextFormField(
                                              key: Key(
                                                  'Match pattern textformfield'),
                                              controller:
                                                  matchpatternController,
                                              style: TextStyle(
                                                color: ThemeProvider.theme(
                                                        widget.index)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.color,
                                              ),
                                              decoration: InputDecoration(
                                                  labelText: 'Match Pattern',
                                                  hintText: 'RegEx',
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color:
                                                          ThemeProvider.theme(
                                                                  widget.index)
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.color),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  errorMaxLines: 2),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Invalid regular expression.";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 150,
                                            child: TextFormField(
                                              key: Key(
                                                  'Exclude pattern textformfield'),
                                              controller:
                                                  excludepatternController,
                                              style: TextStyle(
                                                color: ThemeProvider.theme(
                                                        widget.index)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.color,
                                              ),
                                              decoration: InputDecoration(
                                                labelText: 'Exclude Pattern',
                                                hintText: 'RegEx',
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: ThemeProvider.theme(
                                                            widget.index)
                                                        .textTheme
                                                        .bodyLarge
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
                                      child: TextFormField(
                                        key: Key(
                                            'Torrent destination textformfield'),
                                        controller: destinationController,
                                        style: TextStyle(
                                          color:
                                              ThemeProvider.theme(widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.folder,
                                            color: ThemeProvider.theme(
                                                    widget.index)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.search,
                                              color: ThemeProvider.theme(
                                                      widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                            ),
                                            onPressed: () {},
                                          ),
                                          labelText: 'Torrent Destination',
                                          hintText: 'Destination',
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.theme(
                                                      widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: TextFormField(
                                        key: Key('Apply tags textformfield'),
                                        controller: tagsController,
                                        style: TextStyle(
                                          color:
                                              ThemeProvider.theme(widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.tag,
                                            color: ThemeProvider.theme(
                                                    widget.index)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: ThemeProvider.theme(
                                                      widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                            ),
                                            onPressed: () {},
                                          ),
                                          labelText: 'Apply Tags',
                                          hintText: 'Tags',
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.theme(
                                                      widget.index)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color),
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
                                                backgroundColor:
                                                    ThemeProvider.theme(
                                                            widget.index)
                                                        .colorScheme
                                                        .secondary,
                                                child: Icon(
                                                  Icons.home_rounded,
                                                  color: ThemeProvider.theme(
                                                          widget.index)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color,
                                                ),
                                              ),
                                            ),
                                            label: Text(
                                              'Use as Base Path',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 13,
                                                  color: ThemeProvider.theme(
                                                          widget.index)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color),
                                            ),
                                            labelPadding: EdgeInsets.only(
                                                top: 4,
                                                bottom: 4,
                                                left: 2,
                                                right: 10),
                                            selected: useAsBasePath,
                                            selectedColor: ThemeProvider.theme(
                                                    widget.index)
                                                .primaryColorDark,
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
                                            key: Key(
                                                'starts on load filterchip'),
                                            backgroundColor: Colors.grey,
                                            avatar: Container(
                                              height: 30,
                                              width: 30,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    ThemeProvider.theme(
                                                            widget.index)
                                                        .colorScheme
                                                        .secondary,
                                                child: Icon(
                                                  Icons.download_rounded,
                                                  color: ThemeProvider.theme(
                                                          widget.index)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color,
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
                                                  color: ThemeProvider.theme(
                                                          widget.index)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color),
                                            ),
                                            selected: startOnLoad,
                                            selectedColor: ThemeProvider.theme(
                                                    widget.index)
                                                .primaryColorDark,
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
                                                backgroundColor: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
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
                                                if (_rulesformKey.currentState!
                                                        .validate() ==
                                                    true) {
                                                  setState(() {
                                                    isNewDownloadRules = true;
                                                    RulesApi.addRules(
                                                      type: "rule",
                                                      label:
                                                          labelRulesController
                                                              .text,
                                                      feedIDs: [
                                                        feedidgetter(
                                                                applicableFeedSelected
                                                                    .toString(),
                                                                model
                                                                    .rssFeedsList)
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
                                                      tags: [
                                                        tagsController.text
                                                      ],
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

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            addRuleSnackbar);
                                                    FeedsApi
                                                        .listAllFeedsAndRules(
                                                            context: context);
                                                  });
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    ThemeProvider.theme(
                                                            widget.index)
                                                        .primaryColorDark,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
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
    String feedId = "test";
    for (int i = 0; i < newmodel.length; i++) {
      if (newmodel[i].label.toString() == newlabel) {
        feedId = newmodel[i].id.toString();
      }
    }
    return feedId;
  }

  List feedlabelgetter(List<FeedsAndRulesModel> newmodel) {
    List feedslabel = [];
    for (int i = 0; i < newmodel.length; i++) {
      feedslabel.add(newmodel[i].label);
    }
    return feedslabel;
  }
}
