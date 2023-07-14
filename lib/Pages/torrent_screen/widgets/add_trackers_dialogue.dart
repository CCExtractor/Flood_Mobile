import 'package:flood_mobile/Api/event_handler_api.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Pages/widgets/flood_snackbar.dart';
import 'package:flood_mobile/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTrackersDialogue extends StatefulWidget {
  final List<TorrentModel> torrents;
  final List<String> trackers;
  final int themeIndex;
  const AddTrackersDialogue(
      {Key? key,
      required this.torrents,
      required this.themeIndex,
      required this.trackers})
      : super(key: key);
  @override
  State<AddTrackersDialogue> createState() => _AddTrackersDialogueState();
}

class _AddTrackersDialogueState extends State<AddTrackersDialogue>
    with TickerProviderStateMixin {
  bool _showdropdown = false;
  late TextEditingController _textController;
  int _itemsVisibleInDropdown = 1;
  List<String> _inputTrackersList = [];
  Map<String, bool> _existingTrackers = {};
  Map<String, bool> _newEnterdTrackers = {};
  late Animation _animation;
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.trackers.join(","));
    _textController.addListener(_handleControllerChanged);
    _inputTrackersList = _textController.text.split(',');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _existingTrackers =
        Map.fromIterable(widget.trackers, key: (e) => e, value: (e) => false);

    _existingTrackers.forEach((key, value) {
      if (_inputTrackersList.contains(key)) {
        _existingTrackers[key] = true;
      }
    });
    _itemsVisibleInDropdown = _existingTrackers.length >= 4 ? 4 : 3;

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween(begin: 0.0, end: _itemsVisibleInDropdown * 48.00)
        .animate(_animationController);
    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: Text(
        context.l10n.torrents_set_trackers_heading,
        key: Key('Set Trackers Text'),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      key: Key('Add Trackers AlertDialog'),
      elevation: 0,
      backgroundColor: themeBloc.isDarkMode
          ? ThemeBloc.theme(widget.themeIndex).primaryColorLight
          : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
      content: Builder(builder: (context) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          constraints: BoxConstraints(),
          height: _showdropdown
              ? hp - (700 - (50 * _itemsVisibleInDropdown - 1))
              : hp - 700,
          width: wp - 100,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                TextFormField(
                  key: Key('Trackers Text Form Field'),
                  controller: _textController,
                  decoration: InputDecoration(
                    fillColor: themeBloc.isDarkMode
                        ? ThemeBloc.theme(widget.themeIndex).primaryColor
                        : Colors.black45,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 17.0, horizontal: 15.0),
                    filled: true,
                    suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        icon: _showdropdown
                            ? Icon(
                                Icons.keyboard_arrow_up_rounded,
                                key: Key('Show Arrow Up Icon'),
                              )
                            : Icon(
                                Icons.keyboard_arrow_down_rounded,
                                key: Key('Show Arrow Down Icon'),
                              ),
                        onPressed: () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          setState(() {
                            _showdropdown = !_showdropdown;
                            _showdropdown
                                ? _animationController.forward()
                                : _animationController.reverse();
                          });
                        }),
                    hintStyle: TextStyle(
                        color:
                            themeBloc.isDarkMode ? Colors.grey : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                    hintText: context.l10n.torrents_enter_trackers_hint,
                  ),
                  style: TextStyle(
                      color: ThemeBloc.theme(widget.themeIndex)
                          .textTheme
                          .bodyLarge
                          ?.color,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  autocorrect: false,
                  textAlign: TextAlign.start,
                  autofocus: false,
                  maxLines: 1,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                ),
                Container(
                  key: Key('Trackers List Container'),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: themeBloc.isDarkMode ? Colors.white : Colors.black12,
                  ),
                  margin: EdgeInsets.only(top: 3),
                  padding: EdgeInsets.only(top: 8),
                  height: _animation.value,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          controller: _scrollController,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          separatorBuilder: (context, index) =>
                              Divider(color: Colors.grey),
                          itemCount: _existingTrackers.length +
                              _newEnterdTrackers.length,
                          itemBuilder: (context, index) {
                            if (index < _existingTrackers.length) {
                              return _getCheckBoxListTile(
                                  _existingTrackers.keys.elementAt(index),
                                  index,
                                  themeBloc,
                                  _existingTrackers);
                            } else {
                              index -= _existingTrackers.length;
                              return _getCheckBoxListTile(
                                  _newEnterdTrackers.keys.elementAt(index),
                                  index,
                                  themeBloc,
                                  _newEnterdTrackers);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
      actionsPadding: EdgeInsets.only(bottom: 20),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        // No - TextButton
        TextButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
              Size(hp * .160, hp * .059),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
                ThemeBloc.theme(widget.themeIndex).dialogBackgroundColor),
          ),
          onPressed: () {
            reset();
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text(
            context.l10n.button_cancel,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        // Enter Tag - TextButton
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(hp * .160, hp * .059),
            ),
            backgroundColor: MaterialStateProperty.all(
                ThemeBloc.theme(widget.themeIndex).primaryColorDark),
          ),
          onPressed: (() {
            setState(() {
              widget.torrents.forEach((element) {
                TorrentApi.setTrackers(
                  trackersList: _inputTrackersList,
                  hashes: element.hash,
                  context: context,
                );
              });
              EventHandlerApi.filterDataRephrasor(
                  BlocProvider.of<HomeScreenBloc>(context).state.torrentList,
                  context);
              final addTorrentSnackbar = addFloodSnackBar(
                  SnackbarType.information,
                  context.l10n.torrents_set_trackers_snackbar,
                  context.l10n.button_dismiss);
              Navigator.of(context, rootNavigator: true).pop();
              ScaffoldMessenger.of(context).showSnackBar(addTorrentSnackbar);
            });
          }),
          child: Text(
            context.l10n.torrents_set_trackers_heading,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  CheckboxListTile _getCheckBoxListTile(
      String text, int index, ThemeBloc themeBloc, Map<String, bool> trackers) {
    return CheckboxListTile(
        dense: true,
        title: Text(
          text,
          style: TextStyle(
              color:
                  trackers.values.elementAt(index) ? Colors.blue : Colors.black,
              fontSize: 16),
        ),
        side: BorderSide.none,
        activeColor: themeBloc.isDarkMode ? Colors.white : Colors.black12,
        checkColor: Colors.blue,
        value: trackers.values.elementAt(index),
        selected: trackers.values.elementAt(index),
        visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
        onChanged: (val) {
          setState(() {
            trackers.update(text, (value) => !value);
            if (trackers.values.elementAt(index) == false) {
              _inputTrackersList.removeWhere((element) => element == text);
            } else {
              _inputTrackersList.add(text);
            }
            _inputTrackersList.removeWhere((element) => element == "");
            _textController.text = _inputTrackersList.join(',');
            _textController.selection = TextSelection.fromPosition(
                TextPosition(offset: _textController.text.length));
          });
        });
  }

  void reset() {
    setState(() {
      _textController.text = '';
      _existingTrackers.updateAll((key, value) => value = false);
      _inputTrackersList = [];
      _newEnterdTrackers = {};
    });
  }

  void _handleControllerChanged() {
    _newEnterdTrackers = {};
    if (_textController.text.length > 0) {
      //avoid 2 comma continuously
      if (_textController.text.contains(",,")) {
        _textController.text = _textController.text.replaceAll(",,", ",");
        _textController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textController.text.length));
      }
      _inputTrackersList = _textController.text.split(',');
      _inputTrackersList.remove("");

      //change color of CheckBoxListTile when input tag match existing tags
      _existingTrackers.forEach((key, value) {
        if (_inputTrackersList.contains(key)) {
          setState(() {
            _existingTrackers[key] = true;
          });
        } else {
          setState(() {
            _existingTrackers[key] = false;
          });
        }
      });

      //Store new entered tag
      _inputTrackersList.forEach((element) {
        if (!_existingTrackers.containsKey(element)) {
          _newEnterdTrackers.addAll({element: true});
          //Scroll bottom of listview
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }
      });
    } else if (_textController.text.length <= 0) {
      reset();
    }
  }
}
