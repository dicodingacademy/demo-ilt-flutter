sealed class PageConfiguration {}

final class SplashPageConfiguration extends PageConfiguration {}

final class LoginPageConfiguration extends PageConfiguration {}

final class RegisterPageConfiguration extends PageConfiguration {}

final class HomePageConfiguration extends PageConfiguration {}

final class DialogPageConfiguration extends PageConfiguration {
  final (String, String) dialogParam;

  DialogPageConfiguration(this.dialogParam);
}

final class DetailQuotePageConfiguration extends PageConfiguration {
  final String? quoteId;

  DetailQuotePageConfiguration(this.quoteId);
}

final class UnknownPageConfiguration extends PageConfiguration {}
