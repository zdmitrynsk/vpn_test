import 'package:flutter/material.dart';

class TabBarMain extends StatelessWidget {
  final TabController _controller;

  const TabBarMain({
    super.key,
    required TabController controller,
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    //ColorScheme colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: SizedBox(
        height: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            color: theme.inputDecorationTheme.fillColor,
            child: TabBar(
              padding: EdgeInsets.all(2),
              controller: _controller,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicatorColor: theme.primaryColor,
              indicator: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              tabs: const [
                Tab(text: 'Все'),
                Tab(text: 'Мои'),
                Tab(text: 'Избранные'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*tabBarTheme: TabBarThemeData(
    labelColor: Colors.white,
    dividerColor: Colors.transparent,
    indicator: BoxDecoration(
      color: _secondaryColor,
      borderRadius: BorderRadius.circular(25),
    ),
  ),*/
