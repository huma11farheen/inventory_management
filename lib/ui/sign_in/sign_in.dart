import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_management/ui/login_page/login_page.dart';
import 'package:provider/provider.dart';

import 'controller.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/signinPage';
  static Widget wrapped() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignInController(
            context.read(),
            context.read(),
          ),
        ),
      ],
      child: SignInPage(),
    );
  }

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInInformation extends StatelessWidget {
  final Function(String) userNameValue;
  final Function(String) password;

  const _SignInInformation(
      {Key key, @required this.userNameValue, @required this.password})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SignInController>().value;
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BuildInputField(
            label: 'UserName',
            icon: const Icon(Icons.person),
            onChanged: userNameValue,
            error: vm.username,
          ),
          _BuildInputField(
            label: 'password',
            icon: const Icon(Icons.remove_red_eye),
            onChanged: password,
            error: vm.password,
          ),
        ],
      ),
    );
  }
}

class _BuildInputField extends StatelessWidget {
  const _BuildInputField({
    Key key,
    @required this.label,
    @required this.icon,
    @required this.onChanged,
    this.error,
  }) : super(key: key);
  final String label;
  final Widget icon;
  final Function(String) onChanged;
  final Validation error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(prefixIcon: icon, labelText: label),
        ),
        const SizedBox(
          height: 2,
        ),
        if (error != Validation.valid)
          Text(
            'Please input $label',
            style: const TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}

class _SignInPageState extends State<SignInPage> {
  bool animate = false;
  String _password;
  String _username;
  @override
  void initState() {
    super.initState();

    Future<dynamic>.delayed(const Duration(milliseconds: 500)).then(
      (dynamic e) => setState(
        () {
          animate = true;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignInController>();
    final vm = controller.value;
    final valid =
        vm.username == Validation.valid && vm.password == Validation.valid;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff2f3f7),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topRight,
                  radius: 1.5,
                  colors: <Color>[
                    Color(0xff33CEFF),
                    Color(0xff30AAFF),
                  ],
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.22,
                width: MediaQuery.of(context).size.width * 0.36,
                child: SvgPicture.asset(
                  'images/analytics.svg',
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _NextButtonAndAgreement(
                onTap: valid
                    ? () {
                        controller.signIn(
                            username: _username, password: _password);
                      }
                    : null,
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              bottom: animate ? 96 * 2.0 : -56 * 8.0,
              left: 16,
              right: 16,
              child: Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 9,
                      blurRadius: 8,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.26,
                width: MediaQuery.of(context).size.width * 0.9,
                child: _SignInInformation(
                  password: (value) {
                    _password = value;
                    controller.setPassword(value);
                  },
                  userNameValue: (value) {
                    _username = value;
                    controller.setUserName(value);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextButtonAndAgreement extends StatelessWidget {
  const _NextButtonAndAgreement({
    Key key,
    @required this.onTap,
  }) : super(key: key);
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const RadialGradient(
                  center: Alignment.topRight,
                  radius: 1.5,
                  colors: <Color>[
                    Color(0xff33CEFF),
                    Color(0xff30AAFF),
                  ],
                ),
              ),
              child: const Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const _BottomTextBox(),
        ],
      ),
    );
  }
}

class _BottomTextBox extends StatelessWidget {
  const _BottomTextBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: 'Dont have an account? ',
            style: const TextStyle(color: Colors.black, fontSize: 20),
            children: <TextSpan>[
              TextSpan(
                text: 'Sign up',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, SignUpPage.routeName);
                  },
                style: const TextStyle(color: Colors.blueAccent, fontSize: 18),
              )
            ],
          ),
        ),
      ],
    );
  }
}
