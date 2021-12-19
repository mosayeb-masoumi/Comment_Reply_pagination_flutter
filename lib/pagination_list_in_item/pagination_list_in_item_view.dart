import 'package:comment_pagination_flutter/pagination_list_in_item/model/comment_model.dart';
import 'package:comment_pagination_flutter/pagination_list_in_item/repository_comment.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';



class PaginationListInList extends StatefulWidget {
  const PaginationListInList({Key? key}) : super(key: key);

  @override
  _PaginationListInListState createState() => _PaginationListInListState();
}

class _PaginationListInListState extends State<PaginationListInList> {
  static const _pageSize = 2;
  final PagingController<int, CommentModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchData(pageKey);
    });
  }

  Future<void> _fetchData(int pageKey) async {
    try {

      final newItems = await CommentRepository().fetchCommentData(pageKey, _pageSize);

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("list in list with library pagination"),
      ),
      body: Container(
          child: PagedListView<int, CommentModel>.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CommentModel>(
            animateTransitions: true,
            // itemBuilder: (context, item, index) => CommentListItem(commentModel: item, index: index),
            itemBuilder: (context, item, index) {
              return CommentListItemWidget(context, item, index);
            }),
        separatorBuilder: (context, index) => const Divider(),
      )),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Widget CommentListItemWidget(
      BuildContext context, CommentModel item, int fatherIndex) {
    return Container(
      padding: EdgeInsets.all(20),
      // decoration: BoxDecoration(
      //   color: Colors.red
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              RaisedButton(child: Text("more"), onPressed: () {
                if(!item.showMore){
                  setState(() {
                    item.showMore = true;
                    int a = 5;
                  });
                }
              }),
              Spacer(),
              Text(item.name + fatherIndex.toString(), style: TextStyle(fontSize: 15),),
            ],
          ),

          Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            margin: EdgeInsets.only(top: 5),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(), // to prevent scrolling
                shrinkWrap: true, // necessary to show nested list
                // itemCount: item.replyList.length,
                itemCount: item.showMore?item.replyList.length : item.replyList.length<=5? item.replyList.length : 5 ,

                // itemCount: 5,


                itemBuilder: (Context, index) {
                  return nestedListItemWidget(
                      item, index, context, fatherIndex);
                }),
          ), // reply
        ],
      ),
    );
  }

  Widget nestedListItemWidget(
      CommentModel item, int index, BuildContext context, int fatherIndex) {
    return InkWell(
      child: Container(
          height: 50,
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(item.replyList[index].reply))),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("father item $fatherIndex " + item.replyList[index].reply),
        ));
        print("father item $fatherIndex " + item.replyList[index].reply);
      },
    );
  }
}
