import 'package:carousel_slider/carousel_slider.dart';
import 'package:hommie/core/app_export.dart';

List<String> images = [
  ImageConstant.imgSlide1,
  ImageConstant.imgSlide2,
  ImageConstant.imgSlide3,
];

class CustomCarouselImage extends StatefulWidget {
  const CustomCarouselImage({Key? key}) : super(key: key);

  @override
  State<CustomCarouselImage> createState() => _CustomCarouselImageState();
}

class _CustomCarouselImageState extends State<CustomCarouselImage> {
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
                viewportFraction: 0.5,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: images
                .map((e) => Container(
                      width: getHorizontalSize(350),

                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(e),
                          fit: BoxFit.fitWidth,
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
