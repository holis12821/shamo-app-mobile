import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/helper/utils/size_config/size_config.dart';
import 'package:shamoapps/presentation/widgets/dialog_information.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _carouselController = CarouselSliderController();
  var _currentIndex = 0;
  var _isWishlist = false;

  final imageProducts = [
    "assets/images/shoes_nike_detail_1.png",
    "assets/images/shoes_nike_detail_2.png",
    "assets/images/shoes_nike_detail_3.png",
    "assets/images/shoes.png",
    "assets/images/shoes_nike_detail_1.png",
    "assets/images/shoes_nike_detail_2.png",
    "assets/images/shoes_nike_detail_3.png",
    "assets/images/shoes.png",
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    SizeConfig.init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: CustomAppTheme.kAntiFlashWhite,
        surfaceTintColor: CustomAppTheme.kAntiFlashWhite,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: headerSection(context),
        actions: [
          actionCartBadge(),
        ],
      ),
      backgroundColor: CustomAppTheme.kAntiFlashWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Slider
            carouselSlider(),
            const SizedBox(height: CustomAppDimensions.kSizeLarge),
            dotsIndicator(),
            const SizedBox(height: CustomAppDimensions.kSize17),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  top: CustomAppDimensions.kSize30,
                ),
                decoration: const BoxDecoration(
                  color: CustomAppTheme.kRaisinPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(CustomAppDimensions.kSizeSuperLarge),
                    topRight:
                        Radius.circular(CustomAppDimensions.kSizeSuperLarge),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sectionProductName(localizations),
                            const SizedBox(
                                height: CustomAppDimensions.kSizeLarge),
                            sectionProductPrice(localizations),
                            const SizedBox(height: CustomAppDimensions.kSize30),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: CustomAppDimensions.kSizeLarge),
                              child: Text(
                                localizations.description,
                                style:
                                    CustomTextTheme.primaryTextStyle.copyWith(
                                  fontSize: CustomAppDimensions.kSizeMedium,
                                  fontWeight: CustomTextTheme.medium,
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: CustomAppDimensions.kSizeSmall),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: CustomAppDimensions.kSizeLarge),
                              child: Text(
                                localizations.product_description,
                                style:
                                    CustomTextTheme.subtitleTextStyle.copyWith(
                                  fontSize: CustomAppDimensions.kSizeMedium,
                                  fontWeight: CustomTextTheme.light,
                                ),
                              ),
                            ),
                            const SizedBox(height: CustomAppDimensions.kSize30),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: CustomAppDimensions.kSizeLarge),
                              child: Text(
                                localizations.familiar_shoes,
                                style:
                                    CustomTextTheme.primaryTextStyle.copyWith(
                                  fontSize: CustomAppDimensions.kSizeMedium,
                                  fontWeight: CustomTextTheme.medium,
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: CustomAppDimensions.kSizeSmall),
                            SizedBox(
                              height: SizeConfig.height(
                                  designHeightPx: CustomAppDimensions.kSize54),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: imageProducts.length,
                                itemBuilder: (context, index) {
                                  return familiarShoesSection(context, index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: CustomAppDimensions.kSize10),
                    sectionButton(localizations),
                    const SizedBox(height: CustomAppDimensions.kSize10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerSection(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: SvgPicture.asset(CustomAssets.kIconBackPrimary));
  }

  Widget actionCartBadge() {
    return IconButton(
      onPressed: () {},
      icon: SvgPicture.asset(CustomAssets.kIconCartBadgePrimary),
    );
  }

  CarouselSlider carouselSlider() {
    return CarouselSlider.builder(
      itemCount: imageProducts.length,
      itemBuilder: (context, index, realIndex) {
        final item = imageProducts[index];
        return Image.asset(
          item,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      },
      carouselController: _carouselController,
      options: CarouselOptions(
        height: SizeConfig.height(designHeightPx: CustomAppDimensions.kSize215),
        viewportFraction: 1,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget dotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imageProducts.asMap().entries.map((entry) {
        final index = entry.key;
        final bool isActive = _currentIndex == index;

        return GestureDetector(
          onTap: () => _carouselController.animateToPage(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isActive
                ? CustomAppDimensions.kSizeLarge
                : CustomAppDimensions.kSizeSmallMedium,
            height: CustomAppDimensions.kSizeSmallMedium,
            margin: const EdgeInsets.symmetric(
                horizontal: CustomAppDimensions.kSizeSmallMedium),
            decoration: BoxDecoration(
              color: isActive
                  ? CustomAppTheme.kPrimaryColor
                  : CustomAppTheme.kSilver,
              borderRadius: BorderRadius.circular(
                isActive
                    ? CustomAppDimensions.kSize10
                    : CustomAppDimensions.kSize50,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget sectionProductName(AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: CustomAppDimensions.kSizeLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.product_name,
                maxLines: 1,
                style: CustomTextTheme.primaryTextStyle.copyWith(
                  fontSize: CustomAppDimensions.kSizeMediumSemiMedium,
                  fontWeight: CustomTextTheme.semiBold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                localizations.hiking_shoes,
                style: CustomTextTheme.secondaryTextStyle.copyWith(
                  fontSize: CustomAppDimensions.kSizeSmall,
                  fontWeight: CustomTextTheme.regular,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isWishlist = !_isWishlist;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: _isWishlist
                      ? CustomAppTheme.kMoonstone
                      : CustomAppTheme.kAlertColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        CustomAppDimensions.kSize8,
                      ),
                    ),
                  ),
                  content: Text(
                    _isWishlist
                        ? localizations.add_to_wishlist
                        : localizations.remove_from_wishlist,
                    style: CustomTextTheme.primaryTextStyle.copyWith(
                      fontSize: CustomAppDimensions.kSizeMedium,
                      fontWeight: CustomTextTheme.regular,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            icon: SvgPicture.asset(
              _isWishlist
                  ? CustomAssets.kIconWishlistActive
                  : CustomAssets.kIconWishlistNonActive,
              width: CustomAppDimensions.kSize46,
              height: CustomAppDimensions.kSize46,
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionProductPrice(AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: CustomAppDimensions.kSizeLarge,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: CustomAppDimensions.kSizeLarge,
        vertical: CustomAppDimensions.kSizeLarge,
      ),
      decoration: BoxDecoration(
        color: CustomAppTheme.kRaisinBlack,
        borderRadius: BorderRadius.circular(
          CustomAppDimensions.kSizeSmallMedium,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            localizations.price_start_from,
            style: CustomTextTheme.primaryTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeMedium,
              fontWeight: CustomTextTheme.regular,
            ),
          ),
          Text(
            localizations.price_nominal,
            style: CustomTextTheme.priceTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeMedium,
              fontWeight: CustomTextTheme.regular,
            ),
          )
        ],
      ),
    );
  }

  Widget familiarShoesSection(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Container(
        margin: const EdgeInsets.only(left: CustomAppDimensions.kSizeLarge),
        width: SizeConfig.width(designWidthPx: CustomAppDimensions.kSize54),
        decoration: BoxDecoration(
          color: CustomAppTheme.kAntiFlashWhite,
          borderRadius: BorderRadius.circular(CustomAppDimensions.kSize6),
          image: DecorationImage(
            image: AssetImage(imageProducts[index]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget sectionButton(AppLocalizations localizations) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CustomAppDimensions.kSizeLarge,
        vertical: CustomAppDimensions.kSizeLarge,
      ),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/detail-chat');
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: CustomAppTheme.kPrimaryColor,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(CustomAppDimensions.kSizeSmall),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: CustomAppDimensions.kSizeLarge,
                vertical: CustomAppDimensions.kSizeLarge,
              ),
            ),
            child: SvgPicture.asset(
              CustomAssets.kIconChat,
              colorFilter: const ColorFilter.mode(
                CustomAppTheme.kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: CustomAppDimensions.kSizeLarge),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomAppTheme.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(CustomAppDimensions.kSizeSmall),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: CustomAppDimensions.kSizeLarge,
                ),
              ),
              onPressed: () {
                showDialogInformation(context);
              },
              child: Text(
                localizations.add_to_cart,
                style: CustomTextTheme.primaryTextStyle.copyWith(
                  fontSize: CustomAppDimensions.kSizeLarge,
                  fontWeight: CustomTextTheme.semiBold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
