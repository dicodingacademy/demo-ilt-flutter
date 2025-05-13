import 'package:declarative_navigation/model/quote.dart';

sealed class GetUsersResult {
  const GetUsersResult();

  const factory GetUsersResult.nothing() = GetUsersNothing._;
  const factory GetUsersResult.loading() = GetUsersLoading._;
  const factory GetUsersResult.loaded(List<Quote> quotes) = GetUsersLoaded._;
  const factory GetUsersResult.error(String message) = GetUsersError._;
}

final class GetUsersNothing extends GetUsersResult {
  const GetUsersNothing._();
}

final class GetUsersLoading extends GetUsersResult {
  const GetUsersLoading._();
}

final class GetUsersLoaded extends GetUsersResult {
  final List<Quote> quotes;

  const GetUsersLoaded._(this.quotes);
}

final class GetUsersError extends GetUsersResult {
  final String message;

  const GetUsersError._(this.message);
}
