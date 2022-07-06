import 'package:flutter/material.dart';
import 'package:wishflix/Screens/HomeScreen.dart';
import 'package:wishflix/Screens/LoginScreen.dart';
import 'package:wishflix/Screens/NotificationsScreen.dart';
import 'package:wishflix/Screens/ProfilScreen.dart';
import 'package:wishflix/Screens/SearchScreen.dart';
import 'package:wishflix/Screens/SplashScreen.dart';
import 'package:wishflix/Screens/ViewScreens/MovieViewScreen.dart';
import 'package:wishflix/Screens/WishListScreen.dart';

const kMainRoute = '/';
const kHomeRoute = '/home';
const kLoginRoute = '/login';
const kProfilRoute = '/profil';
const kSearchRoute = '/search';
const kWishRoute = '/wishList';
const kNotifRoute = '/notifications';
const kMovieViewRoute = '/movieView';

final Map<String, WidgetBuilder> kRoutes = {
  kMainRoute: (_) => SplashScreen(),
  kHomeRoute: (_) => HomeScreen(),
  kLoginRoute: (_) => LoginScreen(),
  kProfilRoute: (_) => ProfilScreen(),
  kSearchRoute: (_) => SearchScreen(),
  kWishRoute: (_) => WishListScreen(),
  kNotifRoute: (_) => NotificationScreen(),
  kMovieViewRoute: (_) => MovieViewScreen(),
};
