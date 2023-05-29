import 'package:flutter/material.dart';
import 'package:insta_pay/organization_page.dart';
import 'components/pay_page_button.dart';

class OptionsPayPage extends StatelessWidget {

  const OptionsPayPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Who do you want to pay?',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w400,
            ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            PayButton(
              headingText: 'Pay Now!',
              subText: 'Make instant Payment to clear your bills.',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) =>  const OrganizationPage()),),);
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            const SizedBox(
              height: 25.0,
            ),
            const SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
