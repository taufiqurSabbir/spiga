class Api {
  Api();


  static const String baseUrl = 'https://laspigadoro.fr';

  //Register
  static const String registerApi = '$baseUrl/api/register';

  //FCM
  static const String fcmIdApi = '$baseUrl/api/fcm/id';



  //Owner
  static const String boutiqueApi = '$baseUrl/api/pickup-addresses';


  // Liste & Panier surprise
  static const String listeSurprisApi = '$baseUrl/api/food-offers';


  //Allergy
  static const String allergyApi = '$baseUrl/api/allergies';

  //Food cat
  static const String foodCatApi = '$baseUrl/api/food-categories';


  //Surprise
  static const String surpriseApi = '$baseUrl/api/mystery-types';


  //my_order (Owner) In this  api  owner  can see  his received  orders
  static const String orderApi = '$baseUrl/api/my-orders';

  //Profile
  static const String profileApi = '$baseUrl/api/profile-settings';

  //Tutorial steps
  static const String tutorialApi = '$baseUrl/api/tutorial-steps';

  //Tutorial steps update
  static const String tutorialUpdateApi = '$baseUrl/api/tutorial-status-update';


  //user-info
  static const String userInfoApi = '$baseUrl/api/user-info';



  //Order Placement Api
  static const String orderPlacementApi = '$baseUrl/api/store-order';


  //Client profile
  static const String clintProfileApi = '$baseUrl/api/user-profile';

  //Order History
  static const String clintOrderHistoryApi = '$baseUrl/api/order-history';

  //User order details from id
  static const String userOrderDetailsApi = '$baseUrl/api/user-order/';

  //All user
  static const String userListApi = '$baseUrl/api/customers';

  //Notification
  static const String notificationApi = '$baseUrl/api/custom-notification';

  //Refund
  static const String refundApi = '$baseUrl/api/refund';



  //Politique de confidentialité
  static const String clintPrivacyApi = '$baseUrl/api/privacy-policy';

  //All-users
  static const String allUsersApi = '$baseUrl/api/all-users';

  //Logout
  static const String logoutApi = '$baseUrl/api/logout';


  // These codes  are  not  using  now
  // temporary image prefix link
  // I am doing this due  to api error
  // They will fix
  static const String foodImagePrefix = '$baseUrl/uploads/foodOffers/';
  static const String thumbnailImagePrefix = '$baseUrl/uploads/thumbnail/';
  static const String listImagePrefix = '$baseUrl/uploads/list/';

}