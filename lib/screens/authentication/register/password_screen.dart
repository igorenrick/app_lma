import 'package:app_lma/screens/authentication/register/verify_email_screen.dart';
import 'package:app_lma/services/auth_service.dart';
import 'package:app_lma/widgets/square_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PasswordScreen extends StatefulWidget {
  final String registration;
  final String email;
  final String name;
  final String surname;
  const PasswordScreen({
    Key? key,
    required this.registration,
    required this.email,
    required this.name,
    required this.surname,
  }) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  late TextEditingController _controller;
  bool isLoading = false;

  register(AuthService auth) async {
    try {
      setState(() {
        isLoading = true;
      });
      await context
          .read<AuthService>()
          .register(widget.email, _controller.text);

      print(auth.user);
      //add new user to cloud firestore
      FirebaseFirestore db = FirebaseFirestore.instance;

      final user = <String, dynamic>{
        'authId': auth.user?.uid,
        'registration': widget.registration,
        'name': widget.name,
        'surname': widget.surname,
        'enabled': true,
        'attribution': null,
        'createdAt': Timestamp.now(),
      };

      // Add a new document with a generated ID
      await db.collection('users').add(user).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conta criada com sucesso!'),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyEmailScreen(email: widget.email),
        ),
        ModalRoute.withName('/verifyemail'),
      );
    } on AuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 93, 153, 150),
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.west,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 24),
                  child: Text(
                    'Nova Conta',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 12),
                  child: Text(
                    'Senha',
                    style: TextStyle(
                      color: Color.fromARGB(255, 142, 142, 147),
                      fontFamily: 'Roboto',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    obscureText: true,
                    cursorColor: const Color.fromARGB(255, 126, 205, 201),
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Minha senha',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 142, 142, 147),
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            isLoading
                ? const Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 126, 205, 201),
                      ),
                    ),
                  )
                : SquareButton(
                    label: 'Criar Conta',
                    onPressed: () {
                      register(auth);
                    },
                    backgroundColor: const Color.fromARGB(255, 126, 205, 201),
                    bottom: true,
                  ),
          ],
        ),
      ),
    );
  }
}
