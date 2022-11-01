import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';

Widget bannerSlide(BuildContext context) {
  return Consumer<RestaurantMainProvider>(
    builder: (context, pvd, child) => pvd.model == null
        ? Text('')
        : CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: false,
              // enlargeStrategy: CenterPageEnlargeStrategy.height,
              height: 145.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.9,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: [
              //ปั้น imageSlide เป็น list
              for (var i = 0; i < pvd.bannerList.length; i++)
                imageSlide(context, i)
            ].map((listImage) {
              return Builder(
                builder: (BuildContext context) {
                  return listImage;
                },
              );
            }).toList(),
          ),
  );
}

Widget imageSlide(BuildContext context, int index) {
  return Consumer<RestaurantMainProvider>(
    builder: (context, pvd, child) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: CachedNetworkImage(
            errorWidget: (BuildContext context, String pa, dynamic exception) {
              return Container(color: Colors.white, child: Text(''));
            },
            imageUrl: pvd.model!.result!.bannerLists![index].bannerImage!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
