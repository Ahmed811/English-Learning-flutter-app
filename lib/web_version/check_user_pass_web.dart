import 'package:english_sentences/web_version/home_page_web.dart';
import 'package:flutter/material.dart';

class CheckUserAndPass extends StatefulWidget {
  const CheckUserAndPass({super.key});

  @override
  State<CheckUserAndPass> createState() => _CheckUserAndPassState();
}

class _CheckUserAndPassState extends State<CheckUserAndPass> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // دالة التحقق من صحة اليوزرنيم والباسوورد
  void _checkCredentials() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == 'zidan811' && password == '11223344') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('تم التحقق'),
          content: Text('تم تسجيل الدخول بنجاح!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreenWeb())),
              child: Text(
                'دخول',
                style: TextStyle(fontSize: 18, fontFamily: "bahja"),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('خطأ'),
          content: Text('اليوزرنيم أو الباسوورد غير صحيح!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('حسناً'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width * .4,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ادخل معلومات الدخول",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'اليوزرنيم',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'الباسوورد',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _checkCredentials,
                child: Text('تسجيل الدخول'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
