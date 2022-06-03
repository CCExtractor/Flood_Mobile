import 'package:flutter/material.dart';
import '../Constants/theme_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class RSSFeedHomePage extends StatefulWidget {
  @override
  State<RSSFeedHomePage> createState() => _RSSFeedHomePageState();
}

class _RSSFeedHomePageState extends State<RSSFeedHomePage> with TickerProviderStateMixin{
  final List<String> intervalunits = [
    'Minutes',
    'Hours',
    'Days',
  ];

  final List<String> browsefeedlist = [
    'http://www.thebibleanimated.com/Feeds/Torrent.xml',
    'http://www.thebibleanimated.com/Feeds/Torrent.xml',
  ];
  late TabController _tabController;
  String? selectedValue;
  String? browsefeedSelected;

  final _formKey = GlobalKey<FormState>();
  final _browseformKey = GlobalKey<FormState>();
  final _applicablefeedformKey = GlobalKey<FormState>();


  bool isNewBrowseSelected = false;
  bool isNewSelected = false;

  bool isNewApplicableFeedSelected = false;
  bool isNewDownloadRules= false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
    _tabController.animateTo(2);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              bottomOpacity: 0.0,
              elevation: 0.0,
              backgroundColor: ThemeProvider.theme.primaryColorLight,
              automaticallyImplyLeading: false,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: "Feed"),
                      Tab(text: "Download Rules")
                    ],
                    indicatorColor: ThemeProvider.theme.textTheme.bodyText1?.color,
                    indicatorPadding: EdgeInsets.only(left: 12.0, right: 12.0),
                    indicatorWeight: 3,
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
            SingleChildScrollView(
              child: Container(
                color: ThemeProvider.theme.primaryColorLight,
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      style: TextStyle(
                        color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Existing Feeds',
                        hintText: 'No feeds defined.',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            color: ThemeProvider.theme.textTheme.bodyText1?.color),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                                color: ThemeProvider.theme.textTheme.bodyText1?.color,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Label',
                                hintText: 'Label',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: ThemeProvider.theme.textTheme.bodyText1?.color),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 150,
                                child: TextField(
                                  style: TextStyle(
                                    color: ThemeProvider
                                        .theme.textTheme.bodyText1?.color,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Interval',
                                    hintText: 'Interval',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: ThemeProvider
                                            .theme.textTheme.bodyText1?.color),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                child: Form(
                                  key: _formKey,
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
                                          //Add more decoration as you want here
                                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                        ),
                                        isExpanded: true,
                                        hint: Text(
                                          'Interval Unit',
                                          style: TextStyle(color: ThemeProvider.theme.textTheme.bodyText1?.color),
                                        ),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: ThemeProvider.theme.textTheme.bodyText1?.color,
                                        ),
                                        buttonHeight: 58,
                                        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                        dropdownDecoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(5),
                                          color: ThemeProvider.theme.primaryColorLight,
                                        ),
                                        items: intervalunits
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
                                            return 'Please select a unit';
                                          }
                                        },
                                        onChanged: (value) {
                                          //Do something when changing the item if you want.
                                        },
                                        onSaved: (value) {
                                          selectedValue = value.toString();
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
                              style: TextStyle(
                                color:
                                ThemeProvider.theme.textTheme.bodyText1?.color,
                              ),
                              decoration: InputDecoration(
                                labelText: 'URL',
                                hintText: 'URL',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: ThemeProvider
                                        .theme.textTheme.bodyText1?.color),
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
                                        borderRadius: BorderRadius.circular(5.0),
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
                                padding: const EdgeInsets.only(top: 10.0, left: 20),
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
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      primary: ThemeProvider.theme.primaryColorDark,
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
                                  color: ThemeProvider.theme.textTheme.bodyText1?.color,
                                  size: 25,
                                ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Select Feed',
                                style: TextStyle(color: ThemeProvider.theme.textTheme.bodyText1?.color),
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: ThemeProvider.theme.textTheme.bodyText1?.color,
                              ),
                              buttonHeight: 58,
                              buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: ThemeProvider.theme.primaryColorLight,
                              ),
                              items: browsefeedlist
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
                                //Do something when changing the item if you want.
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

                //Download Rules TabView Screen

                SingleChildScrollView(
                  child: Container(
                    color: ThemeProvider.theme.primaryColorLight,
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          style: TextStyle(
                            color: ThemeProvider.theme.textTheme.bodyText1?.color,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Existing Rules',
                            hintText: 'No rules defined.',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.theme.textTheme.bodyText1?.color),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
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
                                  style: TextStyle(
                                    color: ThemeProvider.theme.textTheme.bodyText1?.color,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Label',
                                    hintText: 'Label',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: ThemeProvider.theme.textTheme.bodyText1?.color),
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
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: ThemeProvider.theme.textTheme.bodyText1?.color,
                                            size: 25,
                                          ),
                                          //Add more decoration as you want here
                                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                        ),
                                        isExpanded: true,
                                        hint: Text(
                                          'Applicable Feed',
                                          style: TextStyle(color: ThemeProvider.theme.textTheme.bodyText1?.color),
                                        ),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: ThemeProvider.theme.textTheme.bodyText1?.color,
                                        ),
                                        buttonHeight: 58,
                                        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                        dropdownDecoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(5),
                                          color: ThemeProvider.theme.primaryColorLight,
                                        ),
                                        items: browsefeedlist
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
                                          //Do something when changing the item if you want.
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 150,
                                      child: TextField(
                                        style: TextStyle(
                                          color: ThemeProvider
                                              .theme.textTheme.bodyText1?.color,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Match Pattern',
                                          hintText: 'RegEx',
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider
                                                  .theme.textTheme.bodyText1?.color),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      child: TextField(
                                        style: TextStyle(
                                          color: ThemeProvider
                                              .theme.textTheme.bodyText1?.color,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Exclude Pattern',
                                          hintText: 'RegEx',
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider
                                                  .theme.textTheme.bodyText1?.color),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
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
                                  style: TextStyle(
                                    color:
                                    ThemeProvider.theme.textTheme.bodyText1?.color,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.folder,
                                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.search,
                                          color: ThemeProvider.theme.textTheme.bodyText1?.color,),
                                         onPressed: () {  },
                                      ),
                                    labelText: 'Torrent Destination',
                                    hintText: 'Destination',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: ThemeProvider
                                            .theme.textTheme.bodyText1?.color),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: TextField(
                                  style: TextStyle(
                                    color:
                                    ThemeProvider.theme.textTheme.bodyText1?.color,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.tag,
                                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.keyboard_arrow_down,
                                        color: ThemeProvider.theme.textTheme.bodyText1?.color,),
                                      onPressed: () {  },
                                    ),
                                    labelText: 'Torrent Destination',
                                    hintText: 'Destination',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: ThemeProvider
                                            .theme.textTheme.bodyText1?.color),
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
                                            isNewDownloadRules = true;
                                            print(isNewDownloadRules);
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
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
                                    padding: const EdgeInsets.only(top: 10.0, left: 20),
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
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          primary: ThemeProvider.theme.primaryColorDark,
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
            ),
          ),
    );
  }
}
