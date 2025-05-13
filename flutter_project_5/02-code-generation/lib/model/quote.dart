import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote.g.dart';
part 'quote.freezed.dart';

// TODO: create a class called [Quote] using Freezed
@freezed
abstract class Quote with _$Quote {
  const factory Quote({
    required String id,
    // check the json key name
    // if the key name is different from the field name
    // you can use the @JsonKey annotation to specify the key name
    // for example: @JsonKey(name: 'en')
    @JsonKey(name: 'en') required String quote,
    required String author,
  }) = _Quote;

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
}
