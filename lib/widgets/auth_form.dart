import 'dart:io';

import 'package:app_chat_messenger/models/auth_data.dart';
import 'package:app_chat_messenger/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;
  final bool isLoading;

  AuthForm(this.onSubmit, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final AuthData _authData = AuthData();
  final GlobalKey<FormState> _form = GlobalKey();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit() {
    bool isValid = _form.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_authData.image == null && _authData.isSignup) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Adicione uma foto para concluir o cadastro'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  void _clearForm() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
    });
  }

  void _handlePickedImage(File image) {
    setState(() {
      _authData.image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  if (_authData.isSignup) UserImagePicker(_handlePickedImage),
                  if (_authData.isSignup)
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Nome'),
                      controller: _nameController,
                      key: ValueKey('name'),
                      onChanged: (value) => _authData.name = value,
                      validator: (value) {
                        if (value == null || value.trim().length < 4) {
                          return 'Nome deve ter no mínimo 4 caractéres';
                        }

                        return null;
                      },
                    ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    controller: _emailController,
                    key: ValueKey('email'),
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Email inválido. Tente novamente.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Senha'),
                    controller: _passwordController,
                    key: ValueKey('password'),
                    obscureText: true,
                    onChanged: (value) => _authData.password = value,
                    validator: (value) {
                      if (value == null || value.trim().length < 6) {
                        if (_authData.isSignup) {
                          return 'Senha deve ter no mínimo 6 caractéres';
                        } else {
                          return 'Senha inválida. Tente novamente.';
                        }
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  (widget.isLoading)
                      ? CircularProgressIndicator()
                      : SizedBox(
                          width: _size.width * 0.5,
                          child: ElevatedButton(
                            onPressed: _submit,
                            child: Text(
                                _authData.isLogin ? 'Entrar' : 'Cadastrar'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                  TextButton(
                    onPressed: () {
                      _clearForm();
                      setState(() {
                        _authData.toggleAuthMode();
                      });
                    },
                    child: Text(
                        _authData.isLogin ? 'Criar uma nova conta' : 'Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
