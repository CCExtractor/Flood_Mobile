import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flood_mobile/Api/event_handler_api.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Blocs/filter_torrent_bloc/filter_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Blocs/user_interface_bloc/user_interface_bloc.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Model/user_interface_model.dart';
import 'package:flood_mobile/Pages/widgets/flood_snackbar.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class AddTagDialogue extends StatefulWidget {
  final List<TorrentModel> torrents;
  final int themeIndex;
  const AddTagDialogue(
      {Key? key, required this.torrents, required this.themeIndex})
      : super(key: key);
  @override
  State<AddTagDialogue> createState() => _AddTagDialogueState();
}

class _AddTagDialogueState extends State<AddTagDialogue>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showdropdown = false;
  late TextEditingController _textController;
  int _itemsVisibleInDropdown = 1;
  List<String> _inputTagList = [];
  Map<String, bool> _existingTags = {};
  Map<String, bool> _newEnterdTags = {};
  late Animation _animation;
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _textController =
        TextEditingController(text: widget.torrents[0].tags.join(","));
    _textController.addListener(_handleControllerChanged);
    _inputTagList = _textController.text.split(',');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _existingTags = Map.fromIterable(
        BlocProvider.of<FilterTorrentBloc>(context, listen: false)
            .state
            .mapTags
            .keys
            .toList(),
        key: (e) => e,
        value: (e) => false);

    _existingTags.forEach((key, value) {
      if (_inputTagList.contains(key)) {
        _existingTags[key] = true;
      }
    });
    _itemsVisibleInDropdown = _existingTags.length >= 4 ? 4 : 3;

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
    final tagPreferenceButtonValue =
        BlocProvider.of<UserInterfaceBloc>(context, listen: false)
            .state
            .model
            .tagPreferenceButtonValue;
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: Text(
        context.l10n.torrents_set_tags_heading,
        key: Key('Set Tags Text'),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      key: Key('Add Tag AlertDialog'),
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
                Form(
                  key: _formKey,
                  child: TextFormField(
                    key: Key('Tags Text Form Field'),
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
                      hintText: context.l10n.torrents_enter_tags_hint,
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
                    validator: (String? newValue) {
                      if (newValue == null || newValue.isEmpty)
                        return context
                            .l10n.torrents_set_tags_textfield_validator;
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                  ),
                ),
                Container(
                  key: Key('Tags List Container'),
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
                          itemCount:
                              _existingTags.length + _newEnterdTags.length,
                          itemBuilder: (context, index) {
                            if (index < _existingTags.length) {
                              return _getCheckBoxListTile(
                                _existingTags.keys.elementAt(index),
                                index,
                                themeBloc,
                                _existingTags,
                                tagPreferenceButtonValue,
                              );
                            } else {
                              index -= _existingTags.length;
                              return _getCheckBoxListTile(
                                _newEnterdTags.keys.elementAt(index),
                                index,
                                themeBloc,
                                _newEnterdTags,
                                tagPreferenceButtonValue,
                              );
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
              if (_formKey.currentState!.validate()) {
                widget.torrents.forEach((element) {
                  TorrentApi.setTags(
                      tagList: _inputTagList.toList(),
                      hashes: element.hash,
                      context: context);
                });
                EventHandlerApi.filterDataRephrasor(
                    BlocProvider.of<HomeScreenBloc>(context).state.torrentList,
                    context);
                final addTagsSnackbar = addFloodSnackBar(
                    SnackbarType.information,
                    context.l10n.torrents_set_tags_snackbar,
                    context.l10n.button_dismiss);
                Navigator.of(context, rootNavigator: true).pop();
                ScaffoldMessenger.of(context).showSnackBar(addTagsSnackbar);
              }
            });
          }),
          child: Text(
            context.l10n.torrents_set_tags_heading,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  CheckboxListTile _getCheckBoxListTile(
      String text,
      int index,
      ThemeBloc themeBloc,
      Map<String, bool> tags,
      TagPreferenceButtonValue tagPreferenceButtonValue) {
    return CheckboxListTile(
        dense: true,
        title: Text(
          text,
          style: TextStyle(
              color: tags.values.elementAt(index) ? Colors.blue : Colors.black,
              fontSize: 16),
        ),
        side: BorderSide.none,
        activeColor: themeBloc.isDarkMode ? Colors.white : Colors.black12,
        checkColor: Colors.blue,
        value: tags.values.elementAt(index),
        selected: tags.values.elementAt(index),
        visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
        onChanged: (val) {
          setState(() {
            tags.update(text, (value) => !value);
            if (tags.values.elementAt(index) == false) {
              _inputTagList.removeWhere((element) => element == text);
            } else {
              _inputTagList.add(text);
            }
            _inputTagList.removeWhere((element) => element == "");
            _textController.text = _inputTagList.join(',');
            _textController.selection = TextSelection.fromPosition(
                TextPosition(offset: _textController.text.length));
            if (tagPreferenceButtonValue ==
                TagPreferenceButtonValue.singleSelection) {
              _showdropdown = false;
              _animationController.reverse();
            }
          });
        });
  }

  void reset() {
    setState(() {
      _textController.text = '';
      _existingTags.updateAll((key, value) => value = false);
      _inputTagList = [];
      _newEnterdTags = {};
    });
  }

  void _handleControllerChanged() {
    _newEnterdTags = {};
    if (_textController.text.length > 0) {
      //avoid 2 comma continuously
      if (_textController.text.contains(",,")) {
        _textController.text = _textController.text.replaceAll(",,", ",");
        _textController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textController.text.length));
      }
      _inputTagList = _textController.text.split(',');
      _inputTagList.remove("");

      //if user press Untagged
      if (_inputTagList.last == 'Untagged') {
        reset();
      }

      //change color of CheckBoxListTile when input tag match existing tags
      _existingTags.forEach((key, value) {
        if (_inputTagList.contains(key)) {
          setState(() {
            _existingTags[key] = true;
          });
        } else {
          setState(() {
            _existingTags[key] = false;
          });
        }
      });

      //Store new entered tag
      _inputTagList.forEach((element) {
        if (!_existingTags.containsKey(element)) {
          _newEnterdTags.addAll({element: true});
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
