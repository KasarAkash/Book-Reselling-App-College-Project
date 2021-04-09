class FormCheckConditions {
  //For CHecking the Name
  static Function nameCheck = (String value) {
    if (value.isEmpty) {
      return "Name is required";
    }
  };

  //For CHecking the enrolement
  static Function enrolementCheck = (String value) {
    if (value.isEmpty) {
      return "Enrolement Number is required";
    }
    if (value.length != 12) {
      return "Enrolement Number is invalid";
    }
  };

  //For CHecking the phone
  static Function phoneCheck = (String value) {
    if (value.isEmpty) {
      return "Phone Number is required";
    }
    if (value.length != 10) {
      return "Phone Number is invalid";
    }
  };
}
