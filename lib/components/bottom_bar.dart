import 'package:flutter/material.dart';

class PBottomBar extends StatelessWidget {
  const PBottomBar({required this.selectedIndex, Key? key}) : super(key: key);
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      unselectedItemColor: Colors.white.withOpacity(0.5),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz, size: 20),
          label: 'Quiz',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.list, size: 20), label: 'Elections'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 20), label: 'Profile'),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white,
      onTap: (int index) {
        if (index == 0) {
          Navigator.of(context).pushNamed('/survey');
        } else if (index == 1) {
          Navigator.of(context).pushNamed('/elections');
        } else if (index == 2) {
          Navigator.of(context).pushNamed('/results');
        }
      },
    );
  }
}
