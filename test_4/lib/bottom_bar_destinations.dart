import 'package:flutter/material.dart';

class BottomBarDestination {
  const BottomBarDestination(this.icon, this.label);

  final IconData icon;
  final String label;
}

const List<BottomBarDestination> destinations = [
  BottomBarDestination(Icons.inbox_rounded, 'Inbox'),
  BottomBarDestination(Icons.article_outlined, 'Articles'),
  BottomBarDestination(Icons.messenger_outline_rounded, 'Messages'),
  BottomBarDestination(Icons.group_outlined, 'Groups'),
];
