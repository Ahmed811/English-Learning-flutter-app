import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('حول التطبيق'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Developer Info Section
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.lightBlue[50],
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.blue),
                    title: Text('معلومات المطور'),
                    subtitle: Text('نبذة عن المطور والتطبيق.'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      _showDeveloperInfoDialog(context);
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Privacy Policy Section
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.green[50],
                  child: ListTile(
                    leading: Icon(Icons.lock, color: Colors.green),
                    title: Text('سياسة الخصوصية'),
                    subtitle: Text('تعرف على سياسة الخصوصية الخاصة بنا.'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      _showPrivacyPolicyDialog(context);
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Contact Us Section
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.purple[50],
                  child: ListTile(
                    leading: Icon(Icons.contact_mail, color: Colors.purple),
                    title: Text('اتصل بنا'),
                    subtitle: Text('للاقتراحات أو الشكاوي.'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      _launchEmail();
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

// Function to show the developer info dialog
void _showDeveloperInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('معلومات المطور'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('الاسم: احمد زيدان'),
              Text('المهنة: مطور تطبيقات'),
              Text('البريد الإلكتروني: ahmedelbehiry52@gmail.com'),
              Text(
                  'نبذة: مطور ذو خبرة في تطوير تطبيقات الجوال باستخدام Flutter ولديه شغف لتقديم تطبيقات مفيدة وعملية.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('إغلاق'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _showPrivacyPolicyDialog(BuildContext context) async {
  String privacyPolicy =
      await rootBundle.loadString('assets/privacy_policy.txt');

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('سياسة الخصوصية'),
        content: SingleChildScrollView(
          child: Text(privacyPolicy),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('إغلاق'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _launchEmail() async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'ahmedelbehiry52@gmail.com', // البريد الإلكتروني للمطور
    query:
        'subject=Feedback&body=Hello, I would like to provide some feedback...', // موضوع البريد ونص الرسالة الافتراضي
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    // Handle the error if the email app is not available
    throw 'Could not launch $emailUri';
  }
}
