import 'package:flutter/material.dart';
import 'package:wheather/db/sharedservice.dart';
import 'package:wheather/screens/home.dart';
import 'package:wheather/screens/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
bool isloading=false;



  void regdetails() async{
setState(() {
  isloading=true;
});
await Spservice().addData(_nameController.text,_emailController.text,_passwordController.text,_confirmPasswordController.text);
if(context.mounted){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successful')));
  Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage1(),));
}
setState(() {
  isloading=false;
});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_passwordController.text == _confirmPasswordController.text) {
                  regdetails();
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage1(),
                      ),
                    );
                  } else {
                    // Passwords do not match, show error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Passwords do not match!'),
                      ),
                    );
                  }
                },
                child: Text('Register'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
