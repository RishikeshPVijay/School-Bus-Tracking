import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/models/ssb_user.dart';
import 'package:smart_school_bus/pages/ssb_page.dart';
import 'package:smart_school_bus/services/authentication_service.dart';

class SSBDashboardPageWithUser extends StatelessWidget {
  final Widget Function(SSBUser user) builder;
  final String? appBarTitle;
  final bool isPadded;
  final Color backgroundColor;
  SSBDashboardPageWithUser({
    Key? key,
    required this.builder,
    this.appBarTitle,
    this.isPadded = true,
    this.backgroundColor = const Color.fromRGBO(249, 250, 252, 1.0),
  }) : super(key: key);

  static final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();

  final Stream<DocumentSnapshot<Map<String, dynamic>>> stream =
      _authenticationService.getUserStream();

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
      body: StreamBuilder<DocumentSnapshot>(
        stream: stream,
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting ||
              !userSnapshot.hasData) {
            return SSBPage(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            );
          }

          final userData = userSnapshot.data;
          SSBUser user = SSBUser(
            name: userData?['name'],
            email: userData?['email'],
            userType:
                UserType.getUserTypeFromShortString(userData?['user_type']),
          );
          return Container(
            color: backgroundColor,
            padding:
                isPadded ? const EdgeInsets.symmetric(horizontal: 30.0) : null,
            child: builder(user),
          );
        },
      ),
    );
  }
}
