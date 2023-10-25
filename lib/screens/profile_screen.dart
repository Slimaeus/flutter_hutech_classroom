import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserStore _userStore;

  @override
  void initState() {
    super.initState();
    _userStore = context.read<UserStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: widget.title, hasLeading: true),
      endDrawer: customDrawer(context),
      body: SingleChildScrollView(
        child: Observer(builder: (context) {
          return Column(
            children: [
              Text(
                '${_userStore.user.userName ?? 'N/A'} - ${_userStore.user.lastName ?? 'N/A'} ${_userStore.user.firstName ?? 'N/A'}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          );
        }),
      ),
    );
  }
}
