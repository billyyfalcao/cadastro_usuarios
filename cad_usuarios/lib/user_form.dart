import 'package:cad_usuarios/container_all.dart';
import 'package:cad_usuarios/field_form.dart';
import 'package:cad_usuarios/provider.dart';
import 'package:cad_usuarios/user.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  String title = 'Cadastro de usuario';

  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  int? _editingIndex;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Executa apenas uma vez ao entrar na tela, sem travar o build com setState
    if (!_initialized) {
      final userProvider = UserProvider.of(context);
      if (userProvider != null &&
          userProvider.indexUser != null &&
          userProvider.userSelected != null) {
        _editingIndex = userProvider.indexUser;
        final selected = userProvider.userSelected!;
        controllerName.text = selected.name;
        controllerEmail.text = selected.email;
        controllerPassword.text = selected.password;
        title = 'Editar usuario';
      }
      _initialized = true;
    }
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _save(UserProvider userProvider) {

    final isValidate = _formKey.currentState?.validate();

    if (isValidate == false) {
      return;
    }

    _formKey.currentState?.save();

    final user = User(
      name: controllerName.text,
      email: controllerEmail.text,
      password: controllerPassword.text,
    );

    if (_editingIndex != null) {
      userProvider.users[_editingIndex!] = user;
    } else {
      userProvider.users.add(user);
    }

    // Limpa a seleção para não quebrar a próxima navegação
    userProvider.userSelected = null;
    userProvider.indexUser = null;

    Navigator.popAndPushNamed(context, "/list");
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = UserProvider.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.white,
                width: 0.8,
              ),
            ),
            child: TextButton(
              child: const Text('User List', style: TextStyle(color: Colors.white)),
              onPressed: () {
                userProvider.userSelected = null;
                userProvider.indexUser = null;
                Navigator.popAndPushNamed(context, "/list");
              },
            ),
          )
        ],
      ),
      body: ContainerAll(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FieldForm(
                    label: 'Nome',
                    isPassword: false,
                    controller: controllerName,
                    isEmail: false,
                  ),
                  FieldForm(
                    label: 'email',
                    isPassword: false,
                    controller: controllerEmail,
                    isEmail: true,
                  ),
                  FieldForm(
                    label: 'senha',
                    isPassword: true,
                    controller: controllerPassword,
                    isEmail: false,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => _save(userProvider),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      child: Text(_editingIndex != null ? 'Atualizar' : 'Cadastrar'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}