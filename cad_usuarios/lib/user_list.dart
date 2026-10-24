import 'package:cad_usuarios/provider.dart';
import 'package:cad_usuarios/user.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = UserProvider.of(context) as UserProvider;
    List<User> users = userProvider.users;

    int UsersLenght = users.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Lista de usuarios', style: TextStyle(color: Colors.white)),
        leading: BackButton(
        color: Colors.white,
        onPressed: () {
        userProvider.userSelected = null;
        userProvider.indexUser = null; // Garante que volta limpo
        Navigator.popAndPushNamed(context, "/create");
        },
),
      ),
    
      
      body: ListView.builder(
        itemCount: UsersLenght,
        itemBuilder: (BuildContext contextBuilder, indexBuilder) =>
            Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.4,
              ),
            ),
          ),
          child: ListTile(
            title: Text(users[indexBuilder].name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    userProvider.userSelected = users[indexBuilder];
                    userProvider.indexUser = indexBuilder;
                    Navigator.popAndPushNamed(context, "/create");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.visibility, color: Colors.blue),
                  onPressed: () {
                    userProvider.userSelected = users[indexBuilder];
                    userProvider.indexUser = indexBuilder;
                    Navigator.popAndPushNamed(context, "/view");
                  },
                ),
                IconButton(
                  onPressed: () {
                  userProvider.indexUser = null;
                  userProvider.users.removeAt(indexBuilder);
                  Navigator.popAndPushNamed(context, "/create");
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                    // Ação para excluir o usuário
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}