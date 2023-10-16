import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserStore _userStore;

  @override
  void initState() {
    super.initState();
    _userStore = context.read<UserStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: const Text('Cài đặt'),
            ),
            ListTile(
              title: Observer(builder: (context) {
                return Row(
                  children: [
                    const Text("Sinh viên: "),
                    Text(_userStore.user.userName ?? 'Bạn chưa đăng nhập'),
                  ],
                );
              }),
            ),
            ListTile(
              title: FloatingActionButton(
                heroTag: "LogButton",
                child: Builder(builder: (context) {
                  return Text(
                      _userStore.user.id != null ? 'Đăng xuất' : 'Đăng nhập');
                }),
                onPressed: () {
                  if (_userStore.user.id != null) {
                    _userStore.resetValue();
                  }
                  Navigator.pushReplacementNamed(context, RouteManager.login);
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 70),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Chào mừng bạn đã trở lại!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
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
                Image.asset(
                  'assets/images/pic1_Data-analysis-amico.png',
                  height: 350,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Xử lý khi nút "Xem Bảng Điểm" được nhấn
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  minimumSize: const Size(200, 200),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.table_chart,
                                      size: 50,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Xem Bảng Điểm',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Xử lý khi nút "Scan Kiểm Tra" được nhấn
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  minimumSize: const Size(200, 200),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.check_box,
                                      size: 50,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Scan Kiểm Tra',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
