import 'package:chat_app101/Widget/PrimaryButton.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 700, // Increase this value to adjust the height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Personal Info",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Name",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      
                      decoration: const InputDecoration(
                        hintText: "Ansh bhamniya",
                        prefixIcon: Icon(Icons.person), 
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Email id",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      textInputAction: TextInputAction.next,

                      decoration: const InputDecoration(
                        hintText: "Example@gmail.com ",
                        prefixIcon: Icon(Icons.alternate_email), 
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    Row(
                      children: [
                        Text(
                          "Number",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      textInputAction: TextInputAction.next,

                      decoration: const InputDecoration(
                        hintText: "91-XXXX-XXXX",
                        prefixIcon: Icon(Icons.call), 
                      ),
                    ),
                    const SizedBox(height: 20),    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        PrimaryButton(btnName: "Save", icon: Icons.save, onTap: (){}),
                      ],
                    ),                                  
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
