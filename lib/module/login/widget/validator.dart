class Validator {
  static String? name(String? value) {
    if (value!.isEmpty) {
      return 'Mohon isi nama terlebih dulu';
    }
    return null;
  }

  static String? email(String? value) {
    if (value!.isEmpty) {
      return 'Mohon isi email terlebih dulu';
    }
    return null;
  }

  static String? field(String? value) {
    if (value!.isEmpty) {
      return "Mohon isi field ini";
    }
    return null;
  }

  static String? radio(String? value) {
    if (value == null || value.isEmpty) {
      return "Mohon pilih salah satu";
    }
    return null;
  }

  static String? password(
    dynamic value, {
    String? field,
  }) {
    if (value!.isEmpty) {
      return 'Mohon isi password terlebih dulu';
    } else if (field!.length < 5) {
      return 'Mohon isi lebih dari 5 karakter';
    }
    return null;
  }
}
