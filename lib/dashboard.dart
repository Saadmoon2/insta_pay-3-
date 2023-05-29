import 'package:flutter/material.dart';
import 'package:insta_pay/components/my_drawer_header.dart';
import 'package:insta_pay/settings.dart';
import 'components/top_bar.dart';
import 'components/dashboard_button.dart';
import 'options_pay.dart';
import 'wallet/wallet.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.id});

  final String? id;

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  _Dashboard();
  String? id;
  String personName = 'NULL';
  String imageURL = 'NULL';
  String email = 'NULL';
  bool isloading = true;
  late int amount;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final documentReference = FirebaseFirestore.instance.collection('users');

  Future getUserData() async {
    Map<String, dynamic>? userData = {};

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get()
          .then((value) {
        userData = value.data();
        personName = userData?['Name'];
        imageURL = userData?['imageURL'];
        email = userData?['Email'];

        setState(
          () {
            isloading = false;
          },
        );
      });
    } on FirebaseException catch (e) {
      return;
    }
  }

  @override
  void initState() {
    id = widget.id;
    getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: Column(
          children: [
            MyHeaderDrawer(
              imageURL: imageURL,
              name: personName,
              email: email,
            ),
          ],
        )),
        key: _scaffoldKey,
        backgroundColor: Colors.grey[200],
        body: isloading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.blue[900],
                ),
              )
            : SafeArea(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopBar(
                          scaffoldKey: _scaffoldKey,
                          name: personName,
                          imageURL: imageURL,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                            ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DashboardButton(
                                  imagePath: 'assets/images/pay.png',
                                  buttonName: 'Organisation',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) =>
                                            const OptionsPayPage()),
                                      ),
                                    );
                                  },
                                ),
                                DashboardButton(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WalletPage(),
                                        ),
                                      );
                                    },
                                    buttonName: 'Wallet',
                                    imagePath:
                                        'assets/images/payment_gateway.png'),
                              ],
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DashboardButton(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SettingsPage(userId: id!,),
                                        ),
                                      );
                                    },
                                    buttonName: 'Settings',
                                    imagePath: 'assets/images/settings.png'),
                                DashboardButton(
                                    onTap: () {
                                      _showAboutUsBottomSheet(context);
                                    },
                                    buttonName: 'About us',
                                    imagePath: 'assets/images/about_us.png')
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ));
  }

  void _showAboutUsBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "About Us",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Insta Pay was created by Muhammad Saad and Syed Moosa. Its aim is to bring all the payments at one place.",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        });
  }
}
