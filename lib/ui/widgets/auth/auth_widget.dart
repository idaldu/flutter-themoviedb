import 'package:flutter/material.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your account'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 25),
          _FormWidget(),
          const SizedBox(height: 25),
          Column(
            children: [
              const Text(
                'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple. ',
              ),
              TextButton(onPressed: () {}, child: const Text('Register'))
            ],
          )
        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const textFieldDecorator = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      isCollapsed: true,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Username'),
          const SizedBox(height: 5),
          const TextField(
            decoration: textFieldDecorator,
          ),
          const SizedBox(height: 20),
          const Text('Password'),
          const SizedBox(height: 5),
          const TextField(decoration: textFieldDecorator),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
              const SizedBox(width: 25),
              TextButton(
                onPressed: () {},
                child: const Text('Reset password'),
              )
            ],
          )
        ],
      ),
    );
  }
}
