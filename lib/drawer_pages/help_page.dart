import 'package:flutter/material.dart';
import 'package:zomato_project/reusable_widget/constants.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: Bold,
              fontSize: 18,
              color: blackColor),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFfafafa),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height / 20),
          const Padding(
            padding: EdgeInsets.only(left: 45),
            child: Text(
              'Get in touch!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          SizedBox(
            height: size.height / 20,
          ),
          Row(
            children: [
              SizedBox(
                width: size.width / 10,
              ),
              const Icon(
                Icons.call,
                color: Color(0XFF00b2ff),
              ),
              SizedBox(
                width: size.width / 50,
              ),
              const Text('+91 8281088823'),
            ],
          ),
          SizedBox(
            height: size.height / 30,
          ),
          Row(
            children: [
              SizedBox(
                width: size.width / 10,
              ),
              const Icon(
                Icons.mail,
                color: Color(0XFF00b2ff),
              ),
              SizedBox(
                width: size.width / 50,
              ),
              const Text('zomato@gmail.com'),
            ],
          ),
          SizedBox(
            height: size.height / 30,
          ),
          Row(
            children: [
              SizedBox(
                width: size.width / 10,
              ),
              const Icon(
                Icons.location_on,
                color: Color(0XFF00b2ff),
              ),
              SizedBox(
                width: size.width / 50,
              ),
              const Text('Zomato, Kochi, Kerala'),
            ],
          ),
        ],
      ),
    );
  }
}
