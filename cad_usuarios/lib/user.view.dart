import 'package:cad_usuarios/container_all.dart';
import 'package:cad_usuarios/provider.dart';
import 'package:flutter/material.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = UserProvider.of(context);
    final user = userProvider?.userSelected;
    final index = userProvider?.indexUser;

    if (userProvider == null || user == null || index == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Usuário', style: TextStyle(color: Colors.white)),
        ),
        body: ContainerAll(
          child: Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/list'),
              child: const Text('Voltar para a lista'),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Dados do usuário',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              initialValue: user.name,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Nome'),
              
            ),
            TextFormField(
              initialValue: user.email,
              enabled: false,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            TextFormField(
              initialValue: user.password,
              enabled: false,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/create'),
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    userProvider.users.removeAt(index);
                    userProvider.userSelected = null;
                    userProvider.indexUser = null;
                    Navigator.pushReplacementNamed(context, '/list');
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Excluir'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
