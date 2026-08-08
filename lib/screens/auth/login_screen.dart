import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../../utils/language.dart';
import '../../services/auth_service.dart';


class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();

}



class _LoginScreenState extends State<LoginScreen> {


  final AuthService _authService = AuthService();


  final TextEditingController phoneController =
  TextEditingController();


  bool loading = false;



  Future<void> googleLogin() async {


    setState(() {
      loading = true;
    });



    final user =
    await _authService.signInWithGoogle();



    setState(() {
      loading = false;
    });



    if (user != null && mounted) {


      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (context) =>
          const HomeScreen(),

        ),

      );


    }

    else {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Google Login Failed",
          ),

        ),

      );

    }


  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: const Color(0xFFF5FAF4),


      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),


          child: Column(

            children: [


              const SizedBox(height:40),



              Image.asset(

                "assets/images/logo.png",

                width:120,

              ),



              const SizedBox(height:20),




              Text(

                isTelugu
                    ? "తిరిగి స్వాగతం!"
                    : "Welcome Back!",


                style: const TextStyle(

                  fontSize:30,

                  fontWeight:FontWeight.bold,

                ),

              ),




              const SizedBox(height:10),




              Text(

                isTelugu

                    ? "మీ స్మార్ట్ వ్యవసాయ ప్రయాణాన్ని కొనసాగించడానికి లాగిన్ అవ్వండి."

                    : "Login to continue your smart farming journey.",


                textAlign:TextAlign.center,


                style:const TextStyle(

                  color:Colors.grey,

                  fontSize:16,

                ),

              ),





              const SizedBox(height:50),





              TextField(

                controller: phoneController,


                keyboardType:TextInputType.phone,


                decoration:InputDecoration(

                  prefixIcon:
                  const Icon(Icons.phone),


                  hintText:

                  isTelugu

                      ? "మొబైల్ నంబర్"

                      : "Mobile Number",



                  border:OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(15),

                  ),

                ),

              ),





              const SizedBox(height:20),






              SizedBox(

                width:double.infinity,

                height:55,


                child:ElevatedButton(



                  style:ElevatedButton.styleFrom(


                    backgroundColor:Colors.green,


                    foregroundColor:Colors.white,


                    shape:RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(15),

                    ),

                  ),




                  onPressed: (){


                    // Mobile OTP will be added here


                  },




                  child:Text(

                    isTelugu

                        ?"కొనసాగించండి"

                        :"Continue",


                    style:const TextStyle(

                      fontSize:18,

                      fontWeight:FontWeight.bold,

                    ),

                  ),


                ),

              ),






              const SizedBox(height:30),






              const Row(

                children:[


                  Expanded(

                    child:Divider(),

                  ),



                  Padding(

                    padding:
                    EdgeInsets.symmetric(horizontal:10),


                    child:Text("OR"),

                  ),




                  Expanded(

                    child:Divider(),

                  ),



                ],

              ),






              const SizedBox(height:30),







              SizedBox(

                width:double.infinity,

                height:55,


                child:OutlinedButton.icon(



                  style:OutlinedButton.styleFrom(


                    shape:RoundedRectangleBorder(


                      borderRadius:
                      BorderRadius.circular(15),


                    ),

                  ),





                  onPressed: loading

                      ? null

                      : googleLogin,





                  icon: const Icon(

                    Icons.login,

                  ),




                  label: loading


                      ? const SizedBox(

                    height:25,

                    width:25,

                    child:CircularProgressIndicator(),

                  )


                      : Text(

                    isTelugu

                        ? "గూగుల్‌తో కొనసాగించండి"

                        : "Continue with Google",


                    style:const TextStyle(

                      fontSize:16,

                    ),

                  ),


                ),

              ),






              const SizedBox(height:40),






              Text(

                isTelugu

                    ? "కొనసాగించడం ద్వారా మీరు మా నిబంధనలు మరియు గోప్యతా విధానాన్ని అంగీకరిస్తున్నారు."

                    : "By continuing you agree to our Terms & Privacy Policy.",



                textAlign:TextAlign.center,



                style:const TextStyle(

                  color:Colors.grey,

                  fontSize:13,

                ),

              ),




            ],

          ),

        ),

      ),

    );

  }


}