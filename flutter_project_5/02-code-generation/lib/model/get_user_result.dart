import 'package:declarative_navigation/model/quote.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_result.freezed.dart';

// TODO: create a class called [GetUsersResult] using Freezed
@freezed
sealed class GetUsersResult with _$GetUsersResult {
  const factory GetUsersResult.loading() = GetUsersLoading;

  const factory GetUsersResult.loaded(List<Quote> quotes) = GetUsersLoaded;

  const factory GetUsersResult.error(String message) = GetUsersError;

  const factory GetUsersResult.nothing() = GetUsersNothing;
}
