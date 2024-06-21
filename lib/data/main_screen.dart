// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:contact_app_gita/data/user_data.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
// @override
//   void initState()  {
//     //var a =  await FirebaseFirestore.instance.collection('contacts').snapshots().length;
//     //print('path: $a');
//   show();
//     super.initState();
//   }
//   void show() async{
//     var a =  await FirebaseFirestore.instance.collection('contacts').snapshots();
//     print('path: $a');
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           print(snapshot.data);
//           if (!snapshot.hasData) {
//             return Scaffold(
//               body: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextField(
//                       controller: emailController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'email'
//                       ),
//                     ),
//                     SizedBox(
//                       height: 16,
//                     ),
//                     TextField(
//                       controller: passwordController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'password'
//                       ),
//                     ),
//                     SizedBox(
//                       height: 16,
//                     ),
//                     ElevatedButton(onPressed: () {
//                       signIn(emailController.text, passwordController.text);
//                     }, child: Text('Sign in'))
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return StreamBuilder(
//                 stream: getDatas(),
//                 builder: (context, snapshot1) {
//                   if(snapshot1.hasData) {
//                     return Scaffold(
//                       body: Center(
//                           child:
//                           //ElevatedButton(onPressed: (){checkDocument();},child: Text('UPDATE'),)
//                           ListView.builder(itemCount: snapshot1.data?.length, itemBuilder: (context,index){
//                             return Text('${snapshot1.data?[index].name}');
//                           })
//                       ),
//                     );
//                   } else{
//                     return Scaffold(body: Center(child: CircularProgressIndicator()));
//                   }
//                 }
//             );
//           }
//         }
//     );
//   }
//
//   void signIn(String email, String password) async {
//     try {
//       var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: email, password: password);
//      // print("name: " + "${user.user?.emailVerified}");
//     } catch (error) {
//       print("Error: $error");
//     }
//   }
//
//   void logOut() {
//     final user = FirebaseAuth.instance.currentUser;
//     print(user?.emailVerified);
//     FirebaseAuth.instance.signOut();
//   }
//
//   void verifyUser() {
//     final user = FirebaseAuth.instance.currentUser;
//     user?.sendEmailVerification();
//   }
//
//
//
//   void addDoc() async {
//     await FirebaseFirestore.instance.collection('contacts').doc().set(
//         {'name': "Alisa"});
//
//    // FirebaseFirestore.instance.collection('users').add({'name':'dfs'});
//   }
//
//   Stream<List<UserData>> getDatas() =>
//       FirebaseFirestore.instance.collection('contacts').snapshots()
//           .map((snapshot) =>
//           snapshot.docs.map((e) => UserData.fromJson(e.data())).toList());
//
//   void updateData() async{
//     await FirebaseFirestore.instance.collection('contacts').doc('user1').update({'name':'Akmal'});
//   }
//
//   void deleteData() async{
//     await FirebaseFirestore.instance.collection('contacts').doc('user1').delete();
//   }
//
//   void checkDocument() async{
//     var d =  FirebaseFirestore.instance.collection('users').doc('user2');
//     var doc = await d.get();
//     print(doc.exists);
//   }
//
//
//   Future<List> getDatas1() async {
//
//     var l = [];
//     FirebaseFirestore.instance.collection('contacts').snapshots()
//         .map((snapshot) =>
//         snapshot.docs.map((e) => l.add(e['name'])));
//     var t = await FirebaseFirestore.instance.collection('contacts').get();
//     t.docs.length;
//     print(t);
//     return l;
//   }
// }
