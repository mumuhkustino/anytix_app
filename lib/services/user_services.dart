part of 'services.dart';

class UserServices {
  static CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(User user) async {
    _collectionReference.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': user.selectedGenres,
      'selectedLanguage': user.selectedLanguage,
      'profilePicture': user.profilePicture ?? ""
    });
  }

  static Future<User> getUser(String id) async {
    DocumentSnapshot documentSnapshot = await _collectionReference.doc(id).get();

    return User(id, documentSnapshot.get('email'),
    balance: documentSnapshot.get('balance'),
      profilePicture: documentSnapshot.get('profilePicture'),
      selectedGenres: (documentSnapshot.get('selectedGenres') as List)
        .map((e) => e.toString())
        .toList(),
      selectedLanguage: documentSnapshot.get('selectedLanguage'),
      name: documentSnapshot.get('name')
    );
  }
}