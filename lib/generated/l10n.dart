// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Create account to get started`
  String get createAccountToGetStart {
    return Intl.message(
      'Create account to get started',
      name: 'createAccountToGetStart',
      desc: '',
      args: [],
    );
  }

  /// `Select Langauge`
  String get selectLanguage {
    return Intl.message(
      'Select Langauge',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Langauge`
  String get language {
    return Intl.message(
      'Langauge',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get arabic {
    return Intl.message(
      'العربية',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get selectCountry {
    return Intl.message(
      'Select Country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Please select you shipping destination`
  String get pleaseSelectYourShippingDestination {
    return Intl.message(
      'Please select you shipping destination',
      name: 'pleaseSelectYourShippingDestination',
      desc: '',
      args: [],
    );
  }

  /// `United Arab Emirates`
  String get uae {
    return Intl.message(
      'United Arab Emirates',
      name: 'uae',
      desc: '',
      args: [],
    );
  }

  /// `Egypt`
  String get egypt {
    return Intl.message(
      'Egypt',
      name: 'egypt',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Money Provider`
  String get telco {
    return Intl.message(
      'Mobile Money Provider',
      name: 'telco',
      desc: '',
      args: [],
    );
  }

  /// `Start Shopping`
  String get startShopping {
    return Intl.message(
      'Start Shopping',
      name: 'startShopping',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Sign in or register to save your favourite items`
  String get singinOrRegsiter {
    return Intl.message(
      'Sign in or register to save your favourite items',
      name: 'singinOrRegsiter',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Facebook`
  String get signFacebook {
    return Intl.message(
      'Sign in with Facebook',
      name: 'signFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get signGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'signGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Apple`
  String get signApple {
    return Intl.message(
      'Sign in with Apple',
      name: 'signApple',
      desc: '',
      args: [],
    );
  }

  /// `E-Mail`
  String get email {
    return Intl.message(
      'E-Mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Card holder name`
  String get cardHolderName {
    return Intl.message(
      'Card holder name',
      name: 'cardHolderName',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email address associated with your account and we'll send an email with instructions to reset your password`
  String get forgotPasswordMessage {
    return Intl.message(
      'Enter the email address associated with your account and we\'ll send an email with instructions to reset your password',
      name: 'forgotPasswordMessage',
      desc: '',
      args: [],
    );
  }

  /// `Send Instructions`
  String get sendInstructions {
    return Intl.message(
      'Send Instructions',
      name: 'sendInstructions',
      desc: '',
      args: [],
    );
  }

  /// `We are processing your payment, this may take a few moments`
  String get processingRequest {
    return Intl.message(
      'We are processing your payment, this may take a few moments',
      name: 'processingRequest',
      desc: '',
      args: [],
    );
  }

  /// `Transaction timeout, we are still processing your payment and it may take longer time. The result will be refreshed immediately when it comes, thank you for your patience`
  String get transactionTimeout {
    return Intl.message(
      'Transaction timeout, we are still processing your payment and it may take longer time. The result will be refreshed immediately when it comes, thank you for your patience',
      name: 'transactionTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Having problem with payment?`
  String get problemWithPayment {
    return Intl.message(
      'Having problem with payment?',
      name: 'problemWithPayment',
      desc: '',
      args: [],
    );
  }

  /// `Card number`
  String get cardNumber {
    return Intl.message(
      'Card number',
      name: 'cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get numb {
    return Intl.message(
      'Number',
      name: 'numb',
      desc: '',
      args: [],
    );
  }

  /// `CVV number`
  String get cvv {
    return Intl.message(
      'CVV number',
      name: 'cvv',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get expiryDate {
    return Intl.message(
      'Expiry Date',
      name: 'expiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgetPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get createAccount {
    return Intl.message(
      'Create account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Facebook`
  String get continueWithFacebook {
    return Intl.message(
      'Continue with Facebook',
      name: 'continueWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get continueWithApple {
    return Intl.message(
      'Continue with Apple',
      name: 'continueWithApple',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstName {
    return Intl.message(
      'First name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastName {
    return Intl.message(
      'Last name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signup {
    return Intl.message(
      'Sign up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Have Account?`
  String get haveAnAccount {
    return Intl.message(
      'Have Account?',
      name: 'haveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Offer`
  String get offer {
    return Intl.message(
      'Offer',
      name: 'offer',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Wishlist`
  String get wishlist {
    return Intl.message(
      'Wishlist',
      name: 'wishlist',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get myCart {
    return Intl.message(
      'My Cart',
      name: 'myCart',
      desc: '',
      args: [],
    );
  }

  /// `My Wishlist`
  String get myWishlist {
    return Intl.message(
      'My Wishlist',
      name: 'myWishlist',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `View all products`
  String get viewAllProduct {
    return Intl.message(
      'View all products',
      name: 'viewAllProduct',
      desc: '',
      args: [],
    );
  }

  /// `Top Categroies`
  String get topCategories {
    return Intl.message(
      'Top Categroies',
      name: 'topCategories',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get viewAll {
    return Intl.message(
      'View all',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Shop By`
  String get shopBy {
    return Intl.message(
      'Shop By',
      name: 'shopBy',
      desc: '',
      args: [],
    );
  }

  /// `Daily Deals`
  String get dailyDeals {
    return Intl.message(
      'Daily Deals',
      name: 'dailyDeals',
      desc: '',
      args: [],
    );
  }

  /// `Search on edeybe`
  String get searchOnedeybe {
    return Intl.message(
      'Search on edeybe',
      name: 'searchOnedeybe',
      desc: '',
      args: [],
    );
  }

  /// `Deals By Category`
  String get dealByCategory {
    return Intl.message(
      'Deals By Category',
      name: 'dealByCategory',
      desc: '',
      args: [],
    );
  }

  /// `Filter By`
  String get filter {
    return Intl.message(
      'Filter By',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sort {
    return Intl.message(
      'Sort By',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `List View`
  String get listView {
    return Intl.message(
      'List View',
      name: 'listView',
      desc: '',
      args: [],
    );
  }

  /// `Grid View`
  String get gridView {
    return Intl.message(
      'Grid View',
      name: 'gridView',
      desc: '',
      args: [],
    );
  }

  /// `Popularity`
  String get popularity {
    return Intl.message(
      'Popularity',
      name: 'popularity',
      desc: '',
      args: [],
    );
  }

  /// `New Arrivals`
  String get newArrival {
    return Intl.message(
      'New Arrivals',
      name: 'newArrival',
      desc: '',
      args: [],
    );
  }

  /// `Price: Low to High`
  String get priceLowToHigh {
    return Intl.message(
      'Price: Low to High',
      name: 'priceLowToHigh',
      desc: '',
      args: [],
    );
  }

  /// `Price: High to Low`
  String get priceHightToLow {
    return Intl.message(
      'Price: High to Low',
      name: 'priceHightToLow',
      desc: '',
      args: [],
    );
  }

  /// `Top Rated`
  String get topRated {
    return Intl.message(
      'Top Rated',
      name: 'topRated',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Invalid mail`
  String get invalidMail {
    return Intl.message(
      'Invalid mail',
      name: 'invalidMail',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Shipping`
  String get shipping {
    return Intl.message(
      'Shipping',
      name: 'shipping',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get shippingAddress {
    return Intl.message(
      'Shipping Address',
      name: 'shippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message(
      'Subtotal',
      name: 'subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Deliver to`
  String get deliverTo {
    return Intl.message(
      'Deliver to',
      name: 'deliverTo',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Enter Coupon or Gift Card`
  String get enterCouponOrGiftCard {
    return Intl.message(
      'Enter Coupon or Gift Card',
      name: 'enterCouponOrGiftCard',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your review message`
  String get enterYourReviewMessage {
    return Intl.message(
      'Enter Your review message',
      name: 'enterYourReviewMessage',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Move to Wishlist`
  String get moveToWishlist {
    return Intl.message(
      'Move to Wishlist',
      name: 'moveToWishlist',
      desc: '',
      args: [],
    );
  }

  /// `Move to Cart`
  String get moveToCart {
    return Intl.message(
      'Move to Cart',
      name: 'moveToCart',
      desc: '',
      args: [],
    );
  }

  /// `Sold by`
  String get soldBy {
    return Intl.message(
      'Sold by',
      name: 'soldBy',
      desc: '',
      args: [],
    );
  }

  /// `Seller Information`
  String get sellerInfo {
    return Intl.message(
      'Seller Information',
      name: 'sellerInfo',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buy {
    return Intl.message(
      'Buy',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message(
      'Brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get off {
    return Intl.message(
      'Off',
      name: 'off',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get addToCart {
    return Intl.message(
      'Add To Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Write a Review`
  String get writeAReview {
    return Intl.message(
      'Write a Review',
      name: 'writeAReview',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get productDetails {
    return Intl.message(
      'Product Details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  /// `Specifications`
  String get specifications {
    return Intl.message(
      'Specifications',
      name: 'specifications',
      desc: '',
      args: [],
    );
  }

  /// `Free Shipping`
  String get freeShipping {
    return Intl.message(
      'Free Shipping',
      name: 'freeShipping',
      desc: '',
      args: [],
    );
  }

  /// `For`
  String get fortext {
    return Intl.message(
      'For',
      name: 'fortext',
      desc: '',
      args: [],
    );
  }

  /// `of`
  String get oftext {
    return Intl.message(
      'of',
      name: 'oftext',
      desc: '',
      args: [],
    );
  }

  /// `Related Products`
  String get relatedProducts {
    return Intl.message(
      'Related Products',
      name: 'relatedProducts',
      desc: '',
      args: [],
    );
  }

  /// `Frequently Bought together`
  String get frequentlyBoughttogether {
    return Intl.message(
      'Frequently Bought together',
      name: 'frequentlyBoughttogether',
      desc: '',
      args: [],
    );
  }

  /// `Write Review`
  String get writeReview {
    return Intl.message(
      'Write Review',
      name: 'writeReview',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Words`
  String get words {
    return Intl.message(
      'Words',
      name: 'words',
      desc: '',
      args: [],
    );
  }

  /// `New Items Added`
  String get cartDialogTitle {
    return Intl.message(
      'New Items Added',
      name: 'cartDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Added to cart`
  String get addedToCart {
    return Intl.message(
      'Added to cart',
      name: 'addedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Added to wishlist`
  String get addedToWishlist {
    return Intl.message(
      'Added to wishlist',
      name: 'addedToWishlist',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Continue Shopping`
  String get continueShopping {
    return Intl.message(
      'Continue Shopping',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Add/Edit an Address`
  String get editaddaddress {
    return Intl.message(
      'Add/Edit an Address',
      name: 'editaddaddress',
      desc: '',
      args: [],
    );
  }

  /// `Add an Address`
  String get addAddress {
    return Intl.message(
      'Add an Address',
      name: 'addAddress',
      desc: '',
      args: [],
    );
  }

  /// `Address Details`
  String get addressDetails {
    return Intl.message(
      'Address Details',
      name: 'addressDetails',
      desc: '',
      args: [],
    );
  }

  /// `Make Default Shipping Address`
  String get makeDefaultShippingAddress {
    return Intl.message(
      'Make Default Shipping Address',
      name: 'makeDefaultShippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Building number - Street - City`
  String get addressPlaceholder {
    return Intl.message(
      'Building number - Street - City',
      name: 'addressPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Additional Address Detials`
  String get additionalAddress {
    return Intl.message(
      'Additional Address Detials',
      name: 'additionalAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter mobile number`
  String get mobileNumberPlaceholder {
    return Intl.message(
      'Enter mobile number',
      name: 'mobileNumberPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Ghana Post Address`
  String get ghanaPostAddress {
    return Intl.message(
      'Ghana Post Address',
      name: 'ghanaPostAddress',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Mobile No.`
  String get mobileNo {
    return Intl.message(
      'Mobile No.',
      name: 'mobileNo',
      desc: '',
      args: [],
    );
  }

  /// `Payment Date`
  String get paymentDate {
    return Intl.message(
      'Payment Date',
      name: 'paymentDate',
      desc: '',
      args: [],
    );
  }

  /// `Order Id`
  String get orderId {
    return Intl.message(
      'Order Id',
      name: 'orderId',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Date`
  String get deliveryDate {
    return Intl.message(
      'Delivery Date',
      name: 'deliveryDate',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Money`
  String get mobileMoney {
    return Intl.message(
      'Mobile Money',
      name: 'mobileMoney',
      desc: '',
      args: [],
    );
  }

  /// `Debit / Credit Card`
  String get creditDebitCard {
    return Intl.message(
      'Debit / Credit Card',
      name: 'creditDebitCard',
      desc: '',
      args: [],
    );
  }

  /// `Locate Me`
  String get locateme {
    return Intl.message(
      'Locate Me',
      name: 'locateme',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Location`
  String get confirmLocation {
    return Intl.message(
      'Confirm Location',
      name: 'confirmLocation',
      desc: '',
      args: [],
    );
  }

  /// `Remove Address`
  String get removeAdrress {
    return Intl.message(
      'Remove Address',
      name: 'removeAdrress',
      desc: '',
      args: [],
    );
  }

  /// `Save Address`
  String get saveAddress {
    return Intl.message(
      'Save Address',
      name: 'saveAddress',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove this Asddress?`
  String get removeAddressMessage {
    return Intl.message(
      'Are you sure you want to remove this Asddress?',
      name: 'removeAddressMessage',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message(
      'Continue',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a password recover instructions to your email`
  String get emailSent {
    return Intl.message(
      'We have sent a password recover instructions to your email',
      name: 'emailSent',
      desc: '',
      args: [],
    );
  }

  /// `Check your mail`
  String get checkMail {
    return Intl.message(
      'Check your mail',
      name: 'checkMail',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get placeOrder {
    return Intl.message(
      'Place Order',
      name: 'placeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Add a Card`
  String get addCard {
    return Intl.message(
      'Add a Card',
      name: 'addCard',
      desc: '',
      args: [],
    );
  }

  /// `Add Payment Method`
  String get addPaymentMethod {
    return Intl.message(
      'Add Payment Method',
      name: 'addPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Save Card`
  String get saveCard {
    return Intl.message(
      'Save Card',
      name: 'saveCard',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Save Payment Method`
  String get savePayementMethod {
    return Intl.message(
      'Save Payment Method',
      name: 'savePayementMethod',
      desc: '',
      args: [],
    );
  }

  /// `Remove Card`
  String get removePaymentMethod {
    return Intl.message(
      'Remove Card',
      name: 'removePaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove this card`
  String get removePaymentMethodMessage {
    return Intl.message(
      'Are you sure you want to remove this card',
      name: 'removePaymentMethodMessage',
      desc: '',
      args: [],
    );
  }

  /// `Remove Item!`
  String get removeItem {
    return Intl.message(
      'Remove Item!',
      name: 'removeItem',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove this item?`
  String get removeItemMessage {
    return Intl.message(
      'Are you sure you want to remove this item?',
      name: 'removeItemMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cart Summary`
  String get cartSummary {
    return Intl.message(
      'Cart Summary',
      name: 'cartSummary',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get orderSummary {
    return Intl.message(
      'Order Summary',
      name: 'orderSummary',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get Subtotal {
    return Intl.message(
      'Subtotal',
      name: 'Subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Promotion Discounts`
  String get promotionDiscounts {
    return Intl.message(
      'Promotion Discounts',
      name: 'promotionDiscounts',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Charges`
  String get deliveryCharges {
    return Intl.message(
      'Delivery Charges',
      name: 'deliveryCharges',
      desc: '',
      args: [],
    );
  }

  /// `Cash On Delivery`
  String get cashOnDelivery {
    return Intl.message(
      'Cash On Delivery',
      name: 'cashOnDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Your Order Successfully Placed`
  String get orderPlaceSuccess {
    return Intl.message(
      'Your Order Successfully Placed',
      name: 'orderPlaceSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to Place your Order, please try again later`
  String get orderPlaceFailed {
    return Intl.message(
      'Failed to Place your Order, please try again later',
      name: 'orderPlaceFailed',
      desc: '',
      args: [],
    );
  }

  /// `Card number is invalid`
  String get numberIsInvalid {
    return Intl.message(
      'Card number is invalid',
      name: 'numberIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Field is required`
  String get fieldReq {
    return Intl.message(
      'Field is required',
      name: 'fieldReq',
      desc: '',
      args: [],
    );
  }

  /// `Expire year is invalid`
  String get yearIsInvalid {
    return Intl.message(
      'Expire year is invalid',
      name: 'yearIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Card CVV is invalid`
  String get cvvIsInvalid {
    return Intl.message(
      'Card CVV is invalid',
      name: 'cvvIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Expire Month is invalid`
  String get mondIsInvalid {
    return Intl.message(
      'Expire Month is invalid',
      name: 'mondIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Card has expired`
  String get cardHasExpired {
    return Intl.message(
      'Card has expired',
      name: 'cardHasExpired',
      desc: '',
      args: [],
    );
  }

  /// `Voucher invalid`
  String get voucherIsInvalid {
    return Intl.message(
      'Voucher invalid',
      name: 'voucherIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Voucher Code`
  String get voucherCode {
    return Intl.message(
      'Voucher Code',
      name: 'voucherCode',
      desc: '',
      args: [],
    );
  }

  /// `Select Telecom Provider`
  String get selectTelco {
    return Intl.message(
      'Select Telecom Provider',
      name: 'selectTelco',
      desc: '',
      args: [],
    );
  }

  /// `Personal Detials`
  String get personalDetails {
    return Intl.message(
      'Personal Detials',
      name: 'personalDetails',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get hlepCenter {
    return Intl.message(
      'Help Center',
      name: 'hlepCenter',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get deliveryAddress {
    return Intl.message(
      'Delivery Address',
      name: 'deliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Order History`
  String get orderHistory {
    return Intl.message(
      'Order History',
      name: 'orderHistory',
      desc: '',
      args: [],
    );
  }

  /// `Track Orders`
  String get trackOrders {
    return Intl.message(
      'Track Orders',
      name: 'trackOrders',
      desc: '',
      args: [],
    );
  }

  /// `Track Order`
  String get trackOrder {
    return Intl.message(
      'Track Order',
      name: 'trackOrder',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Products are not available at the moment`
  String get productsEmpty {
    return Intl.message(
      'Products are not available at the moment',
      name: 'productsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get tnc {
    return Intl.message(
      'Terms & Conditions',
      name: 'tnc',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Q & A`
  String get QNA {
    return Intl.message(
      'Q & A',
      name: 'QNA',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Got a Question`
  String get gotquestion {
    return Intl.message(
      'Got a Question',
      name: 'gotquestion',
      desc: '',
      args: [],
    );
  }

  /// `Go to wishlist`
  String get goToWishlist {
    return Intl.message(
      'Go to wishlist',
      name: 'goToWishlist',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Change Country`
  String get changeCountry {
    return Intl.message(
      'Change Country',
      name: 'changeCountry',
      desc: '',
      args: [],
    );
  }

  /// `No past orders found!`
  String get noOrdersFound {
    return Intl.message(
      'No past orders found!',
      name: 'noOrdersFound',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Your Question`
  String get yourQuestion {
    return Intl.message(
      'Your Question',
      name: 'yourQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Ask questions and get answers`
  String get askQuestion {
    return Intl.message(
      'Ask questions and get answers',
      name: 'askQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Type your question`
  String get typeYourQuestion {
    return Intl.message(
      'Type your question',
      name: 'typeYourQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logoutWarningMsg {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logoutWarningMsg',
      desc: '',
      args: [],
    );
  }

  /// `Product Terms`
  String get productTerms {
    return Intl.message(
      'Product Terms',
      name: 'productTerms',
      desc: '',
      args: [],
    );
  }

  /// `Use of the site`
  String get userOfTheSite {
    return Intl.message(
      'Use of the site',
      name: 'userOfTheSite',
      desc: '',
      args: [],
    );
  }

  /// `Amendments`
  String get amendments {
    return Intl.message(
      'Amendments',
      name: 'amendments',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Old password`
  String get oldPassword {
    return Intl.message(
      'Old password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm new password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Up Coming`
  String get upComing {
    return Intl.message(
      'Up Coming',
      name: 'upComing',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Card already been added, please try with a different card!`
  String get cardExist {
    return Intl.message(
      'Card already been added, please try with a different card!',
      name: 'cardExist',
      desc: '',
      args: [],
    );
  }

  /// `Recommended for you`
  String get recommendedForYou {
    return Intl.message(
      'Recommended for you',
      name: 'recommendedForYou',
      desc: '',
      args: [],
    );
  }

  /// `Hot Deals`
  String get hotDeals {
    return Intl.message(
      'Hot Deals',
      name: 'hotDeals',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty!`
  String get cartEmpty {
    return Intl.message(
      'Your cart is empty!',
      name: 'cartEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Lets go Shopping!`
  String get letsGoShopping {
    return Intl.message(
      'Lets go Shopping!',
      name: 'letsGoShopping',
      desc: '',
      args: [],
    );
  }

  /// `Your wishlist is empty!`
  String get wishlistEmpty {
    return Intl.message(
      'Your wishlist is empty!',
      name: 'wishlistEmpty',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}