import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/theme/app_button_style.dart';
import 'package:flutter_application_1/ui/theme/app_text_field_style.dart';
import 'package:flutter_application_1/ui/theme/colors.dart';
import 'package:flutter_application_1/ui/theme/app_text_style.dart';
import 'package:flutter_application_1/ui/widgets/auth/auth_widget_model.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final _model = AuthWidgetModel();
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
          AuthWidgetModelProvider(
            model: _model,
            child: _FormWidget(),
          ),
          const SizedBox(height: 25),
          const _RegistrationWidget()
        ],
      ),
    );
  }
}

class _RegistrationWidget extends StatelessWidget {
  const _RegistrationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple. ',
            style: AppTextStyle.mainText,
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Register',
              style: AppButtonStyle.textButton,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'If you signed up but didn`t get your verification email.',
            style: AppTextStyle.mainText,
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Verify email',
              style: AppButtonStyle.textButton,
            ),
          ),
        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = AuthWidgetModelProvider.watch(context)?.model;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Username', style: AppTextStyle.mainText),
          const SizedBox(height: 5),
          TextField(
            decoration: AppTextFieldStyle.mainTextField,
            onChanged: (value) => model?.userName = value,
          ),
          const SizedBox(height: 20),
          const Text('Password', style: AppTextStyle.mainText),
          const SizedBox(height: 5),
          TextField(
            decoration: AppTextFieldStyle.mainTextField,
            obscureText: true,
            onChanged: (value) => model?.password = value,
          ),
          if (model?.errorText != '')
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                model?.errorText ?? '',
                style: AppTextStyle.errorText,
              ),
            ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => model?.auth(context),
                style: AppButtonStyle.elevatedButton,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: AppColors.mainWhite,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 25),
              TextButton(
                onPressed: () => model?.resetPassword(context),
                child: const Text(
                  'Reset password',
                  style: AppButtonStyle.textButton,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
