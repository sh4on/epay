import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../data/models/contact_model.dart';
import '../../../../shared/common_widgets/contact_list_item.dart';

class ContactsList extends StatelessWidget {
  final List<ContactModel> contacts;
  final void Function(ContactModel) onContactTap;

  const ContactsList({
    super.key,
    required this.contacts,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Text('No contacts found.', style: AppTypography.bodySmall),
      );
    }

    return Column(
      children: contacts
          .map(
            (contact) => Column(
              children: [
                // single contact row
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
