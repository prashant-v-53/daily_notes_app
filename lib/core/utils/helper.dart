class Helper {
  static bool isEmail(String em) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(em);
  }

  static bool isPassword(String em) {
    return RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{6,}$').hasMatch(em);
  }

  static bool isPhoneNumber(String em) {
    return (RegExp(r'^[0-9]').hasMatch(em) && em.length >= 8);
  }

  static bool isCardNumber(String em) {
    return (RegExp(r'^[0-9]').hasMatch(em) && em.length == 16);
  }

  static bool iscvv(String em) {
    return (RegExp(r'^[0-9]').hasMatch(em) && em.length == 3);
  }
}
