import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tictactoe_battle_frontend/ui/login/login_controller.dart';
import 'package:tictactoe_battle_frontend/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final StateNotifierProvider<LoginController, LoginControllerState> _controllerProvider =
    StateNotifierProvider((ref) => LoginController(ref.watch(loginServiceProvider.notifier)));

class LoginView extends HookWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(_controllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Container(
          width: 200,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: 'ゲストID',
                  ),
                  controller: controller.loginIDController,
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return '入力必須です';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.login(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
