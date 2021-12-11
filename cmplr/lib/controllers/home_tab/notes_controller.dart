import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../models/models.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';

class NotesController extends GetxController with SingleGetTickerProviderMixin {
  KeyboardVisibilityController keyboardController =
      KeyboardVisibilityController();

  final RxBool _postSubscribed = false.obs;

  late TabController _tabController;

  int _tabIndex = 0;

  final RxBool _reblogsWithComments = true.obs;

  final NotesModel _notesModel = NotesModel();

  final RxBool _focusCommentTextField = false.obs;

  final RxBool _emptyCommentTextField = true.obs;

  static bool dataReloaded = false;

  // This is just a reference to the notes in the data model
  List<List<UserNote>>? notes;

  RxBool get postSubscribed => _postSubscribed;

  TabController get tabController => _tabController;

  NotesModel get notesModel => _notesModel;

  RxBool get focusCommentTextField => _focusCommentTextField;

  RxBool get emptyCommentTextField => _emptyCommentTextField;

  RxBool get reblogsWithComments => _reblogsWithComments;

  @override
  void onInit() {
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabIndex == 0 && _tabController.index != 0) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
      _tabIndex = _tabController.index;
    });

    keyboardController.onChange.listen((isVisible) {
      isVisible
          ? _focusCommentTextField.value = true
          : _focusCommentTextField.value = false;
    });

    super.onInit();
  }

  void subscriptionButtonPressed() {
    String snackBarMessage;
    if (_postSubscribed.value) {
      snackBarMessage = 'Unsubscribed. Easy as pie.';
    } else {
      snackBarMessage = 'Okay you are subscribed to this post.';
    }
    _postSubscribed.value = !_postSubscribed.value;
    if (Get.isSnackbarOpen == true) {
      Get.back();
    }

    // Show error SnackBar
    Get.rawSnackbar(
      backgroundColor: Colors.green,
      messageText: Text(
        snackBarMessage,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
    );
  }

  void commentTextFieldFocusChanged(bool hasFocus) {
    if (hasFocus) {
      _focusCommentTextField.value = true;
    } else {
      _focusCommentTextField.value = false;
    }
  }

  void commentTextFieldChanged(String comment) {
    if (comment == '') {
      _emptyCommentTextField.value = true;
    } else {
      _emptyCommentTextField.value = false;
    }
  }

  Future<void> refreshScreen() async {
    notes = await notesModel.getNotes();
    dataReloaded = true;
    update();
  }

  void closeNotesScreen() {
    Get.back();
  }
}
