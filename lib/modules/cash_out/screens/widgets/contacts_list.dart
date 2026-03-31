import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../data/models/contact_model.dart';
import '../../../../shared/common_widgets/contact_book_icon_button.dart';
import '../../../../shared/common_widgets/contact_list_item.dart';
import '../../controllers/cash_out_controller.dart';

class ContactsList extends StatelessWidget {
  final List<ContactModel> contacts;
  final void Function(ContactModel) onContactTap;

  const ContactsList({required this.contacts, required this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: contacts
          .map(
            (contact) => Column(
          children: [
            ContactListItem(
              contact: contact,
              onTap: () => onContactTap(contact),
            ),
            const Divider(height: 1),
          ],
        ),
      )
          .toList(),
    );
  }
}