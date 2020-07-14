import 'package:flutter/material.dart';
import 'package:workingwithfirebase/home/jobs/empty-content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  final ItemWidgetBuilder<T> itemBuilder;
  final AsyncSnapshot<List<T>> snapshot;

  ListItemBuilder({
   @required this.itemBuilder,
   @required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      List<T> _data = snapshot.data;
      if (_data.isNotEmpty) {
        return _buildList(_data);
      } else {
        return EmptyContent();
      }
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: 'error',
        content: 'something went wrong',
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildList(List<T> data) {
    return ListView.separated(
      reverse: true,
      separatorBuilder: (ctx,index) => Divider(thickness:1,height: 0,),
      itemCount: data.length + 2,
      itemBuilder: (context, index) {
        if(index == 0 || index == data.length + 1){
          return Container();
        }
       return itemBuilder(context,data[index-1]);},
    );
  }
}