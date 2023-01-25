bool isNullOrBlank(String? data) => data?.trim().isEmpty ?? true;

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  return emailRegex.hasMatch(email);
}

bool isValidPhoneNumber(String phoneNumber) {
  if (phoneNumber.length != 10) return false;
  final phoneRegex = RegExp(r'^[0-9]+$');
  return phoneRegex.hasMatch(phoneNumber);
}

String? validateEmail(String? email) {
  if (isNullOrBlank(email) || !isValidEmail(email!)) {
    return 'Please enter a valid email address!';
  }
  return null;
}

String? validatePhoneNumber(String? phone) {
  if (isNullOrBlank(phone)) {
    return 'Please enter a valid phone number!';
  } else if (!isValidPhoneNumber(phone!)) {
    return 'Please enter a valid 10 digit phone number!';
  }
  return null;
}

int notificationSchedular(DateTime start, DateTime end) {
  int startSec = start.millisecondsSinceEpoch;
  int endSec = end.millisecondsSinceEpoch;
  int duration = endSec - startSec;
  return duration;
}
