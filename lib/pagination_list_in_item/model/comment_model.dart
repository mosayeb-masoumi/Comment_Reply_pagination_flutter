
import 'package:comment_pagination_flutter/pagination_list_in_item/model/reply_model.dart';

class CommentModel {

  int id = 0;
  String name;
  List<ReplyModel> replyList = [];
  late bool _showMore;

  CommentModel(this.id, this.name, this.replyList, this._showMore);


  bool get showMore => _showMore;

  set showMore(bool value) {
    _showMore = value;
  }
}
