
/// It's a Dart class that has a single static method called `fromJson` that takes a `Map<String,
/// dynamic>` and returns an instance of the class
class AppConfig {
  static const String baseUrl = 'https://mydomain.com/api/v1/';


  ///Data base
  static const String  tableCategory='Category';
  static const String  categoryId='category_id';
  static const String  categoryName='category_name';



  static const String  tableContact='Contact';
  static const String  contactId='contact_id';
  static const String  contactFirstName='contact_first_name';
  static const String  contactLastName='contact_last_name';
  static const String  contactImage='contact_image';
  static const String  contactEmail='contact_email';
  static const String  contactMobile='contact_mobile';
  static const String  contactCategory='contact_category';
}
