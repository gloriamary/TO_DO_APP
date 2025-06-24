import 'package:flutter/material.dart';
import 'package:todo/Presentation/screen_home.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => __ScreenSplashStateState();
}
class __ScreenSplashStateState extends State<ScreenSplash> {

  @override
  void initState()
  {
    waitSplash();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
  child: Image.network(
    'https://i.gifer.com/YCZH.gif',
    height: 600,
    width: 600,
  ),
)

    );
  }
  waitSplash() async {
    await Future.delayed(Duration(seconds:3));
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScreenHome()));

  }
}