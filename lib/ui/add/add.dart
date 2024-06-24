import 'package:flutter/material.dart';
import '../../bloc/add/add_bloc.dart';
import '../../data/Firebase_manager.dart';
import '../home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  Future<void> _addContact() async {
    String name = _nameController.text;
    String number = _numberController.text;

    await FirebaseManager().addContact(name, number);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text('Add Contact')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/add_contact.png"),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _nameController.clear();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.phone,
                controller: _numberController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _numberController.clear();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<AddBloc, AddState>(
                listener: (context, state) {
                  if(state is AddSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  }
                },
                builder: (context, state) {
                  return GestureDetector(
                    onTap: (){
                      context.read<AddBloc>().add(AddContact(
                        _nameController.text,
                         _numberController.text,
                      ));
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
