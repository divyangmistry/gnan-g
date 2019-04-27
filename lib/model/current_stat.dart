class CurrentState {
  int questionSt;
  int level;
  int score;
  bool completed;
  int mhtId;
  int totalQuestions;
  String updatedAt;
  String createdAt;
  bool fifty_fifty;
  int questionReadSt;

  CurrentState({
    this.questionSt,
    this.level,
    this.score,
    this.completed,
    this.mhtId,
    this.totalQuestions,
    this.updatedAt,
    this.createdAt,
    this.fifty_fifty,
    this.questionReadSt,
  });

  CurrentState.fromJson(Map<String, dynamic> json) {
    questionSt = json['question_st'];
    level = json['level'];
    score = json['score'];
    completed = json['completed'];
    mhtId = json['mht_id'];
    totalQuestions = json['total_questions'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    fifty_fifty = json['fifty_fifty'];
    questionReadSt = json['question_read_st'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_st'] = this.questionSt;
    data['level'] = this.level;
    data['score'] = this.score;
    data['completed'] = this.completed;
    data['mht_id'] = this.mhtId;
    data['total_questions'] = this.totalQuestions;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['fifty_fifty'] = this.fifty_fifty;
    data['question_read_st'] = this.questionReadSt;
    return data;
  }

  @override
  String toString() {
    return 'Current{questionSt: $questionSt, level: $level, score: $score, completed: $completed, mhtId: $mhtId, totalQuestions: $totalQuestions, fiftyFifty:$fifty_fifty, questionReadSt:$questionReadSt, updatedAt: $updatedAt, createdAt: $createdAt}';
  }
}
