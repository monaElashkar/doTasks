import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/task_model.dart';

class FirebaseFunctions {
 static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance.collection("Tasks").withConverter<
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
  return getTaskCollection().where(
      "date",isEqualTo:DateUtils.dateOnly(date).millisecondsSinceEpoch )
      .snapshots();
  }
 static Future<void> deleteTask(String id){
   return getTaskCollection().doc(id).delete();
  }
 static Future<void> updateTask(TaskModel taskModel){
   return getTaskCollection().doc(taskModel.id).update(taskModel.toJson());
 }
 createUserAccount(String email,String password)async{
   try {
     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password,
     );
   } on FirebaseAuthException catch (e) {
     if (e.code == 'weak-password') {
       print('The password provided is too weak.');
     } else if (e.code == 'email-already-in-use') {
       print('The account already exists for that email.');
     }
   } catch (e) {
     print(e);
   }
 }
}
