import '../../views/master_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/models.dart';

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

  // getters for class attributes
  String get buttonText => _buttonText;

  int get buttonTextColor => _buttonTextColor;

  bool get isLoading => _isLoading;

  List get availablePreferenceCards => _availablePreferenceCards;

  int get selectedPreferencesCount => _selectedPreferencesCount;

  @override
  void onInit() {
    // get the initial preferences
    _availablePreferenceCards = preferencesModel.getInitialPreferences();
    super.onInit();
  }

  /// This method handles different scenarios when tapping (selecting or
  /// unselecting) a preference card
  void tapPreferenceCard(int index) {
    // this checks if the preference card was already choosen
    if (_availablePreferenceCards[index].isChosen) {
      _selectedPreferencesCount--;
    } else {
      _selectedPreferencesCount++;
    }

    // change the state of the tapped preference card
    _availablePreferenceCards[index].isChosen =
        !(_availablePreferenceCards[index].isChosen);

    // if the selected preferences is more than 5, the page can navigate now
    if (_selectedPreferencesCount >= 5) {
      _buttonText = 'Next';
      _buttonTextColor = 0xFF3498eb;
    } else {
      _buttonText = 'Pick ${5 - _selectedPreferencesCount}';
      _buttonTextColor = 0xFF7F8D9C;
    }

    update();
  }

  /// This method is called when the upper right button is pressed,
  /// If the number of selected preferences count is less than 5, an error
  /// snackbar is shown. Otherwise, navigation to the master page is done.
  void nextButtonPressed() async {
    if (_selectedPreferencesCount >= 5) {
      _isLoading = true;
      update();

      //TODO: communicate with the API instead of delay
      await Future.delayed(const Duration(seconds: 2));

      Get.offAll(const MasterPage());
    } else {
      // if a SnackBar is already open, then close it to show another one
      if (Get.isSnackbarOpen! == true) {
        Get.back();
      }
      // Show error SnackBar
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
    // navigate to search preference page
    Get.toNamed('/signup_preferences_search_screen', arguments: this);
  }

  // check if the preference card is already chosen before
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
