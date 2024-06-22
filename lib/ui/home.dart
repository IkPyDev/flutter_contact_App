import 'package:contact_app_gita/cons/text_steles.dart';
import 'package:contact_app_gita/ui/add.dart';
import 'package:flutter/material.dart';
import '../data/Firebase_manager.dart';
import '../data/UserData.dart';
import 'login.dart';
import 'update.dart';
import '../cons/app_icons.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            contact(),
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
    );
  }
}

Widget contactItems(
    BuildContext context, String id, String name, String number) =>
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

Widget contact() {
  return StreamBuilder<List<UserData>>(
    stream: FirebaseManager().getContacts(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text("Error: ${snapshot.error}"));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text("No contacts available"));
      } else {
        return ListView.separated(
          separatorBuilder: (_, __) {
            return const Divider(height: 2, color: Colors.grey);
          },
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var contact = snapshot.data![index];
            return contactItems(
                context, contact.id, contact.name, contact.phone);
          },
        );
      }
    },
  );
}

Widget delete(String id, String name, BuildContext context) => Container(
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
                  child: const Icon(Icons.close_sharp, color: Colors.white)))
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
            child: InkWell(
                onTap: () async {
                  await FirebaseManager().deleteContact(id);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                child: const Center(
                    child: Text(
                      "Delete",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ))),
          ),
        ],
      )
    ],
  ),
);

Widget logoutUi(BuildContext context) => Container(
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
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      color: Colors.red,
                      child: const Icon(Icons.close_sharp, color: Colors.white))))
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
          Container(
            alignment: Alignment.bottomCenter,
            height: 50,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.red, width: 1)),
            child: InkWell(
                onTap: () async {
                  await FirebaseManager().clearAll();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
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
          ),
          const Spacer(),
          Container(
            alignment: Alignment.bottomCenter,
            height: 50,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(18)),
            child: InkWell(
                onTap: () async {
                  await FirebaseManager().logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
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
          ),
        ],
      )
    ],
  ),
);
