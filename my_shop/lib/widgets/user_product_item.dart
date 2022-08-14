import 'package:flutter/material.dart';
import 'package:my_shop/screens/edit_products_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductsScreen.route, arguments: id);
              },
              icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete, color: Theme.of(context).errorColor,),
            ),
          ],
        ),
      ),
    );
  }
}
