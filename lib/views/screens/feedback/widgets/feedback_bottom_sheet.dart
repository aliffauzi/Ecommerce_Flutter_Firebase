import 'package:e_commerce_app/business_logic/entities/feedback_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:e_commerce_app/constants/color_constant.dart';

class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({Key key}) : super(key: key);

  @override
  _FeedbackBottomSheetState createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  // local states
  int rating = 5;
  String _content = "";

  void close() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildCommentSection(),
            _buildRatingSection(),
          ],
        ),
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          child: Icon(Icons.close),
          onTap: () {
            close();
          },
        ),
        Text(
          'Add your feedback',
          style: TextStyle(fontSize: 16),
        ),
        InkWell(
          child: Text(
            'Add',
            textAlign: TextAlign.right,
            style: TextStyle(color: mPrimaryColor, fontSize: 16),
          ),
          onTap: () {
            // create new feedback
            FeedbackItem newFeedback = FeedbackItem(
              fid: UniqueKey().toString(),
              uid: "",
              rating: rating,
              content: _content,
            );
            // return new feedback to main screen
            Navigator.pop(context, newFeedback);
          },
        )
      ],
    );
  }

  _buildRatingSection() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Rating:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RatingBar.builder(
            initialRating: rating.toDouble(),
            minRating: 1,
            allowHalfRating: false,
            itemCount: 5,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) => setState(() {
              this.rating = rating.round();
            }),
          ),
        ],
      ),
    );
  }

  _buildCommentSection() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Nhận xét:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0XFFF5F6F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              onChanged: (value) => setState(() {
                _content = value;
              }),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
