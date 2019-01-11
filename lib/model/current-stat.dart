class CurrentState {
  String userMobile;
  int queSt;
  int level;
  int score;
  int lives;
  int currentScore;
  bool completed;
  String updatedAt;
  int totalQues;

  CurrentState(
      {this.userMobile,
        this.queSt,
        this.level,
        this.score,
        this.lives,
        this.currentScore,
        this.completed,
        this.updatedAt,
        this.totalQues});

  CurrentState.fromJson(Map<String, dynamic> json) {
    userMobile = json['user_mobile'];
    queSt = json['que_st'];
    level = json['level'];
    score = json['score'];
    lives = json['lives'];
    currentScore = json['current_score'];
    completed = json['completed'];
    updatedAt = json['updatedAt'];
    totalQues = json['total_ques'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_mobile'] = this.userMobile;
    data['que_st'] = this.queSt;
    data['level'] = this.level;
    data['score'] = this.score;
    data['lives'] = this.lives;
    data['current_score'] = this.currentScore;
    data['completed'] = this.completed;
    data['updatedAt'] = this.updatedAt;
    data['total_ques'] = this.totalQues;
    return data;
  }

  @override
  String toString() {
    return 'Current{userMobile: $userMobile, queSt: $queSt, level: $level, score: $score, lives: $lives, currentScore: $currentScore, completed: $completed, updatedAt: $updatedAt, totalQues: $totalQues}';
  }


}