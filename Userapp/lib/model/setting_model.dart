class SettingModel {
  SettingModel({
    bool? success,
    dynamic msg,
    Data? data,
  }) {
    _success = success;
    _msg = msg;
    _data = data;
  }

  SettingModel.fromJson(dynamic json) {
    _success = json['success'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _success;
  dynamic _msg;
  Data? _data;

  SettingModel copyWith({
    bool? success,
    dynamic msg,
    Data? data,
  }) =>
      SettingModel(
        success: success ?? _success,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  bool? get success => _success;

  dynamic get msg => _msg;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    String? appName,
    String? appVersion,
    String? logo,
    dynamic mapKey,
    String? currency,
    dynamic onesignalAppId,
    dynamic onesignalProjectNumber,
    dynamic onesignalApiKey,
    dynamic onesignalAuthKey,
    String? helpCenter,
    String? privacyPolicy,
    String? cookiePolicy,
    String? termsServices,
    String? acknowledgement,
    String? primaryColor,
    String? currencySymbol,
    num? stripe,
    num? cod,
    num? paypal,
    num? razor,
    num? flutterwave,
    num? wallet,
    String? stripeSecretKey,
    String? stripePublicKey,
    String? paypalClientId,
    String? paypalSecret,
    String? razorPublishKey,
    String? razorSecretKey,
    String? imagePath,
    String? flutterWavePublicKey,
    String? flutterWaveSecretKey,
    num? flutterDebugMode,
  }) {
    _appName = appName;
    _appVersion = appVersion;
    _logo = logo;
    _mapKey = mapKey;
    _currency = currency;
    _onesignalAppId = onesignalAppId;
    _onesignalProjectNumber = onesignalProjectNumber;
    _onesignalApiKey = onesignalApiKey;
    _onesignalAuthKey = onesignalAuthKey;
    _helpCenter = helpCenter;
    _privacyPolicy = privacyPolicy;
    _cookiePolicy = cookiePolicy;
    _termsServices = termsServices;
    _acknowledgement = acknowledgement;
    _primaryColor = primaryColor;
    _currencySymbol = currencySymbol;
    _stripe = stripe;
    _cod = cod;
    _paypal = paypal;
    _razor = razor;
    _flutterwave = flutterwave;
    _wallet = wallet;
    _stripeSecretKey = stripeSecretKey;
    _stripePublicKey = stripePublicKey;
    _paypalClientId = paypalClientId;
    _paypalSecret = paypalSecret;
    _razorPublishKey = razorPublishKey;
    _razorSecretKey = razorSecretKey;
    _imagePath = imagePath;
    _flutterWavePublicKey = flutterWavePublicKey;
    _flutterWaveSecretKey = flutterWaveSecretKey;
    _flutterDebugMode = flutterDebugMode;
  }

  Data.fromJson(dynamic json) {
    _appName = json['app_name'];
    _appVersion = json['app_version'];
    _logo = json['logo'];
    _mapKey = json['map_key'];
    _currency = json['currency'];
    _onesignalAppId = json['onesignal_app_id'];
    _onesignalProjectNumber = json['onesignal_project_number'];
    _onesignalApiKey = json['onesignal_api_key'];
    _onesignalAuthKey = json['onesignal_auth_key'];
    _helpCenter = json['help_center'];
    _privacyPolicy = json['privacy_policy'];
    _cookiePolicy = json['cookie_policy'];
    _termsServices = json['terms_services'];
    _acknowledgement = json['acknowledgement'];
    _primaryColor = json['primary_color'];
    _currencySymbol = json['currency_sybmol'];
    _stripe = _parseNum(json['stripe']);
    _cod = _parseNum(json['cod']);
    _paypal = _parseNum(json['paypal']);
    _razor = _parseNum(json['razor']);
    _flutterwave = _parseNum(json['flutterwave']);
    _wallet = _parseNum(json['wallet']);
    _stripeSecretKey = json['stripeSecretKey'];
    _stripePublicKey = json['stripePublicKey'];
    _paypalClientId = json['paypalClientId'];
    _paypalSecret = json['paypalSecret'];
    _razorPublishKey = json['razorPublishKey'];
    _razorSecretKey = json['razorSecretKey'];
    _imagePath = json['imagePath'];
    _flutterWavePublicKey = json['ravePublicKey'];
    _flutterWaveSecretKey = json['raveSecretKey'];
    _flutterDebugMode = _parseNum(json['flutterDebugMode']);
  }
/// Utility function to safely parse numerical values
  num? _parseNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return null;
  }
  String? _appName;
  String? _appVersion;
  String? _logo;
  dynamic _mapKey;
  String? _currency;
  dynamic _onesignalAppId;
  dynamic _onesignalProjectNumber;
  dynamic _onesignalApiKey;
  dynamic _onesignalAuthKey;
  String? _helpCenter;
  String? _privacyPolicy;
  String? _cookiePolicy;
  String? _termsServices;
  String? _acknowledgement;
  String? _primaryColor;
  String? _currencySymbol;
  num? _stripe;
  num? _cod;
  num? _paypal;
  num? _razor;
  num? _flutterwave;
  num? _wallet;
  String? _stripeSecretKey;
  String? _stripePublicKey;
  String? _paypalClientId;
  String? _paypalSecret;
  String? _razorPublishKey;
  String? _razorSecretKey;
  String? _flutterWavePublicKey;
  String? _flutterWaveSecretKey;
  num? _flutterDebugMode;
  String? _imagePath;

  Data copyWith({
    String? appName,
    String? appVersion,
    String? logo,
    dynamic mapKey,
    String? currency,
    dynamic onesignalAppId,
    dynamic onesignalProjectNumber,
    dynamic onesignalApiKey,
    dynamic onesignalAuthKey,
    String? helpCenter,
    String? privacyPolicy,
    String? cookiePolicy,
    String? termsServices,
    String? acknowledgement,
    String? primaryColor,
    String? currencySymbol,
    num? stripe,
    num? cod,
    num? paypal,
    num? razor,
    num? flutterwave,
    num? wallet,
    String? stripeSecretKey,
    String? stripePublicKey,
    String? paypalClientId,
    String? razorPublishKey,
    String? razorSecretKey,
    String? imagePath,
    String? flutterWavePublicKey,
    String? flutterWaveSecretKey,
    num? flutterDebugMode,
    String? paypalSecret,
  }) =>
      Data(
        appName: appName ?? _appName,
        appVersion: appVersion ?? _appVersion,
        logo: logo ?? _logo,
        mapKey: mapKey ?? _mapKey,
        currency: currency ?? _currency,
        onesignalAppId: onesignalAppId ?? _onesignalAppId,
        onesignalProjectNumber: onesignalProjectNumber ?? _onesignalProjectNumber,
        onesignalApiKey: onesignalApiKey ?? _onesignalApiKey,
        onesignalAuthKey: onesignalAuthKey ?? _onesignalAuthKey,
        helpCenter: helpCenter ?? _helpCenter,
        privacyPolicy: privacyPolicy ?? _privacyPolicy,
        cookiePolicy: cookiePolicy ?? _cookiePolicy,
        termsServices: termsServices ?? _termsServices,
        acknowledgement: acknowledgement ?? _acknowledgement,
        primaryColor: primaryColor ?? _primaryColor,
        currencySymbol: currencySymbol ?? _currencySymbol,
        stripe: stripe ?? _stripe,
        cod: cod ?? _cod,
        paypal: paypal ?? _paypal,
        razor: razor ?? _razor,
        flutterwave: flutterwave ?? _flutterwave,
        wallet: wallet ?? _wallet,
        stripeSecretKey: stripeSecretKey ?? _stripeSecretKey,
        stripePublicKey: stripePublicKey ?? _stripePublicKey,
        paypalClientId: paypalClientId ?? _paypalClientId,
        razorPublishKey: razorPublishKey ?? _razorPublishKey,
        razorSecretKey: razorSecretKey ?? _razorSecretKey,
        imagePath: imagePath ?? _imagePath,
        flutterWavePublicKey: flutterWavePublicKey ?? _flutterWavePublicKey,
        flutterWaveSecretKey: flutterWaveSecretKey ?? _flutterWaveSecretKey,
        flutterDebugMode: flutterDebugMode ?? _flutterDebugMode,
        paypalSecret: paypalSecret ?? _paypalSecret,
      );

  String? get appName => _appName;

  String? get appVersion => _appVersion;

  String? get logo => _logo;

  dynamic get mapKey => _mapKey;

  String? get currency => _currency;

  dynamic get onesignalAppId => _onesignalAppId;

  dynamic get onesignalProjectNumber => _onesignalProjectNumber;

  dynamic get onesignalApiKey => _onesignalApiKey;

  dynamic get onesignalAuthKey => _onesignalAuthKey;

  String? get helpCenter => _helpCenter;

  String? get privacyPolicy => _privacyPolicy;

  String? get cookiePolicy => _cookiePolicy;

  String? get termsServices => _termsServices;

  String? get acknowledgement => _acknowledgement;

  String? get primaryColor => _primaryColor;

  String? get currencySymbol => _currencySymbol;

  num? get stripe => _stripe;

  num? get cod => _cod;

  num? get paypal => _paypal;

  num? get razor => _razor;

  num? get flutterwave => _flutterwave;

  num? get wallet => _wallet;

  String? get stripeSecretKey => _stripeSecretKey;

  String? get stripePublicKey => _stripePublicKey;

  String? get paypalClientId => _paypalClientId;

  String? get paypalSecret => _paypalSecret;

  String? get razorPublishKey => _razorPublishKey;

  String? get razorSecretKey => _razorSecretKey;

  String? get flutterWavePublicKey => _flutterWavePublicKey;

  String? get flutterWaveSecretKey => _flutterWaveSecretKey;

  String? get imagePath => _imagePath;

  num? get flutterDebugMode => _flutterDebugMode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['app_name'] = _appName;
    map['app_version'] = _appVersion;
    map['logo'] = _logo;
    map['map_key'] = _mapKey;
    map['currency'] = _currency;
    map['onesignal_app_id'] = _onesignalAppId;
    map['onesignal_project_number'] = _onesignalProjectNumber;
    map['onesignal_api_key'] = _onesignalApiKey;
    map['onesignal_auth_key'] = _onesignalAuthKey;
    map['help_center'] = _helpCenter;
    map['privacy_policy'] = _privacyPolicy;
    map['cookie_policy'] = _cookiePolicy;
    map['terms_services'] = _termsServices;
    map['acknowledgement'] = _acknowledgement;
    map['primary_color'] = _primaryColor;
    map['currency_sybmol'] = _currencySymbol;
    map['stripe'] = _stripe;
    map['cod'] = _cod;
    map['paypal'] = _paypal;
    map['razor'] = _razor;
    map['flutterwave'] = _flutterwave;
    map['wallet'] = _wallet;
    map['stripeSecretKey'] = _stripeSecretKey;
    map['stripePublicKey'] = _stripePublicKey;
    map['paypalClientId'] = _paypalClientId;
    map['paypalSecret'] = paypalSecret;
    map['razorPublishKey'] = _razorPublishKey;
    map['razorSecretKey'] = _razorSecretKey;
    map['flutterWavePublicKey'] = _flutterWavePublicKey;
    map['flutterWaveSecretKey'] = _flutterWaveSecretKey;
    map['imagePath'] = _imagePath;
    map['flutterDebugMode'] = _flutterDebugMode;
    return map;
  }
}
