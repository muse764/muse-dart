import 'package:muse_api/muse_api.dart';

Future<void> main() async {
  var muse = Muse();
  var users = await muse.getUsers();
  print(users);

  // var user = await muse.getUser('78a43e1d7789efb73d60c82cea23a3ee7007e6b3ce3e');
  // print(user);

  // var newUser =
  //     await muse.createUser('mubareksd@gmail.com', 'mubareksd', 'pass');
  // print(newUser);
}
