import '../../helper/helper_function.dart';

class Food {
  int? id;
  int? foodType;
  int? mysteryTypeId;
  String? foodName;
  String? foodDescription;
  String? foodImage;
  String? thumbnailImage;
  String? listImage;
  int? foodStock;
  dynamic price;
  dynamic discountPrice;
  String? prefix;
  int? boutiqueId;
  String? pickupDateFrom;
  String? pickupDateTo;
  String? pickupTimeFrom;
  String? pickupTimeTo;
  String? allergyIds;
  int? hideShow;
  String? createdAt;
  String? updatedAt;
  String? foodCatId;
  int? orientation;

  Food(
      {this.id,
        this.foodType,
        this.mysteryTypeId,
        this.foodName,
        this.foodDescription,
        this.foodImage,
        this.thumbnailImage,
        this.listImage,
        this.foodStock,
        this.price,
        this.discountPrice,
        this.prefix,
        this.boutiqueId,
        this.pickupDateFrom,
        this.pickupDateTo,
        this.pickupTimeFrom,
        this.pickupTimeTo,
        this.allergyIds,
        this.hideShow,
        this.createdAt,
        this.updatedAt,
        this.foodCatId,
        this.orientation});

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodType = json['food_type'];
    mysteryTypeId = json['mystery_type_id'];
    foodName = json['food_name'];
    foodDescription = json['food_description'];
    foodImage = json['food_image'];
    foodStock = json['food_stock'];
    price = json['price'];
    discountPrice = json['discount_price'];
    prefix = json['prefix'];
    boutiqueId = json['boutique_id'];
    pickupDateFrom = json['pickup_date_from'];
    pickupDateTo = json['pickup_date_to'];
    pickupTimeFrom = json['pickup_time_from'];
    pickupTimeTo = json['pickup_time_to'];
    allergyIds = json['allergy_ids'];
    hideShow = json['hide_show'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    foodCatId = json['food_cat_id'];
    orientation = json['image_orientation'];


    if(json['thumbnail_image'] == null || HelperFunction.hasHttpOrHttps(json['thumbnail_image']) == false){
      thumbnailImage = foodImage;
    }
    else {
      thumbnailImage = json['thumbnail_image'];
    }

    if(json['list_image'] == null || HelperFunction.hasHttpOrHttps(json['list_image']) == false){
      listImage = foodImage;
    }
    else {
      listImage = json['list_image'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['food_type'] = this.foodType;
    data['mystery_type_id'] = this.mysteryTypeId;
    data['food_name'] = this.foodName;
    data['food_description'] = this.foodDescription;
    data['food_image'] = this.foodImage;
    data['thumbnail_image'] = this.thumbnailImage;
    data['list_image'] = this.listImage;
    data['food_stock'] = this.foodStock;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['prefix'] = this.prefix;
    data['boutique_id'] = this.boutiqueId;
    data['pickup_date_from'] = this.pickupDateFrom;
    data['pickup_date_to'] = this.pickupDateTo;
    data['pickup_time_from'] = this.pickupTimeFrom;
    data['pickup_time_to'] = this.pickupTimeTo;
    data['allergy_ids'] = this.allergyIds;
    data['hide_show'] = this.hideShow;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['food_cat_id'] = this.foodCatId;
    data['image_orientation'] = this.orientation;

    return data;
  }
}

class FoodWithCreatedAtUpdatedAtInDateTimeObj {
  int? id;
  int? foodType;
  int? mysteryTypeId;
  String? foodName;
  String? foodDescription;
  String? foodImage;
  String? thumbnailImage;
  String? listImage;
  int? foodStock;
  dynamic price;
  dynamic discountPrice;
  String? prefix;
  int? boutiqueId;
  String? pickupDateFrom;
  String? pickupDateTo;
  String? pickupTimeFrom;
  String? pickupTimeTo;
  String? allergyIds;
  int? hideShow;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? foodCatId;
  int? orientation;



  FoodWithCreatedAtUpdatedAtInDateTimeObj(this.id, this.foodType,
      this.mysteryTypeId, this.foodName, this.foodDescription, this.foodImage,
      this.thumbnailImage, this.listImage, this.foodStock, this.price,
      this.discountPrice, this.prefix, this.boutiqueId, this.pickupDateFrom,
      this.pickupDateTo, this.pickupTimeFrom, this.pickupTimeTo,
      this.allergyIds, this.hideShow, this.createdAt, this.updatedAt, this.foodCatId, this.orientation);

  FoodWithCreatedAtUpdatedAtInDateTimeObj.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodType = json['food_type'];
    mysteryTypeId = json['mystery_type_id'];
    foodName = json['food_name'];
    foodDescription = json['food_description'];
    foodImage = json['food_image'];
    foodStock = json['food_stock'];
    price = json['price'];
    discountPrice = json['discount_price'];
    prefix = json['prefix'];
    boutiqueId = json['boutique_id'];
    pickupDateFrom = json['pickup_date_from'];
    pickupDateTo = json['pickup_date_to'];
    pickupTimeFrom = json['pickup_time_from'];
    pickupTimeTo = json['pickup_time_to'];
    allergyIds = json['allergy_ids'];
    hideShow = json['hide_show'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    foodCatId = json['food_cat_id'];
    orientation = json['image_orientation'];



    if(json['thumbnail_image'] == null || HelperFunction.hasHttpOrHttps(json['thumbnail_image']) == false){
      thumbnailImage = foodImage;
    }
    else {
      thumbnailImage = json['thumbnail_image'];
    }

    if(json['list_image'] == null || HelperFunction.hasHttpOrHttps(json['list_image']) == false){
      listImage = foodImage;
    }
    else {
      listImage = json['list_image'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['food_type'] = this.foodType;
    data['mystery_type_id'] = this.mysteryTypeId;
    data['food_name'] = this.foodName;
    data['food_description'] = this.foodDescription;
    data['food_image'] = this.foodImage;
    data['thumbnail_image'] = this.thumbnailImage;
    data['list_image'] = this.listImage;
    data['food_stock'] = this.foodStock;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['prefix'] = this.prefix;
    data['boutique_id'] = this.boutiqueId;
    data['pickup_date_from'] = this.pickupDateFrom;
    data['pickup_date_to'] = this.pickupDateTo;
    data['pickup_time_from'] = this.pickupTimeFrom;
    data['pickup_time_to'] = this.pickupTimeTo;
    data['allergy_ids'] = this.allergyIds;
    data['hide_show'] = this.hideShow;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['food_cat_id'] = this.foodCatId;
    data['image_orientation'] = this.orientation;

    return data;
  }
}
