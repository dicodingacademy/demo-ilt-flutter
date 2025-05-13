// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Quote _$QuoteFromJson(Map<String, dynamic> json) => _Quote(
  id: json['id'] as String,
  quote: json['en'] as String,
  author: json['author'] as String,
);

Map<String, dynamic> _$QuoteToJson(_Quote instance) => <String, dynamic>{
  'id': instance.id,
  'en': instance.quote,
  'author': instance.author,
};
