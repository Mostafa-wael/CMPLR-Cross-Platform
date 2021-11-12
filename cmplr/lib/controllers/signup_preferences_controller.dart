import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/models.dart';

class SignupPreferencesController extends GetxController {
  int _selectedPreferencesCount = 0;
  String _buttonText = 'Pick 5';
  int _buttonTextColor = 0xFF7F8D9C;
  bool _isLoading = false;
  List _availablePreferenceCards = [];
  List _selectedPreferenceCards = [];
  SignupPreferencesModel preferencesModel = SignupPreferencesModel();

  @override
  void onInit() {
    _availablePreferenceCards = preferencesModel.getInitialPreferences();
    super.onInit();
  }

  String get buttonText {
    return _buttonText;
  }

  int get buttonTextColor {
    return _buttonTextColor;
  }

  bool get isLoading {
    return _isLoading;
  }

  List get availablePreferenceCards {
    return _availablePreferenceCards;
  }

  int get selectedPreferencesCount {
    return _selectedPreferencesCount;
  }

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
    } else {
      if (Get.isSnackbarOpen! == true) {
        Get.back();
      }
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          'Not yet! Pick ${5 - _selectedPreferencesCount} '
          'more things you\'re into.',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
      );
    }
  }

  void chooseNewPreference() {
    Get.toNamed('/signup_preferences_search', arguments: this);
  }

  bool preferenceChosen(String preferenceName) {
    for (var i = 0; i < _availablePreferenceCards.length; i++) {
      if (_availablePreferenceCards[i].preferenceName == preferenceName) {
        return true;
      }
    }
    return false;
  }

  void addPreference(String preferenceName) {
    if (!preferenceChosen(preferenceName)) {
      _availablePreferenceCards.insert(
          0, preferencesModel.createNewPreference(preferenceName));
      tapPreferenceCard(0);
      update();
    }
  }
}
