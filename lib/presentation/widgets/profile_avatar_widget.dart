import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({
    super.key,
    required this.imageUrl,
    required this.isOnline,
    this.size = CustomAppDimensions.kSize50,
  });

  final String imageUrl;
  final bool isOnline;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Avatar Image
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: getImageProvider(
                imageUrl,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: size * 0.25,
            height: size * 0.25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isOnline ? CustomAppTheme.kEmerald : Colors.grey,
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ImageProvider getImageProvider(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return NetworkImage(url);
    } else {
      return AssetImage(url);
    }
  }
}
