import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flood_mobile/Model/single_feed_and_response_model.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Api/feed_api.dart';
import '../Api/rules_api.dart';
import '../Constants/theme_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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

  String? selectedValue;
  String? browsefeedSelected;

  final _formKey = GlobalKey<FormState>();
  final _browseformKey = GlobalKey<FormState>();
  final _applicablefeedformKey = GlobalKey<FormState>();

  bool isNewBrowseSelected = false;
  bool isNewSelected = false;
  bool useAsBasePath = false;
  bool startOnLoad = false;

  bool isNewApplicableFeedSelected = false;
  bool isNewDownloadRules = false;

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
    return Consumer<HomeProvider>(builder: (context, model, child) {
      return Container(
        height: 800,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
          color: ThemeProvider.theme.primaryColorLight,
        ),
        child: ContainedTabBarView(
          tabs: [
            Tab(text: "Feeds"),
            Tab(text: "Download Rules"),
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
                            color:
                                ThemeProvider.theme.textTheme.bodyText1?.color),
                      ),
                    ),
                    (model.RssFeedsList.isNotEmpty)
                        ? Container(
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
                                      minLeadingWidth: 0.1,
                                      minVerticalPadding: 0.1,
                                      horizontalTitleGap: 0.1,
                                      visualDensity: VisualDensity(
                                          horizontal: -0.1, vertical: -0.1),
                                      title: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(model.RssFeedsList[index].label),
                                          SizedBox(width: 10),
                                          Text("0 matches"),
                                          SizedBox(width: 80),
                                          Container(
                                            width: 30,
                                            child: IconButton(
                                              icon: Icon(Icons.edit, size: 18),
                                              onPressed: () {},
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete, size: 18),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                      subtitle: Row(children: [
                                        Text(model.RssFeedsList[index].interval
                                                .toString() +
                                            ' Minutes'),
                                        SizedBox(width: 10),
                                        Text(model.RssFeedsList[index].url
                                                    .length >
                                                25
                                            ? model.RssFeedsList[index].url
                                                    .substring(0, 25) +
                                                '...'
                                            : model.RssFeedsList[index].url),
                                      ]),
                                    ),
                                    (index < model.RssFeedsList.length - 1)
                                        ? const Divider()
                                        : Container(
                                            height: 8,
                                          ),
                                  ],
                                );
                              },
                            ),
                          )
                        : Container(
                            height: 60,
                            width: double.infinity,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "No feeds defined.",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        color: ThemeProvider
                                            .theme.textTheme.bodyText1?.color),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 230.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isNewSelected = true;
                            print(isNewSelected);
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
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: TextField(
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
                                        borderRadius: BorderRadius.circular(8),
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
                                        controller: intervalController,
                                        style: TextStyle(
                                          color: ThemeProvider
                                              .theme.textTheme.bodyText1?.color,
                                        ),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Interval',
                                          hintText: 'Interval',
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.theme
                                                  .textTheme.bodyText1?.color),
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
                                              decoration: InputDecoration(
                                                //Add isDense true and zero Padding.
                                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
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
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: ThemeProvider.theme
                                                    .textTheme.bodyText1?.color,
                                              ),
                                              buttonHeight: 58,
                                              buttonPadding:
                                                  const EdgeInsets.only(
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
                                              items: intervalunits
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
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
                                                //Do something when changing the item if you want.
                                              },
                                              onSaved: (value) {
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
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Container(
                                        width: 150,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              isNewSelected = true;
                                              print(isNewSelected);
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
                                                  fontWeight: FontWeight.w600),
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
                                              FeedsApi.addFeeds(
                                                type: "feed",
                                                id: "43",
                                                label: labelController.text,
                                                feedurl: urlController.text,
                                                interval: int.parse(
                                                    intervalController.text),
                                                count: 10,
                                                context: context,
                                              );
                                              FeedsApi.listAllFeedsAndRules(
                                                  context: context);
                                              existingFeedsController.text =
                                                  model.RssFeedsList[0].id;
                                              isNewSelected = true;
                                              print(isNewSelected);
                                            });
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
                                                  fontWeight: FontWeight.w600),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Form(
                        key: _browseformKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButtonFormField2(
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
                                browsefeedSelected = value.toString();
                              },
                              onSaved: (value) {
                                browsefeedSelected = value.toString();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                color: ThemeProvider.theme.primaryColorLight,
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (model.RssRulesList.isNotEmpty)
                        ? Container(
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
                                          Text(model.RssRulesList[index].label),
                                          SizedBox(width: 10),
                                          Text("1 matches"),
                                          SizedBox(width: 30),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(12),
                                                topLeft: Radius.circular(12),
                                                bottomLeft: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12),
                                              ),
                                              color: ThemeProvider
                                                  .theme.primaryColor,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Tags: " +
                                                    model.RssRulesList[index]
                                                        .tags[0],
                                                style: TextStyle(fontSize: 12),
                                              ),
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
                                                  onPressed: () {},
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete,
                                                    size: 18),
                                                onPressed: () {},
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      subtitle: Row(children: [
                                        Text(model.RssRulesList[index].match
                                                    .length >
                                                10
                                            ? "Match: " +
                                                model.RssRulesList[index].match
                                                    .substring(0, 10) +
                                                "..."
                                            : "Match: " +
                                                model
                                                    .RssRulesList[index].match),
                                        SizedBox(width: 10),
                                        Text(model.RssRulesList[index].exclude
                                                    .length >
                                                10
                                            ? "Exclude: " +
                                                model
                                                    .RssRulesList[index].exclude
                                                    .substring(0, 10) +
                                                '...'
                                            : "Exclude: " +
                                                model.RssRulesList[index]
                                                    .exclude),
                                      ]),
                                    ),
                                    (index < model.RssRulesList.length - 1)
                                        ? const Divider()
                                        : Container(
                                            height: 8,
                                          ),
                                  ],
                                );
                              },
                            ),
                          )
                        : Container(
                            height: 60,
                            width: double.infinity,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "No rules defined.",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        color: ThemeProvider
                                            .theme.textTheme.bodyText1?.color),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 230.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isNewDownloadRules = true;
                            print(isNewDownloadRules);
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
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: TextField(
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
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _applicablefeedformKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color,
                                            size: 25,
                                          ),
                                          //Add more decoration as you want here
                                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                        ),
                                        isExpanded: true,
                                        hint: Text(
                                          'Applicable Feed',
                                          style: TextStyle(
                                              color: ThemeProvider.theme
                                                  .textTheme.bodyText1?.color),
                                        ),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: ThemeProvider
                                              .theme.textTheme.bodyText1?.color,
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
                                        items:
                                            feedlabelgetter(model.RssFeedsList)
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
                                          browsefeedSelected = value.toString();
                                        },
                                        onSaved: (value) {
                                          browsefeedSelected = value.toString();
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
                                          controller: matchpatternController,
                                          style: TextStyle(
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color,
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
                                          controller: excludepatternController,
                                          style: TextStyle(
                                            color: ThemeProvider.theme.textTheme
                                                .bodyText1?.color,
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
                                          color: ThemeProvider
                                              .theme.textTheme.bodyText1?.color,
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
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: TextField(
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
                                          color: ThemeProvider
                                              .theme.textTheme.bodyText1?.color,
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
                                        borderRadius: BorderRadius.circular(8),
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
                                        backgroundColor: Colors.grey,
                                        avatar: Container(
                                          height: 30,
                                          width: 30,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                ThemeProvider.theme.accentColor,
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
                                              color: ThemeProvider.theme
                                                  .textTheme.bodyText1?.color),
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
                                        backgroundColor: Colors.grey,
                                        avatar: Container(
                                          height: 30,
                                          width: 30,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                ThemeProvider.theme.accentColor,
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
                                              color: ThemeProvider.theme
                                                  .textTheme.bodyText1?.color),
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
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Container(
                                        width: 150,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              isNewDownloadRules = true;
                                              print(isNewDownloadRules);
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
                                                  fontWeight: FontWeight.w600),
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
                                              print(isNewDownloadRules);
                                              RulesApi.addRules(
                                                type: "rule",
                                                id: "43",
                                                label:
                                                    labelRulesController.text,
                                                feedIDs: [
                                                  feedidgetter(
                                                          browsefeedSelected
                                                              .toString(),
                                                          model.RssFeedsList)
                                                      .toString()
                                                ],
                                                field: "test",
                                                matchpattern:
                                                    matchpatternController.text,
                                                excludepattern:
                                                    excludepatternController
                                                        .text,
                                                destination:
                                                    destinationController.text,
                                                tags: [tagsController.text],
                                                startOnLoad: startOnLoad,
                                                isBasePath: useAsBasePath,
                                                count: 1,
                                                context: context,
                                              );
                                            });
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
                                                  fontWeight: FontWeight.w600),
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
          onChange: (index) => print(index),
        ),
      );
    });
  }

  String feedidgetter(String newlabel, List<FeedsAndRulesModel> newmodel) {
    String feed_id = "test";
    print(newlabel);
    for (int i = 0; i < newmodel.length; i++) {
      if (newmodel[i].label.toString() == newlabel) {
        feed_id = newmodel[i].id;
      }
    }
    print(feed_id);
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
