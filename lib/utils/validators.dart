class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  //   static final RegExp _phoneRegExp =
  //    RegExp(
  //   r'^(?:[+0]7)?[0-9]{10,12}$',
  // );
//RegExp(r'^(?[0-9]+$');

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPhone(String phone) {
    if (phone.length > 10) {
      return true;
    } else {
      return false;
    }
    //  return _phoneRegExp.hasMatch(phone);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
