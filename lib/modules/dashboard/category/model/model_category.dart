
///[ModelCategory] This class is use to Model of Category
class ModelCategory {
  int? categoryId;
  String? categoryName;

  ModelCategory({this.categoryId, this.categoryName});

  ModelCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    return data;
  }
}
