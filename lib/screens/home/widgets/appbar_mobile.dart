import 'package:flutter/material.dart';

class AppBarMobile extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const AppBarMobile({
    super.key,
    required this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(
        Icons.menu,
        color: Theme.of(context).colorScheme.primary,
      ),
      centerTitle: true,
      title: Container(
        constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100),
        child: const Image(image: AssetImage('graphics/inicie.png')),
      ),
      actions: const [
        CircleAvatar(
            backgroundColor: Colors.orange,
            backgroundImage: AssetImage('graphics/LuizPedro.png'))
      ],
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(0.95),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
