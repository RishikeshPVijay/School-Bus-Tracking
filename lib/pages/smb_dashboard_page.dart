import 'package:flutter/material.dart';

class SMBDashboardPage extends StatelessWidget {
  final Widget body;
  final String appBarTitle;
  const SMBDashboardPage({
    Key? key,
    required this.body,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.red,
            expandedHeight: 130.0,
            collapsedHeight: 65.0,
            pinned: true,
            centerTitle: false,
            actions: [
              DropdownButton(
                underline: Container(),
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                        ),
                        SizedBox(width: 8.0),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
                onChanged: (itemValue) {
                  if (itemValue == 'logout') {
                    // logout();
                  }
                },
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(14.0),
              title: Text(
                appBarTitle,
                style: const TextStyle(
                  height: 1.4,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 18.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
