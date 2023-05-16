class QuizQuestion{
  final String question;
  final List<String> options;

  const QuizQuestion(this.question, this.options);

  List<String> getShuffledOptions(){
    final shuffledList = List.of(options);
    shuffledList.shuffle();
    return shuffledList;
  }

}