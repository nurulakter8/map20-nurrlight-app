


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/homeScreen/aboutScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: <Widget>[
                Text('Welcome to Nurr Light!', style: Theme.of(context).textTheme.bodyText1,),
              ],
            ),
            SizedBox(height: 20),
            Wrap(
              children: <Widget>[
                Text('These Terms of Use govern your use of Nurr Light and provide information about the Nurr Light Service, outlined below. When you create an Nurr Light account or use Nurr Light, you agree to these terms. ',
                 style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.clip, ),
              ],
            ),
            SizedBox(height: 19),
            Wrap(
              children: <Widget>[
                Text('The Data Policy', style: Theme.of(context).textTheme.bodyText1,),
              ],
            ),
            SizedBox(height: 10),
            Wrap(
              children: <Widget>[
                Text('Providing our Service requires collecting and using your information.The Data'
                'Policy explains how we collect, use, and share information across other Products. It also'
                 'explains the many ways you can control your information, including in the Nurr Light Privacy and Security'
                 'Settings. You must agree to the Data Policy to use Nurr Light. ',
                 style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.clip, ),
              ],
            ),
            SizedBox(height: 20),
            Wrap(
              children: <Widget>[
                Text('Your Commitments', style: Theme.of(context).textTheme.bodyText1,),
              ],
            ),
            SizedBox(height: 10),
            Wrap(
              children: <Widget>[
                Text('In return for our commitment to provide the Service, we require you to make the below commitments to us.',
                 style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.clip, ),
              ],
            ),
            SizedBox(height: 10),
            Wrap(
              children: <Widget>[
                Text('Who Can Use Nurr Light. We want our Service to be as open and inclusive as possible, but we also want it to be safe,'
                'secure, and in accordance with the law. So, we need you to commit to a few restrictions in order to be part of the Nurr Light'
                'community. You must be at least 13 years old. You must not be prohibited from receiving any aspect of our Service under'
                'applicable laws or engaging in payments related Services if you are on an applicable denied party listing.'
                'We must not have previously disabled your account for violation of law or any of our policies. You must not be a convicted sex offender.',
                 style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.clip, ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}