import 'package:e_commerce_app/views/screens/feedback/bloc/bloc.dart';
import 'package:e_commerce_app/views/screens/feedback/widgets/feedback_card.dart';
import 'package:e_commerce_app/views/widgets/others/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFeedbacks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      builder: (context, state) {
        if (state is FeedbacksLoading) {
          return Loading();
        }
        if (state is FeedbacksLoadFailure) {
          return Center(child: Text("Load Failure"));
        }
        if (state is FeedbacksLoaded) {
          var feedbacks = state.feedbackResponse.feedbacks;
          return feedbacks.length > 0
              ? ListView.builder(
                  itemCount: feedbacks.length,
                  itemBuilder: (context, index) {
                    return FeedbackCard(feedbackItem: feedbacks[index]);
                  },
                )
              : Center(
                  child: Text("Hiện tại không có nhận xét nào về sản phẩm"),
                );
        }
        return Center(child: Text("Something went wrongs."));
      },
    );
  }
}