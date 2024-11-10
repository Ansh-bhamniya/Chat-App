import 'package:chat_app101/Pages/Auth/Widgets/LoginForm.dart';
import 'package:chat_app101/Pages/Auth/Widgets/SignupForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthPageBody extends StatelessWidget {
  const AuthPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLogin = true.obs;
    return Container(
                // height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Row(
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Obx(
                            () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: (){
                                  isLogin.value= true;
                                },
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width/ 2.5,
                                  child: Column(
                                    children: [
                                      Text("Login",
                                      
                                      style: isLogin.value 
                                      ? Theme.of(context).textTheme.bodyLarge
                                      : Theme.of(context).textTheme.labelLarge,
                                      ),
                                      const SizedBox(height: 5),
                                      AnimatedContainer(duration: const Duration(milliseconds: 200),
                                      width: isLogin.value ? 100 : 0,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Theme.of(context).colorScheme.primary,
                                                        
                                      ),)
                                    ],
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: (){
                                  isLogin.value= false;
                                },
                                                                
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width/ 2.5,

                                  child: Column(
                                    children: [
                                      Text("Signup",
                                      style: isLogin.value
                                      ? Theme.of(context).textTheme.bodyLarge
                                      : Theme.of(context).textTheme.bodyLarge,
                                      ),
                                      const SizedBox(height: 5),
                                  
                                      AnimatedContainer(duration: const Duration(milliseconds: 200),
                                      width: isLogin.value ? 0 : 100,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Theme.of(context).colorScheme.primary,
                                                        
                                      ),)
                                       

                                    ],
                                  ),
                                ),
                              ),                              
                            ],
                          ),),
                          Obx(() => isLogin.value ? const LoginForm() : const SignupForm(),) 

                      ],
                      ),
                    ))
                     

                ],
                ),
              );
  }
}