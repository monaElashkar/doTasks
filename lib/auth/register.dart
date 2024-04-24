import 'package:flutter/material.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/home/home.dart';

class RegisterTab extends StatelessWidget {
  RegisterTab({Key? key}) : super(key: key);
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var userNameController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: userNameController,
              keyboardType: TextInputType.text,
              validator: (value){
                   if(value ==null || value.isEmpty){
                     return "User Name required";
                   }
                   return null;
              },
              decoration: InputDecoration(
                label: Text("User Name"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value){
                if(value ==null || value.isEmpty){
                  return "Email required";
                }
                bool emailValid=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-+/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if(!emailValid){
                  return "Please Write email valid";
                }
                return null;

              },
              decoration: InputDecoration(
                label: Text("Email"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              validator:(value){
                   if(value ==null || value.isEmpty){
                      return "Phone required";
                          }
                   return null;
              },
              decoration: InputDecoration(
                label: Text("Phone"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              validator: (value){
                if(value ==null || value.isEmpty){
                  return "Password required";
                }
                if(value.length<6){
                  return "Password Should be at lest 6 character";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text("Password"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    FirebaseFunctions.createUserAccount(
                        email:   emailController.text,
                        password:  passwordController.text,
                        userName:  userNameController.text,
                        phone:  phoneController.text,
                        onSuccess: (){
                          Navigator.pushNamedAndRemoveUntil(
                              context,HomeScreen.routeName,(route)=>false);
                        },
                        onError: (errorMassage){
                          showDialog(context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text(errorMassage),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: (){},
                                        child: Text("Cancel")),
                                    ElevatedButton(
                                        onPressed: (){},
                                        child: Text("Okay"))
                                  ],
                                );
                              });
                        }
                    );

                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
