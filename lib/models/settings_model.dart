class SettingsModel {
  bool? success;
  String? message;
  Settings? settings;

  SettingsModel({this.success, this.message, this.settings});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    settings = json['data'] != null ? Settings.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (settings != null) {
      data['data'] = settings!.toJson();
    }
    return data;
  }
}

class Settings {
  String? appName;
  String? phone;
  String? email;
  String? lightLogo;
  String? darkLogo;
  String? favicon;
  String? defaultLanguage;

  Settings(
      {this.appName,
      this.phone,
      this.email,
      this.lightLogo,
      this.darkLogo,
      this.favicon,
      this.defaultLanguage});

  Settings.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    phone = json['phone'];
    email = json['email'];
    lightLogo = json['light_logo'];
    darkLogo = json['dark_logo'];
    favicon = json['favicon'];
    defaultLanguage = json['default_language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['phone'] = phone;
    data['email'] = email;
    data['light_logo'] = lightLogo;
    data['dark_logo'] = darkLogo;
    data['favicon'] = favicon;
    data['default_language'] = defaultLanguage;
    return data;
  }
}
