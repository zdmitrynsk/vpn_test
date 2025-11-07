import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController _searchController;

  const SearchField(
    TextEditingController this._searchController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 18),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Поиск',
              hintStyle: theme.textTheme.bodyMedium!.copyWith(
                color: theme.hintColor,
              ),
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 17),
              prefixIcon: Icon(
                Icons.search,
                size: 24,
                color: theme.hintColor,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
