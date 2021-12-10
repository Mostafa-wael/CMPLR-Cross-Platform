import 'package:metadata_fetch/metadata_fetch.dart';

import '../../utilities/sizing/sizing.dart';

import '../../utilities/custom_widgets/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WritePostController extends GetxController {
<<<<<<< Updated upstream
  bool longPressed = false;

  late FocusNode textFocus;
  String currentMode = 'Regular';
  Map<String, List<String>> textModes = {
    'Regular': ['<p>', '</p>'], // Regular
    'Bigger': ['<h6>', '</h6>'], // Bigger
    'Biggest': ['<h5>', '</h5>'], // Biggest
    'Quote': ['<blockquote>', '</blockquote>'], // Quote
    'Chat': ['', ''], // Chat, note it uses mono
    'Luccile': ['', ''], // Lucille
    'Indent': [
      '<blockquote>',
      '</blockquote>'
    ], // Indented, blockquote seems to do this
    'Bulleted list': ['<ul>', '</ul>', '<li>', '</li>'], // Bulleted list
    'Numbered list': ['<ul>', '</ul>', '<li>', '</li>'], // Numbered list
  };
  WritePostController() {
    textFocus = FocusNode();
=======
  postOptions _currentPostOption = postOptions.postNow;
  String _date = '';
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  final _currentDate = DateTime.now();
  bool _bold = false;
  bool _italic = false;
  bool _strikethrough = false;
  final allColors = [
    Colors.white,
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink
  ];
  // TODO: Change default color according to theme
  Color _currentColor = Colors.white;
  final _userName = 'Username';
  final _userAvatar = 'lib/utilities/assets/logo/logo_icon.png';

  PostItem? post;

  final _model;

  List<TextField> urls = [];
  List<TextEditingController> urlControllers = [];

  List<Widget> previews = [];

  String get userName => _userName;

  String get userAvatar => _userAvatar;

  Color get currentColor => _currentColor;

  Future<void> changeColor(int colorIndex) async {
    _currentColor = allColors[colorIndex];
    update();
  }

  Future<void> toggleBold() async {
    _bold = !_bold;
    update();
  }

  Future<void> toggleItalic() async {
    _italic = !_italic;
    update();
  }

  Future<void> toggleStrikethrough() async {
    _strikethrough = !_strikethrough;
    update();
  }

  bool get bold => _bold;

  bool get italic => _italic;

  bool get strikethough => _strikethrough;

  postOptions get currentPostOption => _currentPostOption;

  String get date => _date;

  WritePostController(this._model) {
    initializeDateFormatting();
    final date_1 = DateFormat.MMMEd().format(_dateTime);
    final date_2 = DateFormat.jm().format(_dateTime);
    _date = '${date_1}at ${date_2}';
>>>>>>> Stashed changes
  }

  void focusOnText() {
    if (textFocus.hasFocus) {
      // TODO: Cycle modes
    } else
      textFocus.requestFocus();
  }

  Future showFontPopup(context) {
    return showMenu(
      context: context,
      items: [
        PopupMenuItem(
            child: GestureDetector(
              child: const Text('Regular'),
            )),
        PopupMenuItem(
            child: GestureDetector(
              child: const Text('Bigger'),
            ))
      ],
      position: const RelativeRect.fromLTRB(0, 0, 0, 0),
    );
  }

  void setMode(String mode) {
    print(mode);
    assert(textModes.containsKey(mode));
    currentMode = mode;
  }

  void addLink() {
    Future<Metadata?>? fut;
    final editingController = TextEditingController();
    final textField = TextField(
      controller: editingController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 5.0))),
      onEditingComplete: () {
        // previews.add(FlutterLinkPreview(url: editingController.text));
        fut = MetadataFetch.extract(editingController.text);
      },
    );

    fut?.then((value) => print(value));

    urls.add(textField);
    urlControllers.add(editingController);

    update();
  }
}
