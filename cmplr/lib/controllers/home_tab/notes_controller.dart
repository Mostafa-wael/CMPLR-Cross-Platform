import 'package:get_storage/get_storage.dart';

import '../controllers.dart';
import '../../views/home_tab/reblog_screen.dart';
import '../../utilities/custom_widgets/custom_widgets.dart';
import '../../models/models.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class NotesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  KeyboardVisibilityController keyboardController =
      KeyboardVisibilityController();

  final RxBool _postSubscribed = false.obs;

  TabController? _tabController;

  int _tabIndex = 0;

  final RxBool _reblogsWithComments = true.obs;

  final NotesModel _notesModel = NotesModel();

  final RxBool _focusCommentTextField = false.obs;

  final RxBool _emptyCommentTextField = true.obs;

  TextEditingController commentTextFieldController = TextEditingController();

  FocusNode commentTextFieldFocusNode = FocusNode();

  bool dataReloaded = false;

  ScrollController commentListViewController = ScrollController();

  // This is just a reference to the notes in the data model
  List<List<UserNote>>? notes;

  RxBool get postSubscribed => _postSubscribed;

  TabController? get tabController => _tabController;

  NotesModel get notesModel => _notesModel;

  RxBool get focusCommentTextField => _focusCommentTextField;

  RxBool get emptyCommentTextField => _emptyCommentTextField;

  RxBool get reblogsWithComments => _reblogsWithComments;

  PostItem? postItem;

  @override
  void onInit() {
    _tabController = TabController(length: 3, vsync: this);

    _tabController?.addListener(() {
      if (_tabIndex == 0 && _tabController?.index != 0) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
      _tabIndex = _tabController!.index;
    });

    keyboardController.onChange.listen((isVisible) {
      isVisible
          ? _focusCommentTextField.value = true
          : _focusCommentTextField.value = false;
    });

    postItem = Get.arguments;
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

  void addStringToComment(String text) {
    commentTextFieldController.text = commentTextFieldController.text + text;
    commentTextFieldController.selection = TextSelection.fromPosition(
        TextPosition(offset: commentTextFieldController.text.length));
    commentTextFieldChanged(commentTextFieldController.text);
  }

  void commentSubmitted() {
    /*
    1- Send a post request to submit the comment
    2- Update the current comments list
    3- Timeless refresh so that the comment appears
    */
    // Replace the following data with the current user data
    notes![0].insert(
        0,
        UserNote(
            noteType: 'reply',
            blogName: GetStorage().read('blog_name'),
            avatarShape: 'circle',
            avatarURL: GetStorage().read('avatar'),
            followed: false.obs,
            postReply: commentTextFieldController.text));
    commentTextFieldController.text = '';
    timelessRefreshScreen();
    commentListViewController
        .jumpTo(commentListViewController.position.minScrollExtent);

    emptyCommentTextField.value = true;
    // SystemChannels.textInput.invokeMethod('TextInput.show');
    // commentTextFieldFocusNode.requestFocus();
  }

  Future<void> timelessRefreshScreen() async {
    dataReloaded = true;
    update();
  }

  // This fetches the data once again
  Future<void> refreshScreen() async {
    notes = await notesModel.getNotes(postItem!.postID);
    dataReloaded = true;
    update();
  }

  void closeNotesScreen() {
    Get.back();
  }

  void reblogFromNotes() {
    // ignore: omit_local_variable_types
    final ReblogController reblogController = Get.find<ReblogController>();
    reblogController.setPost(postItem!);
    Get.to(const ReblogView());
  }
}
