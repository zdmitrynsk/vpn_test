import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class CardVpnList extends StatelessWidget {
  final int? _id;
  final String _name;
  final int _ping;
  final bool _isFavorite;
  final bool _isActive;
  final VoidCallback _onLikeTap;
  final String _countryCode;
  final bool _isShowDeleteButton;

  const CardVpnList({
    super.key,
    required String city,
    required int ping,
    required void Function() onLikeTap,
    int? id,
    bool isFavorite = false,
    required bool isActive,
    required String countryCode,
    bool isShowDeleteButton = false,
  })  : _isShowDeleteButton = isShowDeleteButton,
        _countryCode = countryCode,
        _onLikeTap = onLikeTap,
        _id = id,
        _name = city,
        _ping = ping,
        _isFavorite = isFavorite,
        _isActive = isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      //onTap: () => _onTap(context),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          border: _isActive
              ? Border.all(color: const Color(0xFF02A9FF), width: 1.5)
              : Border.all(color: Colors.white12, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: EdgeInsets.only(
          left: 14,
          right: 2,
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _countryFlag(),
                const SizedBox(width: 14),
                _infoVpn(theme),
              ],
            ),
            Row(
              children: [
                _isShowDeleteButton ? _deleteButton(theme) : const SizedBox(),
                _favoriteButton(theme)
              ],
            )
          ],
        ),
      ),
    );
  }

  CountryFlag _countryFlag() {
    return CountryFlag.fromCountryCode(
      _countryCode,
      theme: const ImageTheme(
        shape: Circle(),
      ),
    );
  }

  Column _infoVpn(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _name,
          style: theme.textTheme.bodyLarge,
        ),
        Text(
          "${_ping.toString()} мс",
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          //onTap: () => _onTap(context),
        ),
      ],
    );
  }

  _deleteButton(ThemeData theme) {
    return TextButton(
        onPressed: () {},
        child: Text(
          "Удалить",
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
        ));
  }

  IconButton _favoriteButton(ThemeData theme) {
    return IconButton(
      onPressed: _onLikeTap,
      icon: Icon(
        Icons.favorite,
        color:
            _isFavorite ? Color(0xFFC952F5) : theme.hintColor.withOpacity(0.1),
      ),
    );
  }
}
