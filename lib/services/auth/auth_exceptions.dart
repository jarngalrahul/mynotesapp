//Wrong pass word and user not found exceptions are depracated for the new android versions
class InvalidCredentialAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

//Generic exception
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
