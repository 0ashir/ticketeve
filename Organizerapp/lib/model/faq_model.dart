class FaqModel {
  FaqModel({
    List<FaqData>? data,
    bool? success,
  }) {
    _data = data;
    _success = success;
  }

  FaqModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(
          FaqData.fromJson(v),
        );
      });
    }
    _success = json['success'];
  }

  List<FaqData>? _data;
  bool? _success;

  FaqModel copyWith({
    List<FaqData>? data,
    bool? success,
  }) =>
      FaqModel(
        data: data ?? _data,
        success: success ?? _success,
      );

  List<FaqData>? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data
          ?.map(
            (v) => v.toJson(),
          )
          .toList();
    }
    map['success'] = _success;
    return map;
  }
}

class FaqData {
  FaqData({
    num? id,
    String? question,
    String? answer,
    num? status,
  }) {
    _id = id;
    _question = question;
    _answer = answer;
    _status = status;
  }

  FaqData.fromJson(dynamic json) {
    _id = num.tryParse( json['id']);
    _question = json['question'];
    _answer = json['answer'];
    _status = num.tryParse( json['status']);
  }

  num? _id;
  String? _question;
  String? _answer;
  num? _status;

  FaqData copyWith({
    num? id,
    String? question,
    String? answer,
    num? status,
  }) =>
      FaqData(
        id: id ?? _id,
        question: question ?? _question,
        answer: answer ?? _answer,
        status: status ?? _status,
      );

  num? get id => _id;

  String? get question => _question;

  String? get answer => _answer;

  num? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['question'] = _question;
    map['answer'] = _answer;
    map['status'] = _status;
    return map;
  }
}
