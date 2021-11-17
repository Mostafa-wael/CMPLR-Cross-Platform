import 'package:get_storage/get_storage.dart';

import '../views/android_views/master_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/models.dart';

class SignupPreferencesController extends GetxController {
  // number of preferences selected by the user
  int _selectedPreferencesCount = 0;

  // the text of the button in the top right (it changes by selecting
  // or unselecting a preference)
  String _buttonText = 'Pick 5';

  int _buttonTextColor = 0xFF7F8D9C;

  // determine whether the screen is loading after preferences selection
  bool _isLoading = false;

  // list of currently viewed preferences
  List _availablePreferenceCards = [];

  // data model for preferences
  SignupPreferencesModel preferencesModel = SignupPreferencesModel();

  @override
  void onInit() {
    // get the initial preferences
    _availablePreferenceCards = preferencesModel.getInitialPreferences();
    super.onInit();
  }

  // getters for class attributes
  String get buttonText => _buttonText;

  int get buttonTextColor => _buttonTextColor;

  bool get isLoading => _isLoading;

  List get availablePreferenceCards => _availablePreferenceCards;

  int get selectedPreferencesCount => _selectedPreferencesCount;

  // this handles different scenarios when selecting or unselecting a preference
  void tapPreferenceCard(int index) {
    if (_availablePreferenceCards[index].isChosen) {
      _selectedPreferencesCount--;
    } else {
      _selectedPreferencesCount++;
    }

    _availablePreferenceCards[index].isChosen =
        !(_availablePreferenceCards[index].isChosen);
    if (_selectedPreferencesCount >= 5) {
      _buttonText = 'Next';
      _buttonTextColor = 0xFF3498eb;
    } else {
      _buttonText = 'Pick ${5 - _selectedPreferencesCount}';
      _buttonTextColor = 0xFF7F8D9C;
    }

    update();
  }

  void nextButtonPressed() async {
    if (_selectedPreferencesCount >= 5) {
      _isLoading = true;
      update();
      await Future.delayed(const Duration(seconds: 3));
      _isLoading = false;
      update();
      Get.offAll(const MasterPage());
    } else {
      // if a Snackbar is already open, then close it to show another one
      if (Get.isSnackbarOpen! == true) {
        Get.back();
      }
      // error Snackbar
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          'Not yet! Pick ${5 - _selectedPreferencesCount} '
          'more things you\'re into.',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
      );
    }
  }

  void chooseNewPreference() {
    // go to search preference page
    Get.toNamed('/signup_preferences_search', arguments: this);
  }

  // check if the preference is already chosen before
  bool preferenceChosen(String preferenceName) {
    for (var i = 0; i < _availablePreferenceCards.length; i++) {
      if (_availablePreferenceCards[i].preferenceName == preferenceName) {
        return true;
      }
    }
    return false;
  }

  // add new preference in the list
  void addPreference(String preferenceName) {
    if (!preferenceChosen(preferenceName)) {
      _availablePreferenceCards.insert(
          0, preferencesModel.createNewPreference(preferenceName));
      tapPreferenceCard(0);
      update();
    }
  }
}
