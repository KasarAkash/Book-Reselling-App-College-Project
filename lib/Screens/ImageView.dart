import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final List<dynamic> imgs;

  const ImageView({Key key, this.imgs}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: CarouselSlider.builder(
          itemCount: widget.imgs.length,
          options: CarouselOptions(
            height: double.infinity,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
          ),
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imgs[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
