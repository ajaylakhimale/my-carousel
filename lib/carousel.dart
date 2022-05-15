import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final PageController _controller = PageController(viewportFraction: 0.95);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = 60;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _currentPageValue = _controller.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
// print(MediaQuery.of(context).size.height.toString());

    return Column(
      children: [
        Container(
// color: AppColors.mainBackColor,
          height: _height,
          child: PageView.builder(
              controller: _controller,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPages(position);
              }),
        ),

        vertical(30),
// List view for list of food items
      ],
    );
  }

  Widget _buildPages(int index) {
// Carousel Scaling factor or code or logic.
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Container(
        height: _height,
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index.isOdd ? Colors.redAccent : Colors.pinkAccent,
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fbannikin.com%2Fwp-content%2Fuploads%2F2014%2F09%2Fpurequest-wideimage.jpg&f=1&nofb=1"),
          ),
        ),
      ),
    );
  }
}

Widget vertical(double value) => SizedBox(height: value);
Widget horizontal(double value) => SizedBox(width: value);
