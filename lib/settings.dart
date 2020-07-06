
import 'package:flutter/material.dart';
import 'package:my_first_app/accountdetails.dart';
import 'package:my_first_app/commonComponents/customDrawer.dart';
import 'package:my_first_app/updatepassword.dart';

import 'commonComponents/customRow.dart';

class SettingScreen extends StatelessWidget {
  final String uid;
  SettingScreen({this.uid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        context: context,
        uid: uid,
        current: "Settings",
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: 25,
          ),

          //AccountDetails
          CustomRow(
            iconData: Icons.info_outline,
            title: 'Change Username',
            route: AccountDetailsScreen(uid:uid),

          ),

          //ForgetPassword
          CustomRow(
            iconData: Icons.vpn_key,
            title: 'Change Password',
            route: UpdatePasswordScreen(uid:uid),
          ),

          //Terms&Condition
          CustomRow(
            iconData: Icons.content_copy,
            title: 'Terms & Conditions',
            link: "http://www.calmascent.com/terms",
          ),

//PrivacyPolicy
          CustomRow(
            iconData: Icons.pan_tool,
            title: 'Privacy Policy',
            link: "http://www.calmascent.com/privacy",
          ),

          //VisitUs
          CustomRow(
            iconData: Icons.launch,
            title: 'Visit Our Website',
            link: "http://www.calmascent.com",
          ),
        ],
      ),
    );
  }
}