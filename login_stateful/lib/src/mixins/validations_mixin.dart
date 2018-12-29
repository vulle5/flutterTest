// Mixins can be used to contain methods that you want to
// use in multiple different classes
class ValidationMixin {

  String validateEmail (String value) {
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String validatePassword (String value) {
    if (value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }
}