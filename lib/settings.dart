import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsPage extends StatefulWidget {
  final String userId;

  SettingsPage({required this.userId});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String newName, newDOB, newEmail, newPassword, newCardName, newCardNumber, newCardPin;
  
  void updateName() async {
    newName = await _showDialog('Change Name', 'Enter new name');
    // Update in Firebase
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({'Name': newName});
  }

  void updateDOB() async {
    newDOB = await _showDialog('Change Date of Birth', 'Enter new date of birth');
    // Update in Firebase
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({'DOB': newDOB});
  }

  void updateEmail() async {
    newEmail = await _showDialog('Change Email Address', 'Enter new email address');
    // Update in Firebase
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({'Email': newEmail});
  }

  void updatePassword() async {
    newPassword = await _showDialog('Change Password', 'Enter new password');
    // Update in Firebase
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({'Password': newPassword});
  }

  void updateCardDetails() async {
    newCardName = await _showDialog('Change Card Name', 'Enter new card name');
    newCardNumber = await _showDialog('Change Card Number', 'Enter new card number');
    newCardPin = await _showDialog('Change Card Pin', 'Enter new card pin');
    // Update in Firebase
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({'CardName': newCardName, 'CardNumber': newCardNumber, 'CardPin': newCardPin});
  }

  Future<String> _showDialog(String title, String content) async {
    String? newData;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: TextFormField(
          decoration: InputDecoration(hintText: content),
          onChanged: (value) {
            newData = value;
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Save'),
            onPressed: () => Navigator.pop(context, newData),
          ),
        ],
      ),
    );
    return newData ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Change Name'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: updateName,
            ),
          ),
          ListTile(
            title: Text('Change Date of Birth'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: updateDOB,
            ),
          ),
          ListTile(
            title: Text('Change Email-Address'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: updateEmail,
            ),
          ),
          ListTile(
            title: Text('Change Password'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: updatePassword,
            ),
          ),
          ListTile(
            title: Text('Change Debit/Credit Card Details'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: updateCardDetails,
            ),
          ),
        ],
      ),
    );
  }
}
