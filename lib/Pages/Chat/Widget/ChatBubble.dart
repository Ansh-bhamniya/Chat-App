import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chat_app101/Config/Images.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isComing;
  final String time;
  final String status;
  final String imageUrl;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isComing,
    required this.time,
    required this.status,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment:
            isComing ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.3,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius : isComing ?                const BorderRadius.only(
                topLeft: Radius.circular( 10),
                topRight: Radius.circular( 10),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(10), 
              ) :
               const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: imageUrl.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.network(
                        imageUrl,
                        width: 150, // Adjust width as needed
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Error loading image');
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(message),
                    ],
                  )
                : Text(message), // Display text message if no imageUrl
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment:
                isComing ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Text(
                time,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              if (!isComing) const SizedBox(width: 10),
              if (!isComing)
                SvgPicture.asset(
                  AssetsImage.chatStatusSvg,
                  height: 15,
                  width: 15,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
