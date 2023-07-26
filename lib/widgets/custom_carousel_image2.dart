// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:carousel_slider/carousel_slider.dart';
import 'package:hommie/core/app_export.dart';



class CustomCarouselImage2 extends StatefulWidget {
  CustomCarouselImage2({Key? key, required this.images}) : super(key: key);
  List<String> images;
  @override
  State<CustomCarouselImage2> createState() => _CustomCarouselImage2State(images: images);
}

class _CustomCarouselImage2State extends State<CustomCarouselImage2> {
  _CustomCarouselImage2State({required this.images});
  List<String> images;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
                height: getHorizontalSize(250),

                viewportFraction: 1,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: images
                .map((e) => Container(
              width: width,

              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(e),
                  fit: BoxFit.fill,
                ),
              ),
            ))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: getVerticalSize(12),
                  height: getHorizontalSize(12),
                  margin: getMarginOrPadding(
                    left: 8,
                    right: 8,
                    bottom: 4,
                    top: 4,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                          .withOpacity(_current == entry.key ? 0.6 : 0.2)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
