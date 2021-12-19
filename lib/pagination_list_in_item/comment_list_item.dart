
import 'package:comment_pagination_flutter/pagination_list_in_item/model/comment_model.dart';
import 'package:flutter/material.dart';

class CommentListItem extends StatelessWidget {

  final CommentModel commentModel;
  final int index;
  const CommentListItem({Key? key, required this.commentModel, required this.index}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(commentModel.name+index.toString() , style: TextStyle(fontSize: 15),),
            SizedBox(height: 5,),

            Container(
              margin: EdgeInsets.only(left: 10 , right: 10),
              child: ListView.builder(
                  itemCount: commentModel.replyList.length,
                  itemBuilder: (Context , index){
                    return Text(commentModel.replyList[index].reply);
                  })),

          ],





              // Container(
              //   margin: EdgeInsets.only(left: 10 , right: 10),
              //   child: ListView.builder(
              //       itemCount: commentModel.replyList.length,
              //       itemBuilder: (Context , index){
              //         return Text(commentModel.replyList[index].reply);
              //       }),
              // )

          ),
        ),
    );


  }
}

