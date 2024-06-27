import 'package:contact_app_gita/bloc/login/login_bloc.dart';
import 'package:contact_app_gita/cons/text_steles.dart';
import 'package:contact_app_gita/ui/add/add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_bloc.dart';
import '../cons/app_icons.dart';
import '../data/UserData.dart';
import 'login/login.dart';
import 'update.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UserData> contacts = [];

  @override
  void initState() {
    // _homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadContacts()),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Contacts",
                  style: TextSteles.defult,
                ),
                GestureDetector(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext c) {
                          return Dialog(child: logoutUi(context));
                        });
                  },
                  child: Image.asset(
                    AppIcons.logout,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Stack(
            children: [
              BlocConsumer<HomeBloc, HomeState>(builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeError) {
                  return Center(child: Text("Error: ${state.error}"));
                } else if (state is HomeSuccess) {
                  return ListView.separated(
                    separatorBuilder: (_, __) {
                      return const Divider(height: 2, color: Colors.grey);
                    },
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) {
                      var contact = state.contacts[index];
                      return BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return contactItems(context, contact.id!,
                              contact.name, contact.number);
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("No contacts available"));
                }
              }, listener: (context, state) {
                if (state is HomeError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: ${state.error}")));
                } else if (state is DeleteSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Contact deleted successfully")));
                  context.read<HomeBloc>().add(LoadContacts());
                } else if (state is LogOutState) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                } else if (state is UnRegisterState) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                }
              }),
              Positioned(
                bottom: 40,
                right: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Add()),
                      );
                    },
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      AppIcons.add,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget contactItems(BuildContext context, int id, String name, String number) =>
    SizedBox(
      height: 80,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.network(
              AppIcons.icons1,
              height: 50,
              width: 50,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                number,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          Expanded(child: Container()),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz_rounded),
            onSelected: (value) async {
              if (value == 'Edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Update(
                      id: id,
                      initialName: name,
                      initialNumber: number,
                    ),
                  ),
                );
              } else if (value == 'Delete') {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(child: delete(id, name, context));
                    });
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Edit', 'Delete'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
    );

// Widget contact() {
//   return StreamBuilder<List<UserData>>(
//     stream: FirebaseManager().getContacts(),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (snapshot.hasError) {
//         return Center(child: Text("Error: ${snapshot.error}"));
//       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//         return const Center(child: Text("No contacts available"));
//       } else {
//         return ListView.separated(
//           separatorBuilder: (_, __) {
//             return const Divider(height: 2, color: Colors.grey);
//           },
//           itemCount: snapshot.data!.length,
//           itemBuilder: (context, index) {
//             var contact = snapshot.data![index];
//             return contactItems(
//                 context, contact.id, contact.name, contact.phone);
//           },
//         );
//       }
//     },
//   );
// }

Widget delete(int id, String name, BuildContext context) => Container(
      height: 200,
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.delete_forever, color: Colors.red, size: 36),
              const Spacer(),
              const Text(
                "Delete contact",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const Spacer(),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      color: Colors.red,
                      child:
                          const Icon(Icons.close_sharp, color: Colors.white)))
            ],
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              text: "Do you want to delete ",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              children: [
                TextSpan(
                  text: name,
                  style: const TextStyle(fontSize: 14, color: Colors.black45),
                )
              ],
            ),
          ),
          const SizedBox(height: 60),
          Row(
            children: [
              const Spacer(),
              Container(
                alignment: Alignment.bottomCenter,
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(18)),
                child: BlocProvider(
                  create: (context) => HomeBloc(),
                  child: BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {
                      if (state is DeleteSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Contact deleted")));
                      }
                    },
                    builder: (context, state) {
                      return InkWell(
                          onTap: () {
                            context
                                .read<HomeBloc>()
                                .add(DeleteButtonPressed(id));
                            context.read<HomeBloc>().add(LoadContacts());

                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ));
                          },
                          child: const Center(
                              child: Text(
                            "Delete",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )));
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );

Widget logoutUi(BuildContext context) => Container(
      height: 200,
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => HomeBloc(),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.delete_forever, color: Colors.red, size: 36),
                const Spacer(),
                const Text(
                  "Delete contact",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            color: Colors.red,
                            child: const Icon(Icons.close_sharp,
                                color: Colors.white))))
              ],
            ),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                text: "Do you want to ",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                children: [
                  TextSpan(
                      text: "unregister or logout?",
                      style: TextStyle(fontSize: 14, color: Colors.grey))
                ],
              ),
            ),
            const SizedBox(height: 60),
            Row(
              children: <Widget>[
                BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return Container(
                      alignment: Alignment.bottomCenter,
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.red, width: 1)),
                      child: InkWell(
                          onTap: () async {
                            context.read<HomeBloc>().add(UnRegister());
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => BlocProvider(create: (BuildContext c) => LoginBloc(),child: const Login(),))
                            );
                          },
                          child: const Center(
                              child: Text(
                            "UnRegister",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ))),
                    );
                  },
                ),
                const Spacer(),
                BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Container(
                      alignment: Alignment.bottomCenter,
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(18)),
                      child: InkWell(
                          onTap: () async {

                            Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => BlocProvider(create: (BuildContext c) => LoginBloc(),child: const Login(),))
                            );
                          },
                          child: const Center(
                              child: Text(
                            "Logout",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
