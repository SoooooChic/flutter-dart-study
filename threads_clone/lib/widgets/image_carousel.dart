import 'package:flutter/widgets.dart';
import 'package:threads_clone/constants/sizes.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;

  const ImageCarousel({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        separatorBuilder: (context, index) => const SizedBox(
          width: Sizes.size8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.size16),
            child: Image.network(
              imageUrls[index],
              width: 300,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
