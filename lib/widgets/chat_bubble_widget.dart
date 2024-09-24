
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatBubble extends StatelessWidget {
  final String? photoUrl;
  final String message;
  final bool isMine;
  final String heroTag;
  final double _iconSize = 25;
  const ChatBubble({
    super.key,
    required this.photoUrl,
    required this.message,
    required this.isMine,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    // user avatar
    widgets.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_iconSize),
          child: photoUrl == null
              ? _DefaultPersonWidget(robot: isMine)
              : CachedNetworkImage(
                  imageUrl: photoUrl!,
                  width: _iconSize,
                  height: _iconSize,
                  fit: BoxFit.fitWidth,
                  errorWidget: (context, url, Error) =>
                      _DefaultPersonWidget(robot: isMine),
                  placeholder: (context, url) =>
                      _DefaultPersonWidget(robot: isMine),
                ),
        ),
      ),
    );

    //message bubble
    widgets.add(
      Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isMine ? Colors.grey.shade500 : Colors.blue),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(9),
        child: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
// dong message hien thi
    return Hero(
      tag: heroTag,
      child: Material(
        type: MaterialType.transparency,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: isMine ? widgets.reversed.toList() : widgets,
        ),
      ),
    );
  }
}

class _DefaultPersonWidget extends StatelessWidget {
  final bool robot;
  const _DefaultPersonWidget({super.key, required this.robot});

  @override
  Widget build(BuildContext context) {
    return robot
        ? const Icon(
            Icons.person_pin,
            color: Colors.black,
            size: 20,
          )
        : const Icon(
            Icons.air,
            color: Colors.black,
            size: 20,
          );
  }
}
