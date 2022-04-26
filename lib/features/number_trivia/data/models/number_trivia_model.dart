import 'package:clean_code_architecture/features/number_trivia/domain/entites/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({required String text, required int number})
      : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> map) =>
      NumberTriviaModel(
          text: map['text'], number: (map['number'] as num).toInt());

  Map<String, dynamic> toJson() => {'text': text, 'number': number};
}
