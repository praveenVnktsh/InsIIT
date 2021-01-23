import 'package:instiapp/data/dataContainer.dart';
import 'package:instiapp/importantContacts/classes/contactcard.dart';
import 'dart:convert';

class ImportantContactsContainer {
  List<ContactCard> contactCards;

  getData({forceRefresh: false}) async {
    dataContainer.sheet
        .getData('Contacts!A:E', forceRefresh: forceRefresh)
        .listen((cache) {
      var data = [];
      for (int i = 0; i < cache.length; i++) {
        data.add(cache[i]);
      }
      makeContactList(data);
    });
  }

  makeContactList(List importantContactDataList) {
    importantContactDataList.removeAt(0);
    contactCards = [];
    for (List lc in importantContactDataList) {
      contactCards.add(ContactCard(
          name: lc[0], description: lc[1], contacts: jsonDecode(lc[2])));
    }
  }
}
