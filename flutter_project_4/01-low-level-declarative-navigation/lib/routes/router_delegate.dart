import 'package:declarative_navigation/model/page_configuration.dart';
import 'package:declarative_navigation/model/quote.dart';
import 'package:declarative_navigation/provider/auth_provider.dart';
import 'package:declarative_navigation/routes/page/dialog_page.dart';
import 'package:declarative_navigation/screen/screen.dart';
import 'package:flutter/material.dart';

class MyRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthProvider authProvider;

  bool? isUnknown;

  MyRouterDelegate(this.authProvider)
    : _navigatorKey = GlobalKey<NavigatorState>();

  _init() async {
    await Future.delayed(const Duration(seconds: 1));
    isLoggedIn = await authProvider.checkIsLoggedIn();
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  String? selectedQuote;

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  (String, String) dialogParam = ("", "");

  @override
  Widget build(BuildContext context) {
    if (isUnknown == true) {
      historyStack = _unknownStack;
    } else if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }
    if (dialogParam.$1.isNotEmpty &&
        dialogParam.$2.isNotEmpty &&
        isLoggedIn != null) {
      /// DialogPage is not in the stack
      /// because it is not a part of the navigation stack
      /// but a part of the history stack
      /// so we need to add it to the history stack
      historyStack.add(dialogPage(dialogParam.$1, dialogParam.$2));
    }
    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onDidRemovePage: (page) {
        if (page.key == ValueKey(selectedQuote)) {
          selectedQuote = null;
          notifyListeners();
        }
        if (isRegister) {
          isRegister = false;
          notifyListeners();
        }
        if (page.key == const ValueKey("Dialog")) {
          dialogParam = ("", "");
          notifyListeners();
        }
      },
    );
  }

  @override
  PageConfiguration? get currentConfiguration {
    if (isLoggedIn == null) {
      return SplashPageConfiguration();
    } else if (dialogParam.$1.isNotEmpty && dialogParam.$2.isNotEmpty) {
      return DialogPageConfiguration(dialogParam);
    } else if (isRegister == true) {
      return RegisterPageConfiguration();
    } else if (isLoggedIn == false) {
      return LoginPageConfiguration();
    } else if (isUnknown == true) {
      return UnknownPageConfiguration();
    } else if (selectedQuote == null) {
      return HomePageConfiguration();
    } else if (selectedQuote != null) {
      return DetailQuotePageConfiguration(selectedQuote!);
    } else {
      return null;
    }
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    switch (configuration) {
      case UnknownPageConfiguration():
        isUnknown = true;
        isRegister = false;
        break;
      case RegisterPageConfiguration():
        isRegister = true;
        break;
      case DialogPageConfiguration():
        dialogParam = configuration.dialogParam;
        break;
      case HomePageConfiguration() ||
          LoginPageConfiguration() ||
          SplashPageConfiguration():
        isUnknown = false;
        selectedQuote = null;
        isRegister = false;
        break;
      case DetailQuotePageConfiguration():
        isUnknown = false;
        isRegister = false;
        selectedQuote = configuration.quoteId.toString();
        break;
    }

    notifyListeners();
  }

  List<Page> get _unknownStack => const [
    MaterialPage(key: ValueKey("UnknownPage"), child: UnknownScreen()),
  ];

  List<Page> get _splashStack => [
    MaterialPage(
      key: const ValueKey("SplashScreen"),
      child: SplashScreen(
        onSplash: () {
          _init();
        },
      ),
    ),
  ];

  List<Page> get _loggedOutStack => [
    MaterialPage(
      key: const ValueKey("LoginPage"),
      child: LoginScreen(
        onLogin: () {
          isLoggedIn = true;
          notifyListeners();
        },
        onRegister: () {
          isRegister = true;
          notifyListeners();
        },
        onShowDialog: (String title, String message) {
          dialogParam = (title, message);
          notifyListeners();
        },
      ),
    ),
    if (isRegister == true)
      MaterialPage(
        key: const ValueKey("RegisterPage"),
        child: RegisterScreen(
          onRegister: () {
            isRegister = false;
            notifyListeners();
          },
          onLogin: () {
            isRegister = false;
            notifyListeners();
          },
        ),
      ),
  ];

  List<Page> get _loggedInStack => [
    MaterialPage(
      key: const ValueKey("QuotesListPage"),
      child: QuotesListScreen(
        quotes: quotes,
        onTapped: (String quoteId) {
          selectedQuote = quoteId;
          notifyListeners();
        },
        onLogout: () {
          isLoggedIn = false;
          notifyListeners();
        },
        onShowDialog: (String title, String message) {
          dialogParam = (title, message);
          notifyListeners();
        },
      ),
    ),
    if (selectedQuote != null)
      MaterialPage(
        key: ValueKey(selectedQuote),
        child: QuoteDetailsScreen(quoteId: selectedQuote!),
      ),
  ];

  Page dialogPage(String title, String message) => DialogPage(
    title: title,
    message: message,
    onOk: () {
      dialogParam = ("", "");
      notifyListeners();
    },
  );
}
