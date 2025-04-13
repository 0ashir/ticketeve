class SettingModel {
  SettingModel({
    Data? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  SettingModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  Data? _data;
  bool? _success;

  SettingModel copyWith({
    Data? data,
    bool? success,
  }) =>
      SettingModel(
        data: data ?? _data,
        success: success ?? _success,
      );

  Data? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    return map;
  }
}

class Data {
  Data({
    String? currency,
    String? defaultLat,
    String? defaultLong,
    String? privacyPolicyOrganizer,
    String? termsUseOrganizer,
    String? appVersion,
    dynamic orOnesignalAppId,
    dynamic orOnesignalProjectNumber,
    String? footerCopyright,
    String? currencySymbol,
    String? imagePath,
  }) {
    _currency = currency;
    _defaultLat = defaultLat;
    _defaultLong = defaultLong;
    _privacyPolicyOrganizer = privacyPolicyOrganizer;
    _termsUseOrganizer = termsUseOrganizer;
    _appVersion = appVersion;
    _orOnesignalAppId = orOnesignalAppId;
    _orOnesignalProjectNumber = orOnesignalProjectNumber;
    _footerCopyright = footerCopyright;
    _currencySymbol = currencySymbol;
    _imagePath = imagePath;
  }

  Data.fromJson(dynamic json) {
    _currency = json['currency'];
    _defaultLat = json['default_lat'];
    _defaultLong = json['default_long'];
    _privacyPolicyOrganizer = json['privacy_policy_organizer'];
    _termsUseOrganizer = json['terms_use_organizer'];
    _appVersion = json['app_version'];
    _orOnesignalAppId = json['or_onesignal_app_id'];
    _orOnesignalProjectNumber = json['or_onesignal_project_number'];
    _footerCopyright = json['footer_copyright'];
    _currencySymbol = json['currency_symbol'];
    _imagePath = json['imagePath'];
  }

  String? _currency;
  String? _defaultLat;
  String? _defaultLong;
  String? _privacyPolicyOrganizer;
  String? _termsUseOrganizer;
  String? _appVersion;
  dynamic _orOnesignalAppId;
  dynamic _orOnesignalProjectNumber;
  String? _footerCopyright;
  String? _currencySymbol;
  String? _imagePath;

  Data copyWith({
    String? currency,
    String? defaultLat,
    String? defaultLong,
    String? privacyPolicyOrganizer,
    String? termsUseOrganizer,
    String? appVersion,
    dynamic orOnesignalAppId,
    dynamic orOnesignalProjectNumber,
    String? footerCopyright,
    String? currencySymbol,
    String? imagePath,
  }) =>
      Data(
        currency: currency ?? _currency,
        defaultLat: defaultLat ?? _defaultLat,
        defaultLong: defaultLong ?? _defaultLong,
        privacyPolicyOrganizer: privacyPolicyOrganizer ?? _privacyPolicyOrganizer,
        termsUseOrganizer: termsUseOrganizer ?? _termsUseOrganizer,
        appVersion: appVersion ?? _appVersion,
        orOnesignalAppId: orOnesignalAppId ?? _orOnesignalAppId,
        orOnesignalProjectNumber: orOnesignalProjectNumber ?? _orOnesignalProjectNumber,
        footerCopyright: footerCopyright ?? _footerCopyright,
        currencySymbol: currencySymbol ?? _currencySymbol,
        imagePath: imagePath ?? _imagePath,
      );

  String? get currency => _currency;

  String? get defaultLat => _defaultLat;

  String? get defaultLong => _defaultLong;

  String? get privacyPolicyOrganizer => _privacyPolicyOrganizer;

  String? get termsUseOrganizer => _termsUseOrganizer;

  String? get appVersion => _appVersion;

  dynamic get orOnesignalAppId => _orOnesignalAppId;

  dynamic get orOnesignalProjectNumber => _orOnesignalProjectNumber;

  String? get footerCopyright => _footerCopyright;

  String? get currencySymbol => _currencySymbol;

  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = _currency;
    map['default_lat'] = _defaultLat;
    map['default_long'] = _defaultLong;
    map['privacy_policy_organizer'] = _privacyPolicyOrganizer;
    map['terms_use_organizer'] = _termsUseOrganizer;
    map['app_version'] = _appVersion;
    map['or_onesignal_app_id'] = _orOnesignalAppId;
    map['or_onesignal_project_number'] = _orOnesignalProjectNumber;
    map['footer_copyright'] = _footerCopyright;
    map['currency_symbol'] = _currencySymbol;
    map['imagePath'] = _imagePath;
    return map;
  }
}
