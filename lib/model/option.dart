class Options {
  int optionNumber;
  String option;

  Options({this.optionNumber, this.option});

  Options.fromJson(Map<String, dynamic> json) {
    optionNumber = json['option_number'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_number'] = this.optionNumber;
    data['option'] = this.option;
    return data;
  }

  @override
  String toString() {
    return 'Options{optionNumber: $optionNumber, option: $option}';
  }


}