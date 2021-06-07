class AppConstants {
  static const EMAIL_TOKEN = "klikdnamobil@klikdna.com";
  static const PASSWORD_TOKEN = "dnaku1213";

  static const CMS_EMAIL_TOKEN = "miranty@gmail.com";
  static const CMS_PASSWORD_TOKEN = "gis2020!";

  static const BASE_URL_DNAKU = "https://apiku.dnaku.id/api/v1/" ;
  static const BASE_URL_KLIKDNA = "https://staging.klikdna.com/" ;
  static const BASE_URL_CMS = "https://cms.klikdna.com/api/v1/" ;


  //DNAKU
  static const String IMAGE_ARTIKEL_URL = "https://dnaku.id/files/images/page/article/";

  //APIKU
  static const String API_TOKEN_URL = BASE_URL_DNAKU +"auth/login";
  static const String GET_ARTIKEL_URL = BASE_URL_DNAKU + "pageArticles";
  static const String GET_ACCOUNT_URL = BASE_URL_DNAKU + "userAccounts/";
  static const String GET_PATIENT_CARD_URL = BASE_URL_DNAKU + "userPatientCards/";
  static const String UPDATE_PATIENT_CARD_URL = BASE_URL_DNAKU + "userPatientCards/";
  static const String POST_NEW_PATIENT_CARD_URL = BASE_URL_DNAKU + "userPatientCards";
  static const String GET_ASURANSI_URL = BASE_URL_DNAKU + "userPatientCardAssurances/";
  static const String SAVE_ASURANSI_URL = BASE_URL_DNAKU + "userPatientCardAssurances";
  static const String DELETE_ASURANSI_URL = BASE_URL_DNAKU + "userPatientCardAssurances/";
  static const String UPDATE_ASURANSI_URL = BASE_URL_DNAKU + "userPatientCardAssurances/";
  static const String GET_FOOD_METER_URL = BASE_URL_DNAKU + "pageFoodProducts";
  static const String GET_DETAIL_FOOD_METER_URL = BASE_URL_DNAKU + "pageFoodProducts/";
  static const String GET_SAMPLE_URL = BASE_URL_DNAKU + "sampels/";
  static const String GET_REPORT_DETAIL_URL = BASE_URL_DNAKU + "userOrderReports";
  static const String GET_MEMBER_URL = BASE_URL_DNAKU + "userPeople/";
  static const String NEW_GET_ACCOUNT_URL = BASE_URL_DNAKU + "userAccounts/";

  //NEW FOOD
  static const String LAST_SEEN_FOOD_URL = BASE_URL_DNAKU + "pageFoodProducts/last_seen/" ;
  static const String IS_FAVOURITE_FOOD_URL = BASE_URL_DNAKU + "pageFoodProducts/filter/1/1/1/1" ;

  static const String PAGE_FOOD_BRANDS_URL = BASE_URL_DNAKU + "pageFoodBrands/";

  static const String LIST_FOOD_URL = BASE_URL_DNAKU + "pageFoodProducts/filter/" ;

  //static const String LIST_DRINK_URL = BASE_URL_DNAKU + "pageFoodProducts/filter/1/1/0/0" ;

  //STAGING
  static const String LOGIN_URL = BASE_URL_KLIKDNA + "apilogin.json";
  static const String GET_WALLET_URL = BASE_URL_KLIKDNA + "wallets/apilist.json";
  static const String GET_REFERRAL_URL = BASE_URL_KLIKDNA + "referrals/apilist.json";

  //CMS
  static const String GET_HOME_ARTIKEL = BASE_URL_CMS + "apiArticles";
  static const String CMS_TOKEN_URL = BASE_URL_CMS + "auth/login";

}