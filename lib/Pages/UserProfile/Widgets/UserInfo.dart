
import 'package:chat_app101/Controller/ProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginUserInfo extends StatelessWidget {
  final String profileImage;
  final String userName;
  final String userEmail;
  const LoginUserInfo({super.key, required this.profileImage, required this.userName,required this.userEmail});


  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    



    return Container(
      height: 300, // Increase the height as needed
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 20), // Add space between the top of the container and the image
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),

                        child: Image.network(
                          profileImage,
                          fit: BoxFit.cover,)
                        ),
                        ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                         Text(
                        userName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userEmail,
                      style: Theme.of(context).textTheme.labelLarge,
                    )
                    

                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(context, Icons.phone, "Call", Colors.green),
                    const SizedBox(width: 10), // Space between buttons
                    _buildActionButton(context, Icons.video_call, "Video", Colors.blue),
                    const SizedBox(width: 10), // Space between buttons
                    _buildActionButton(context, Icons.chat, "Chat", Colors.blue),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5), // Adjust padding if needed
      child: Container(
        padding: const EdgeInsets.all(8), // Decrease padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), // Slightly smaller radius
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Adjusts the button size to fit the content
          children: [
            Icon(icon, size: 18, color: color), // Decrease icon size
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14, // Decrease font size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
