import 'package:declarative_navigation/controller/auth_controller.dart';
import 'package:declarative_navigation/model/quote.dart';
import 'package:declarative_navigation/widget/paginated_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuotesListScreen extends StatelessWidget {
  final Function(Quote) onTapped;
  final Function() onLogout;
  final Function(String, String) onShowDialog;

  const QuotesListScreen({
    Key? key,
    required this.onTapped,
    required this.onLogout,
    required this.onShowDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed:
                () => onShowDialog("Info", "This is a message to Dialog Page."),
          ),
        ],
      ),
      body: PaginatedListView(onTapped: onTapped),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final authRead = context.read<AuthController>();
          final result = await authRead.logout();
          if (result) onLogout();
        },
        tooltip: "Logout",
        child: Consumer<AuthController>(
          builder: (context, value, child) {
            return value.isLoadingLogout
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.logout);
          },
        ),
      ),
    );
  }
}
