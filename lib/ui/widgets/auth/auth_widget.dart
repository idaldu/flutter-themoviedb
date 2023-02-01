import 'package:flutter/material.dart';
import 'package:flutter_application_1/library/widgets/inherited/notifier_provider.dart';
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
    final model = NotifierProvider.read<AuthWidgetModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Username', style: AppTextStyle.mainText),
          const SizedBox(height: 5),
          TextField(
            decoration: AppTextFieldStyle.mainTextField,
            controller: model?.userNameTextController,
          ),
          const SizedBox(height: 20),
          const Text('Password', style: AppTextStyle.mainText),
          const SizedBox(height: 5),
          PasswordTextFieldWidget(model: model),
          const _ErrorMessageWidget(),
          Row(
            children: [
              const _AuthButtonWidget(),
              const SizedBox(width: 25),
              TextButton(
                onPressed: () {},
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

class PasswordTextFieldWidget extends StatelessWidget {
  const PasswordTextFieldWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final AuthWidgetModel? model;

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthWidgetModel>(context);
    return TextField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          isCollapsed: true),
      obscureText: false,
      controller: model?.passwordTextController,
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthWidgetModel>(context);
    final child = model?.isAuthProgress == true
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: AppColors.mainWhite,
              strokeWidth: 3,
            ),
          )
        : const Text('Login',
            style: TextStyle(
              color: AppColors.mainWhite,
              fontSize: 15,
            ));
    final onPressed =
        model?.canStartAuth == true ? () => model?.auth(context) : null;
    return ElevatedButton(
      onPressed: onPressed,
      style: AppButtonStyle.elevatedButton,
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget();

  @override
  Widget build(BuildContext context) {
    final errorMessage =
        NotifierProvider.watch<AuthWidgetModel>(context)?.errorMessage;
    if (errorMessage == null) return const SizedBox(height: 25);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        errorMessage,
        style: AppTextStyle.errorText,
      ),
    );
  }
}
