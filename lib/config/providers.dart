
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../dataproviders/AddressProvider.dart';
import '../dataproviders/BannerProvider.dart';
import '../dataproviders/CartDataProvider.dart';
import '../dataproviders/CategoryDataProvider.dart';
import '../dataproviders/NormalFastProductProvider.dart';
import '../dataproviders/NotificationProvider.dart';
import '../dataproviders/OrderProviders.dart';
import '../dataproviders/ProductImageProvider.dart';
import '../dataproviders/ProductListByCategoryProvider.dart';
import '../dataproviders/ProductListBySubCategoryProvider.dart';
import '../dataproviders/ProductListProvider.dart';
import '../dataproviders/ProductStockProvider.dart';
import '../dataproviders/SearchDataProvider.dart';
import '../dataproviders/SubCategoryProvider.dart';
import '../dataproviders/WishlistProvider.dart';
import '../providers/baseProvider.dart';
import '../providers/userProvider.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    //List all providers here

    ChangeNotifierProvider(create: (context) => BaseProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => CategoryDataProvider()),
    ChangeNotifierProvider(create: (context) => SubCategoryDataProvider()),
    ChangeNotifierProvider(create: (context) => ProductListProvider()),
    ChangeNotifierProvider(create: (context) => ProductStockProvider()),
    ChangeNotifierProvider(create: (context) => ProductImageProvider()),
    ChangeNotifierProvider(create: (context) => ProductListByCategoryProvider()),
    ChangeNotifierProvider(create: (context) => ProductListBySubCategoryProvider()),
    ChangeNotifierProvider(create: (context) => BannerDataProvider()),
    ChangeNotifierProvider(create: (context) => CartDataProvider()),
    ChangeNotifierProvider(create: (context) => WishlistDataProvider()),
    ChangeNotifierProvider(create: (context) => AddressDataProvider()),
    ChangeNotifierProvider(create: (context) => OrderProvider()),
    ChangeNotifierProvider(create: (context) => NotificationDataProvider()),
    ChangeNotifierProvider(create: (context) => SearchProductListProvider()),
    ChangeNotifierProvider(create: (context) => NormalFastProductProvider()),


  ];
}
