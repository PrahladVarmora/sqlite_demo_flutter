///[ModelContact] This class is use to Model Contact
class ModelContact {
  int? contactId;
  String? contactFirstName;
  String? contactLastName;
  String? contactImage;
  String? contactEmail;
  String? contactMobile;
  int? contactCategory;

  ModelContact(
      {this.contactId,
      this.contactFirstName,
      this.contactLastName,
      this.contactImage,
      this.contactEmail,
      this.contactMobile,
      this.contactCategory});

  ModelContact.fromJson(Map<String, dynamic> json) {
    contactId = json['contact_id'];
    contactFirstName = json['contact_first_name'];
    contactLastName = json['contact_last_name'];
    contactImage = json['contact_image'];
    contactEmail = json['contact_email'];
    contactMobile = json['contact_mobile'];
    contactCategory = json['contact_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contact_id'] = contactId;
    data['contact_first_name'] = contactFirstName;
    data['contact_last_name'] = contactLastName;
    data['contact_image'] = contactImage;
    data['contact_email'] = contactEmail;
    data['contact_mobile'] = contactMobile;
    data['contact_category'] = contactCategory;
    return data;
  }
}
