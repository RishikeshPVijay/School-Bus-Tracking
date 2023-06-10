import 'package:flutter/material.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/services/authentication_service.dart';

class SSBDashboardPage extends StatelessWidget {
  final Widget body;
  final String? appBarTitle;
  final bool isPadded;
  final Color backgroundColor;
  SSBDashboardPage({
    Key? key,
    required this.body,
    this.appBarTitle,
    this.isPadded = true,
    this.backgroundColor = const Color.fromRGBO(249, 250, 252, 1.0),
  }) : super(key: key);

  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();
  void logout() {
    _authenticationService.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          appBarTitle ?? 'Smart School Bus',
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'logout') {
                logout();
              }
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(width: 8.0),
                    const Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
        padding: isPadded ? const EdgeInsets.symmetric(horizontal: 30.0) : null,
        child: body,
      ),
    );
  }
}
