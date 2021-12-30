/// Holds global flags used for mocking and erasing persisent storage.
class Flags {
  static bool mock = false;

  // Clears persistent data on app launch.
  // WARNING: MAKE SURE YOU UNDERSTAND WHAT'S GOING TO BE ERASED
  static bool cleanState = false;
}

/// A local asset path used as a placeholder in case a URL is not available.
String placeHolderImgPath = 'lib/utilities/assets/logo/cmplr_logo_icon.png';

/// A placeholder URL used in case a real URL is not available and a placeholder
/// can't be used.
String placeHolderImgUrl = 'https://picsum.photos/200';
