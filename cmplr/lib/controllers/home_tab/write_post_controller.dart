import 'package:metadata_fetch/metadata_fetch.dart';

import '../../utilities/sizing/sizing.dart';

import '../../utilities/custom_widgets/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

enum postOptions {
  postNow,
  schedule,
  saveAsDraft,
  postPrivately,
  shareToTwitter
}

class WritePostController extends GetxController {
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
  }

  Future<void> setDateTime(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: _currentDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != _dateTime) {
      _dateTime = picked;
      final date_1 = DateFormat.MMMEd().format(_dateTime);
      _date = '${date_1} at ${_date.split('at')[1]}';
      update();
    }
  }

  Future<void> setTimeOfDay(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    if (picked != null && picked != _timeOfDay) {
      if (picked.hour < TimeOfDay.fromDateTime(_currentDate).hour ||
          (picked.hour == TimeOfDay.fromDateTime(_currentDate).hour &&
              picked.minute < TimeOfDay.fromDateTime(_currentDate).minute)) {
        _showToast('Nice try, but you can\'t post from the past.');
      } else {
        _timeOfDay = picked;
        final hour =
            _timeOfDay.hour >= 12 ? _timeOfDay.hour - 12 : _timeOfDay.hour;
        final am = _timeOfDay.hour >= 12 ? 'PM' : 'AM';
        final date_2 = '${hour}:${_timeOfDay.minute}${am}';
        _date = '${_date.split('at')[0]}at ${date_2}';
        update();
      }
    }
  }

  bool isActivated(postOptions option) {
    return _currentPostOption == option;
  }

  Future<void> setPostOption(postOptions option) async {
    _currentPostOption = option;
    update();
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

void _showToast(String message) => Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: const Color(0xFF4E4F53),
      timeInSecForIosWeb: 1,
    );
