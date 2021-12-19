

import 'package:comment_pagination_flutter/pagination_list_in_item/model/comment_model.dart';
import 'package:comment_pagination_flutter/pagination_list_in_item/model/reply_model.dart';

class CommentRepository{


  Future<List<CommentModel>> fetchCommentData(int pageKey, int pageSize) async{

    await Future.delayed(Duration(seconds: 2));

    List<ReplyModel> replyList = [];
    replyList.add(ReplyModel("reply 1"));
    replyList.add(ReplyModel("reply 2"));
    replyList.add(ReplyModel("reply 3"));
    replyList.add(ReplyModel("reply 4"));
    replyList.add(ReplyModel("reply 5"));
    replyList.add(ReplyModel("reply 6"));
    replyList.add(ReplyModel("reply 7"));
    replyList.add(ReplyModel("reply 8"));

    List<CommentModel> commentList = [];
    commentList.add(CommentModel(1, "name ",  replyList , false));
    commentList.add(CommentModel(1, "name ",  replyList , false));


    return commentList;

  }
}