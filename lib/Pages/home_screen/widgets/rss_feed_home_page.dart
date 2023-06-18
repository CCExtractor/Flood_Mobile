import 'package:clipboard/clipboard.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flood_mobile/Api/client_api.dart';
import 'package:flood_mobile/Api/delete_feeds_and_rules.dart';
import 'package:flood_mobile/Api/feed_api.dart';
import 'package:flood_mobile/Api/feeds_contents_api.dart';
import 'package:flood_mobile/Api/rules_api.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Api/update_feed_api.dart';
import 'package:flood_mobile/Blocs/client_settings_bloc/client_settings_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Model/single_feed_and_response_model.dart';
import 'package:flood_mobile/Pages/widgets/flood_snackbar.dart';
import 'package:flood_mobile/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RSSFeedHomePage extends StatefulWidget {
  final int themeIndex;

  const RSSFeedHomePage({Key? key, required this.themeIndex}) : super(key: key);
  @override
  State<RSSFeedHomePage> createState() => _RSSFeedHomePageState();
}

class _RSSFeedHomePageState extends State<RSSFeedHomePage>
    with TickerProviderStateMixin {
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
    startOnLoad = false;
    useAsBasePath = false;
    applicableFeedSelected = null;
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final List<String> intervalunits = [
      l10n.feeds_time_minutes,
      l10n.feeds_time_hours,
      l10n.feeds_time_days,
    ];
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        return Container(
          height: 750,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            color: ThemeBloc.theme(widget.themeIndex).primaryColorLight,
          ),
          child: ContainedTabBarView(
            key: Key('Tab view'),
            tabs: [
              Tab(key: Key('Feeds Tab'), text: l10n.feeds_heading),
              Tab(key: Key('Download Rules Tab'), text: l10n.rules_heading),
            ],
            tabBarProperties: TabBarProperties(
              indicatorColor:
                  ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
              indicatorWeight: 3.0,
              indicatorPadding: EdgeInsets.only(left: 12.0, right: 12.0),
            ),
            views: [
              SingleChildScrollView(
                child: Container(
                  color: ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          l10n.feeds_existing_feeds,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: ThemeBloc.theme(widget.themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color),
                        ),
                      ),
                      (state.rssFeedsList.isNotEmpty)
                          ? Container(
                              key: Key("Feeds are fetched"),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ThemeBloc.theme(widget.themeIndex)
                                        .disabledColor),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                color: ThemeBloc.theme(widget.themeIndex)
                                    .primaryColorLight,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: state.rssFeedsList.length,
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
                                                    child: Text(state
                                                        .rssFeedsList[index]
                                                        .label
                                                        .toString()),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(state.rssFeedsList[index]
                                                              .count !=
                                                          null
                                                      ? state
                                                              .rssFeedsList[
                                                                  index]
                                                              .count
                                                              .toString() +
                                                          " ${l10n.torrent_matches_text}"
                                                      : "0 ${l10n.torrent_matches_text}"),
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
                                                      updateFeedId = state
                                                          .rssFeedsList[index]
                                                          .id
                                                          .toString();
                                                      urlController.text = state
                                                          .rssFeedsList[index]
                                                          .url
                                                          .toString();
                                                      labelController.text =
                                                          state
                                                              .rssFeedsList[
                                                                  index]
                                                              .label
                                                              .toString();
                                                      intervalController.text =
                                                          state
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
                                                            id: state
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
                                                            l10n.feeds_delete_snackbar,
                                                            l10n.button_dismiss);

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
                                          Text(state.rssFeedsList[index].interval! / 60 > 24 &&
                                                  (state.rssFeedsList[index].interval! / 60)
                                                          .toString()
                                                          .split('.')[1] ==
                                                      "0"
                                              ? (((state.rssFeedsList[index].interval! / 60) / 24)
                                                      .toString()
                                                      .split('.')[0] +
                                                  ' ${l10n.feeds_time_days}')
                                              : state.rssFeedsList[index].interval! / 60 < 24 &&
                                                      state.rssFeedsList[index].interval! / 60 >
                                                          1 &&
                                                      (state.rssFeedsList[index].interval! / 60)
                                                              .toString()
                                                              .split('.')[1] ==
                                                          "0"
                                                  ? ((state.rssFeedsList[index].interval! / 60))
                                                          .toString()
                                                          .split('.')[0] +
                                                      ' ${l10n.feeds_time_hours}'
                                                  : state.rssFeedsList[index]
                                                          .interval
                                                          .toString() +
                                                      ' ${l10n.feeds_time_minutes}'),
                                          SizedBox(width: 10),
                                          Text(state.rssFeedsList[index].url
                                                      .toString()
                                                      .length >
                                                  25
                                              ? state.rssFeedsList[index].url
                                                      .toString()
                                                      .substring(0, 25) +
                                                  '...'
                                              : state.rssFeedsList[index].url
                                                  .toString()),
                                        ]),
                                      ),
                                      (index < state.rssFeedsList.length - 1)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Container(
                                                height: 1,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: ThemeBloc.theme(
                                                          widget.themeIndex)
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
                              color: ThemeBloc.theme(widget.themeIndex)
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
                                        l10n.feeds_no_feeds_defined,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                            color: ThemeBloc.theme(
                                                    widget.themeIndex)
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
                            backgroundColor: ThemeBloc.theme(widget.themeIndex)
                                .colorScheme
                                .secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              l10n.button_new,
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
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                        ),
                                        controller: labelController,
                                        decoration: InputDecoration(
                                          labelText: l10n.feeds_label,
                                          hintText: l10n.feeds_label,
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeBloc.theme(
                                                      widget.themeIndex)
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
                                            return context
                                                .l10n.feeds_label_validator;
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
                                              color: ThemeBloc.theme(
                                                      widget.themeIndex)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                            ),
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                labelText: l10n.feeds_interval,
                                                hintText: l10n.feeds_interval,
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: ThemeBloc.theme(
                                                            widget.themeIndex)
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
                                                return l10n
                                                    .feeds_interval_validator;
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
                                                  context
                                                      .l10n.feeds_interval_unit,
                                                  style: TextStyle(
                                                      color: ThemeBloc.theme(
                                                              widget.themeIndex)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.color),
                                                ),
                                                value: context
                                                    .l10n.feeds_time_minutes,
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: ThemeBloc.theme(
                                                          widget.themeIndex)
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
                                                  color: ThemeBloc.theme(
                                                          widget.themeIndex)
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
                                                    return l10n
                                                        .feeds_interval_unit_validator;
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  if (value.toString() ==
                                                      l10n.feeds_time_hours) {
                                                    intervalController
                                                        .text = (int.parse(
                                                                intervalController
                                                                    .text) *
                                                            60)
                                                        .toString();
                                                  }
                                                  if (value.toString() ==
                                                      l10n.feeds_time_days) {
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
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: l10n.feeds_url,
                                          hintText: l10n.feeds_url,
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeBloc.theme(
                                                      widget.themeIndex)
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
                                            return context
                                                .l10n.feeds_url_validator;
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
                                                  l10n.button_cancel,
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
                                              onPressed: () async {
                                                if (await ClientApi
                                                    .checkClientOnline(
                                                        context)) {
                                                  if (_feedformKey.currentState!
                                                          .validate() ==
                                                      true) {
                                                    setState(() {
                                                      if (isUpdateFeedSelected ==
                                                          false) {
                                                        FeedsApi.addFeeds(
                                                          type: "feed",
                                                          id: updateFeedId,
                                                          label: labelController
                                                              .text,
                                                          feedurl: urlController
                                                              .text,
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
                                                              l10n.feeds_add_snackbar,
                                                              l10n.button_dismiss);

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              addFeedSnackbar);
                                                      FeedsApi
                                                          .listAllFeedsAndRules(
                                                              context: context);
                                                      clearFeedsFields();
                                                      if (isUpdateFeedSelected) {
                                                        UpdateFeedApi.updateFeed(
                                                            type: "feed",
                                                            id: updateFeedId,
                                                            label:
                                                                labelController
                                                                    .text,
                                                            feedurl:
                                                                urlController
                                                                    .text,
                                                            context: context,
                                                            interval: int.parse(
                                                                intervalController
                                                                    .text),
                                                            count: 1);
                                                        FeedsApi
                                                            .listAllFeedsAndRules(
                                                                context:
                                                                    context);
                                                      }
                                                    });
                                                  }
                                                } else {
                                                  final connectionCheckSnackbar =
                                                      addFloodSnackBar(
                                                          SnackbarType.caution,
                                                          l10n.connection_check_snackbar,
                                                          l10n.button_dismiss);

                                                  ScaffoldMessenger.of(context)
                                                      .clearSnackBars();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          connectionCheckSnackbar);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    ThemeBloc.theme(
                                                            widget.themeIndex)
                                                        .primaryColorDark,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  l10n.button_save,
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
                        l10n.feeds_browse_feeds,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: ThemeBloc.theme(widget.themeIndex)
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
                                    color: ThemeBloc.theme(widget.themeIndex)
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
                                  l10n.feeds_select_feed,
                                  style: TextStyle(
                                      color: ThemeBloc.theme(widget.themeIndex)
                                          .textTheme
                                          .bodyLarge
                                          ?.color),
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: ThemeBloc.theme(widget.themeIndex)
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
                                  color: ThemeBloc.theme(widget.themeIndex)
                                      .primaryColorLight,
                                ),
                                items: feedlabelgetter(state.rssFeedsList)
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
                                    return l10n.feeds_select_feed_validator;
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
                                          state.rssFeedsList));
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
                                              color: ThemeBloc.theme(
                                                      widget.themeIndex)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                            ),
                                            controller: searchTermController,
                                            decoration: InputDecoration(
                                              labelText: l10n.feeds_search_term,
                                              hintText: l10n.feeds_search_term,
                                              labelStyle: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: ThemeBloc.theme(
                                                          widget.themeIndex)
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
                                                        state
                                                            .rssFeedsContentsList
                                                            .length;
                                                    i++) {
                                                  if (state
                                                      .rssFeedsContentsList[i]
                                                      .title
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(
                                                          searchTermController
                                                              .text
                                                              .toLowerCase())) {
                                                    magnetUrlController.text =
                                                        state
                                                            .rssFeedsContentsList[
                                                                i]
                                                            .urls[0];
                                                  }
                                                }
                                                directoryController
                                                    .text = BlocProvider.of<
                                                            ClientSettingsBloc>(
                                                        context)
                                                    .clientSettings
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
                                                      ThemeBloc.theme(
                                                              widget.themeIndex)
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
                                                                    l10n.selected_magnet_link,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: ThemeBloc.theme(widget.themeIndex)
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
                                                                                ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
                                                                          ),
                                                                          decoration:
                                                                              InputDecoration(
                                                                            prefixIcon:
                                                                                Icon(
                                                                              Icons.link,
                                                                              color: ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
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
                                                                                l10n.torrent_text,
                                                                            hintText:
                                                                                l10n.torrent_magnet_link_textfield_hint,
                                                                            labelStyle:
                                                                                TextStyle(
                                                                              fontFamily: 'Montserrat',
                                                                              color: ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
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
                                                                              return l10n.torrent_magnet_link_textfield_validator;
                                                                            }
                                                                            return null;
                                                                          },
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  color: ThemeBloc.theme(
                                                                          widget
                                                                              .themeIndex)
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
                                                                      children: <Widget>[
                                                                        TextFormField(
                                                                          controller:
                                                                              directoryController,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
                                                                          ),
                                                                          decoration:
                                                                              InputDecoration(
                                                                            prefixIcon:
                                                                                Icon(
                                                                              Icons.folder,
                                                                              color: ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
                                                                            ),
                                                                            labelText:
                                                                                l10n.textfield_destination_torrent,
                                                                            hintText:
                                                                                l10n.textfield_destination_torrent,
                                                                            labelStyle:
                                                                                TextStyle(fontFamily: 'Montserrat', color: ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color),
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
                                                                              ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                                                                          tileColor:
                                                                              ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                          title:
                                                                              Text(
                                                                            l10n.torrents_destination_base_path,
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
                                                                              ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                                                                          tileColor:
                                                                              ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                          title:
                                                                              Text(
                                                                            l10n.torrents_destination_sequential,
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
                                                                              ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                                                                          tileColor:
                                                                              ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                          title:
                                                                              Text(
                                                                            l10n.torrents_destination_completed,
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
                                                                              backgroundColor: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(14.0),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                l10n.add_torrent_button,
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
                                                    ThemeBloc.theme(
                                                            widget.themeIndex)
                                                        .primaryColorDark,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  l10n.button_download,
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
                                      border: Border.all(
                                          color:
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .disabledColor),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                      color: ThemeBloc.theme(widget.themeIndex)
                                          .primaryColorLight,
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount:
                                          state.rssFeedsContentsList.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            (state.rssFeedsContentsList[index]
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
                                                                      state.rssFeedsContentsList[index].title.toString().length <
                                                                              38
                                                                          ? state
                                                                              .rssFeedsContentsList[
                                                                                  index]
                                                                              .title
                                                                              .toString()
                                                                          : state.rssFeedsContentsList[index].title.toString().substring(0, 38) +
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
                                                              state.rssFeedsContentsList
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
                                                                  color: ThemeBloc.theme(
                                                                          widget
                                                                              .themeIndex)
                                                                      .dividerColor,
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
                  color: ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          l10n.feeds_existing_rules,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: ThemeBloc.theme(widget.themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color),
                        ),
                      ),
                      (state.rssRulesList.isNotEmpty)
                          ? Container(
                              key: Key("Rules Displayed"),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ThemeBloc.theme(widget.themeIndex)
                                        .disabledColor),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                color: ThemeBloc.theme(widget.themeIndex)
                                    .primaryColorLight,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: state.rssRulesList.length,
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
                                                    child: Text(state
                                                        .rssRulesList[index]
                                                        .label
                                                        .toString()),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(state.rssRulesList[index]
                                                              .count !=
                                                          null
                                                      ? state
                                                              .rssRulesList[
                                                                  index]
                                                              .count
                                                              .toString() +
                                                          " ${l10n.torrent_matches_text}"
                                                      : "0 ${l10n.torrent_matches_text}"),
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
                                                      color: ThemeBloc.theme(
                                                              widget.themeIndex)
                                                          .primaryColor,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        "${l10n.feeds_tags}: " +
                                                            state
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
                                                          state
                                                              .rssRulesList[
                                                                  index]
                                                              .label
                                                              .toString();
                                                      matchpatternController
                                                              .text =
                                                          state
                                                              .rssRulesList[
                                                                  index]
                                                              .match
                                                              .toString();
                                                      excludepatternController
                                                              .text =
                                                          state
                                                              .rssRulesList[
                                                                  index]
                                                              .exclude
                                                              .toString();
                                                      destinationController
                                                              .text =
                                                          state
                                                              .rssRulesList[
                                                                  index]
                                                              .destination
                                                              .toString();
                                                      tagsController.text =
                                                          state
                                                              .rssRulesList[
                                                                  index]
                                                              .tags[0]
                                                              .toString();
                                                      useAsBasePath = state
                                                          .rssRulesList[index]
                                                          .isBasePath;
                                                      startOnLoad = state
                                                          .rssRulesList[index]
                                                          .startOnLoad;
                                                      DeleteFeedOrRulesApi
                                                          .deleteFeedsOrRules(
                                                              context: context,
                                                              id: state
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
                                                            id: state
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
                                                            l10n.rules_deleted_snackbar,
                                                            l10n.button_dismiss);

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
                                          Text(state.rssRulesList[index].match
                                                      .toString()
                                                      .length >
                                                  10
                                              ? "${l10n.rules_match}: " +
                                                  state
                                                      .rssRulesList[index].match
                                                      .toString()
                                                      .substring(0, 10) +
                                                  "..."
                                              : "${l10n.rules_match}: " +
                                                  state
                                                      .rssRulesList[index].match
                                                      .toString()),
                                          SizedBox(width: 10),
                                          Text(state.rssRulesList[index].exclude
                                                      .toString()
                                                      .length >
                                                  10
                                              ? "${l10n.rules_exclude}: " +
                                                  state.rssRulesList[index]
                                                      .exclude
                                                      .toString()
                                                      .substring(0, 10) +
                                                  '...'
                                              : "${l10n.rules_exclude}: " +
                                                  state.rssRulesList[index]
                                                      .exclude
                                                      .toString()),
                                        ]),
                                      ),
                                      (index < state.rssRulesList.length - 1)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Container(
                                                height: 1,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: ThemeBloc.theme(
                                                          widget.themeIndex)
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
                              color: ThemeBloc.theme(widget.themeIndex)
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
                                        l10n.feeds_no_rules_defined,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                            color: ThemeBloc.theme(
                                                    widget.themeIndex)
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
                            backgroundColor: ThemeBloc.theme(widget.themeIndex)
                                .colorScheme
                                .secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              l10n.button_new,
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
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: l10n.rules_textfield_lable,
                                          hintText: l10n.rules_textfield_lable,
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeBloc.theme(
                                                      widget.themeIndex)
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
                                            return l10n
                                                .rules_textfield_validator;
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
                                          value: applicableFeedSelected,
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
                                              color: ThemeBloc.theme(
                                                      widget.themeIndex)
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
                                            l10n.feeds_applicable_feed,
                                            style: TextStyle(
                                                color: ThemeBloc.theme(
                                                        widget.themeIndex)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.color),
                                          ),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: ThemeBloc.theme(
                                                    widget.themeIndex)
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
                                            color: ThemeBloc.theme(
                                                    widget.themeIndex)
                                                .primaryColorLight,
                                          ),
                                          items: feedlabelgetter(
                                                  state.rssFeedsList)
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
                                              return l10n
                                                  .feeds_applicable_feed_validator;
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
                                                        state.rssFeedsList));
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
                                                color: ThemeBloc.theme(
                                                        widget.themeIndex)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.color,
                                              ),
                                              decoration: InputDecoration(
                                                  labelText:
                                                      l10n.feeds_match_pattern,
                                                  hintText: l10n.feeds_regEx,
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: ThemeBloc.theme(
                                                              widget.themeIndex)
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
                                                  return l10n
                                                      .feeds_match_pattern_validator;
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
                                                color: ThemeBloc.theme(
                                                        widget.themeIndex)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.color,
                                              ),
                                              decoration: InputDecoration(
                                                labelText:
                                                    l10n.rules_exclude_pattern,
                                                hintText: l10n.feeds_regEx,
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: ThemeBloc.theme(
                                                            widget.themeIndex)
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
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.folder,
                                            color: ThemeBloc.theme(
                                                    widget.themeIndex)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.search,
                                              color: ThemeBloc.theme(
                                                      widget.themeIndex)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                            ),
                                            onPressed: () {},
                                          ),
                                          labelText:
                                              l10n.feeds_torrent_destination,
                                          hintText: l10n
                                              .textfield_destination_torrent,
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeBloc.theme(
                                                      widget.themeIndex)
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
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.tag,
                                            color: ThemeBloc.theme(
                                                    widget.themeIndex)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: ThemeBloc.theme(
                                                      widget.themeIndex)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                            ),
                                            onPressed: () {},
                                          ),
                                          labelText: l10n.feeds_apply_tags,
                                          hintText: l10n.feeds_tags,
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeBloc.theme(
                                                      widget.themeIndex)
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
                                                    ThemeBloc.theme(
                                                            widget.themeIndex)
                                                        .colorScheme
                                                        .secondary,
                                                child: Icon(
                                                  Icons.home_rounded,
                                                  color: ThemeBloc.theme(
                                                          widget.themeIndex)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color,
                                                ),
                                              ),
                                            ),
                                            label: Text(
                                              l10n.torrents_destination_base_path,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 13,
                                                  color: ThemeBloc.theme(
                                                          widget.themeIndex)
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
                                            selectedColor: ThemeBloc.theme(
                                                    widget.themeIndex)
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
                                                    ThemeBloc.theme(
                                                            widget.themeIndex)
                                                        .colorScheme
                                                        .secondary,
                                                child: Icon(
                                                  Icons.download_rounded,
                                                  color: ThemeBloc.theme(
                                                          widget.themeIndex)
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
                                              l10n.feeds_rule_start_on_load,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 13,
                                                  color: ThemeBloc.theme(
                                                          widget.themeIndex)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color),
                                            ),
                                            selected: startOnLoad,
                                            selectedColor: ThemeBloc.theme(
                                                    widget.themeIndex)
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
                                                  l10n.button_cancel,
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
                                              onPressed: () async {
                                                if (await ClientApi
                                                    .checkClientOnline(
                                                        context)) {
                                                  if (_rulesformKey
                                                          .currentState!
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
                                                                  state
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
                                                        startOnLoad:
                                                            startOnLoad,
                                                        isBasePath:
                                                            useAsBasePath,
                                                        count: 0,
                                                        context: context,
                                                      );
                                                      final addRuleSnackbar =
                                                          addFloodSnackBar(
                                                              SnackbarType
                                                                  .information,
                                                              l10n.rules_added_snackbar,
                                                              l10n.button_dismiss);

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              addRuleSnackbar);
                                                      FeedsApi
                                                          .listAllFeedsAndRules(
                                                              context: context);
                                                      clearDownloadRulesFields();
                                                    });
                                                  }
                                                } else {
                                                  final connectionCheckSnackbar =
                                                      addFloodSnackBar(
                                                          SnackbarType.caution,
                                                          l10n.connection_check_snackbar,
                                                          l10n.button_dismiss);

                                                  ScaffoldMessenger.of(context)
                                                      .clearSnackBars();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          connectionCheckSnackbar);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    ThemeBloc.theme(
                                                            widget.themeIndex)
                                                        .primaryColorDark,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  l10n.button_save,
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
      },
    );
  }
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
