import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/task_model.dart';

import '../user_model.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance.
    collection(UserModel.collectionName).withConverter<
        UserModel>(
        fromFirestore: (snapshot, _) {
          return
            UserModel.fromJson(snapshot.data()!);
        }, toFirestore: (task, _) {
      return task.toJson();
    });
  }


  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance.
    collection(TaskModel.collectionName).withConverter<
        TaskModel>(
        fromFirestore: (snapshot, _) {
          return TaskModel.fromJson(snapshot.data()!);
        }, toFirestore: (task, _) {
      return task.toJson();
    });
  }

 static Future<void> addTask(TaskModel model) {
    var collection=getTaskCollection();
    var docRef=collection.doc();
    model.id=docRef.id;
    return  docRef.set(model);
  }

static  Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date){
  return getTaskCollection().where("userId",isEqualTo: FirebaseAuth.instance.currentUser! .uid)
      .where(
      "date",isEqualTo:DateUtils.dateOnly(date).millisecondsSinceEpoch )
      .snapshots();
  }
  static Future<void> addUser(UserModel user){
    var collection=getUsersCollection();
    var docRef=collection.doc(user.id);
    return docRef.set(user);
  }
 static Future<void> deleteTask(String id){
   return getTaskCollection().doc(id).delete();
  }

 static Future<void> updateTask(TaskModel taskModel){
   return getTaskCollection().doc(taskModel.id).update(taskModel.toJson());
 }

 static Future<UserModel?> readUser()async{
   String id=FirebaseAuth.instance.currentUser!.uid;
   DocumentSnapshot<UserModel> documentSnapshot=
   await getUsersCollection().doc(id).get();
   return documentSnapshot.data();
 }

 static void createUserAccount({
    required String email,
   required String password,
   required String userName,
   required String phone,
   required Function onSuccess,
   required Function onError,
  })async{
   try {
     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password,
     );
     credential.user!.sendEmailVerification();
     UserModel user=UserModel(
         id: credential.user?.uid??"",
         email: email,
         userName: userName,
         phone: phone
     );
       await addUser(user);
       onSuccess();

   } on FirebaseAuthException catch (e) {
     if (e.code == 'weak-password') {
       onError(e.message);
     } else if (e.code == 'email-already-in-use') {
       onError(e.message);
     }
     onError(e.message);
   } catch (e) {
     onError("Something wrong");
   }
 }

 static login({
   required String email,
   required String password,
   required Function onSuccess,
   required Function onError,
 })async{
   try {
     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password,
     );
     if(credential.user!.emailVerified){
       onSuccess();
     }else{
       onError("Please check your email and verify");
     }
   } on FirebaseAuthException catch (e) {

     onError("Wrong email or password");
   }
 }

 static void logOut()async{
   await FirebaseAuth.instance.signOut();

 }
}
