import 'package:flutter/material.dart';

import '../../../../data/models/contact_model.dart';
import '../../../../shared/common_widgets/contact_list_item.dart';

class ContactsList extends StatelessWidget {
  final List<ContactModel> contacts;
  final void Function(ContactModel) onContactTap;

  const ContactsList({super.key, required this.contacts, required this.onContactTap});

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
