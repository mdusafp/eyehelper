import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatefulWidget {
  static const sunYellowColor = Color(0xffFFD35A);

  final int starCount;
  final RatingChangeCallback onRatingChanged;
  final int initRating;
  final double width;
  final Color color;
  final Color disableColor;

  StarRating({
    this.starCount = 5,
    this.initRating = 0,
    @required this.onRatingChanged,
    this.width,
    this.color,
    this.disableColor,
  });

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int rating;

  @override
  void initState() {
    rating = widget.initRating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: new List.generate(
            widget.starCount,
            (index) => buildStar(context, index),
          ),
        ),
      ),
    );
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    double width = widget.width ?? (MediaQuery.of(context).size.width);
    double ratingStarSizeRelativeToScreen = width / widget.starCount;

    var color1 = widget.color ?? StarRating.sunYellowColor;
    var color2 = widget.disableColor ?? Colors.black.withOpacity(0.08);

    icon = new Icon(
      Icons.star,
      color: index < rating ? color1 : color2,
      size: ratingStarSizeRelativeToScreen,
    );

    return new InkResponse(
      highlightColor: Colors.transparent,
      radius: ratingStarSizeRelativeToScreen / 2,
      onTap: () {
        setState(() {
          rating = index + 1;
        });
        widget.onRatingChanged(index + 1.0);
      },
      child: new Container(
        height: ratingStarSizeRelativeToScreen * 1.5,
        child: icon,
      ),
    );
  }
}
