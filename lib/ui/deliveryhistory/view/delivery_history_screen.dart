import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vcarez_delivery/ui/deliveryhistory/bloc/delivery_history_bloc.dart';
import 'package:vcarez_delivery/ui/deliveryhistory/model/delivery_history_model.dart';
import 'package:vcarez_delivery/utils/images_utils.dart';

import '../../../../components/SizeConfig.dart';
import '../../../../components/my_theme_button.dart';
import '../../../../components/standard_regular_text.dart';
import '../../../../utils/strings.dart';
import '../../../components/common_loader.dart';
import '../../../components/custom_app_bar.dart';
import '../../../services/repo/common_repo.dart';
import '../../../storage/shared_pref_const.dart';
import '../../../utils/colors_utils.dart';
import '../../../utils/common_utils.dart';
import '../../dashboard/model/assign_order_model.dart';

class DeliveryHistoryScreen extends StatefulWidget {
  const DeliveryHistoryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryHistoryScreen> createState() => _DeliveryHistoryScreenState();
}

class _DeliveryHistoryScreenState extends State<DeliveryHistoryScreen>
    with SingleTickerProviderStateMixin {
  var demoList = [1, 2, 3, 4, 5];

  DeliveryHistoryBloc deliveryHistoryBloc = DeliveryHistoryBloc();

  DeliveryHistoryModel deliveryHistoryModel = DeliveryHistoryModel();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      deliveryHistoryBloc.add(GetDeliveryHistoryEvent());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Widget imageAppLogo() => SvgPicture.asset(
          appLogoWithoutText_,
          height: 18.0,
          width: 116.0,
        );

    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            BlocProvider(
              create: (context) => deliveryHistoryBloc,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // createStandardAppBar(
                    //     context: context, size: MediaQuery.of(context).size.height * .25),
                    Container(
                      height: MediaQuery.of(context).size.height * .27,
                      padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical! * 1,
                          left: SizeConfig.safeBlockHorizontal! * 5,
                          right: SizeConfig.safeBlockHorizontal! * 5),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(loginBg),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        color: whiteColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: imageAppLogo(),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(
                                    notificationIcon,
                                    height: 25.0,
                                    width: 10.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            // height: 30.0,
                            height: SizeConfig.safeBlockVertical! * 7.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: StandardCustomText(
                                label: 'Delivery History',
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                                fontSize: 22.0,
                              ),
                            ),
                          ),

                          //
                        ],
                      ),
                    ),

                    bottomContent(),
                  ],
                ),
              ),
            ),
          ],
        )));
  }

  Widget bottomContent() {
    return Container(
      transform: Matrix4.translationValues(0.0, -45.0, 0.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: bgColor,
          ),
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      height: MediaQuery.of(context).size.height * .75,
//               color: bgColor,
      child: SizedBox(
        child: deliveryHistoryList(),
      ),
    );
  }

  Widget topHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * .25,
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 0.0, left: 16.0, right: 16.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(loginBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: whiteColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: imageAppLogo(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: StandardCustomText(
                label: 'My Orders',
                fontWeight: FontWeight.bold,
                color: whiteColor,
                fontSize: 22.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget deliveryHistoryList() {
    return BlocConsumer<DeliveryHistoryBloc, DeliveryHistoryState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is DeliveryHistoryDataLoaded) {
          deliveryHistoryModel = state.deliveryHistoryModel;
        }
      },
      builder: (context, state) {
        return state is DeliveryHistoryLoading
            ? Center(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * .60,
                    child: const Center(child: CustomLoader())),
              )
            : state is DeliveryHistoryDataLoaded
                ? deliveryHistoryModel.orders!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 30),
                        child: SingleChildScrollView(
                            child: ListView.builder(
                                itemCount: deliveryHistoryModel.orders!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  Orders orders =
                                      deliveryHistoryModel.orders![index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 5, 7, 5),
                                    child: GestureDetector(
                                        onTap: () {
                                          debugPrint(
                                              "vacrez the click is called ");
                                        },
                                        child:
                                            // index < 2 ?
                                            readyNotReadyQuotes(index, orders)
                                        // : readyQuotes(index)
                                        ),
                                  );
                                })),
                      )
                    : CommonUtils.NoDataFoundPlaceholder(context,
                        message: "No Delivery History Found")
                : CommonUtils.NoDataFoundPlaceholder(context,
                    message: "No Delivery History Found");
      },
    );
  }

  Widget readyNotReadyQuotes(int index, Orders orders) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Container(
          // height: SizeConfig.safeBlockVertical! * 19.0,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
              border: Border.all(
                color: whiteColor,
              ),
              color: whiteColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: index % 2 == 0
                        ? Container(
                            width: SizeConfig.safeBlockHorizontal! * 30.0,
                            height: SizeConfig.safeBlockVertical! * 6.0,
                            // padding: EdgeInsets.only(
                            //     top: SizeConfig.safeBlockVertical! * 1,
                            //     left: SizeConfig.safeBlockHorizontal! * 1,
                            //     right: SizeConfig.safeBlockHorizontal! * 1,
                            //     bottom: SizeConfig.safeBlockHorizontal! * 1),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: const Radius.circular(0.0),
                                  bottomRight: const Radius.circular(0.0),
                                  topLeft: const Radius.circular(25.0),
                                  bottomLeft: const Radius.circular(25.0)),
                              border: Border.all(
                                color: darkSkyBluePrimaryColor,
                              ),
                              color: darkSkyBluePrimaryColor,
                            ),
                            child: const Center(
                              child: StandardCustomText(
                                align: TextAlign.start,
                                label: 'Delivered',
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ))
                        : Container(
                            width: SizeConfig.safeBlockHorizontal! * 30.0,
                            height: SizeConfig.safeBlockVertical! * 6.0,
                            // padding: EdgeInsets.only(
                            //     top: SizeConfig.safeBlockVertical! * 1,
                            //     left: SizeConfig.safeBlockHorizontal! * 1,
                            //     right: SizeConfig.safeBlockHorizontal! * 1,
                            //     bottom: SizeConfig.safeBlockHorizontal! * 1),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: const Radius.circular(0.0),
                                  bottomRight: const Radius.circular(0.0),
                                  topLeft: const Radius.circular(25.0),
                                  bottomLeft: const Radius.circular(25.0)),
                              border: Border.all(
                                color: redColor,
                              ),
                              color: redColor,
                            ),
                            child: Center(
                              child: StandardCustomText(
                                align: TextAlign.start,
                                label: orders.completed == 1
                                    ? 'Delivered'
                                    :  orders.rejected == 1?'Rejected':"",
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10, top: 10, bottom: 7),
                  child: Row(
                    children:  [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(
                          left: 8,
                        ),
                        child: StandardCustomText(
                          align: TextAlign.start,
                          label: 'Order No.',
                          color: descriptionTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )),
                      Expanded(
                          child: StandardCustomText(
                        align: TextAlign.start,
                        label: orders.deliveredAt!=null?'Delivery Time':"",
                        color: descriptionTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(
                          left: 8,
                        ),
                        child: StandardCustomText(
                          align: TextAlign.start,
                          label: orders.orderNumber!=null?orders.orderNumber!:"",
                          color: darkSkyBluePrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )),
                      Expanded(
                          child: StandardCustomText(
                        align: TextAlign.start,
                            label: orders.deliveredAt!=null?orders.deliveredAt!:"",

                        color: descriptionTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Divider(),
                ),
                const Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, top: 20, right: 10.0),
                      child: StandardCustomText(
                        align: TextAlign.start,
                        label: 'Shop Address ',
                        color: descriptionTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 5, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        locationPrimaryMarker,
                        // color: darkSkyBluePrimaryColor,
                        height: 20.0,
                        width: 15.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                       Flexible(
                          child: StandardCustomText(
                        align: TextAlign.start,
                        maxlines: 4,
                            label: orders.shopAddress!=null?orders.shopAddress!:"",
                            color: negativeButtonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      )),
                    ],
                  ),
                ),
                const Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, top: 20, right: 10.0),
                      child: StandardCustomText(
                        align: TextAlign.start,
                        label: 'User Address ',
                        color: descriptionTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20, top: 5, right: 10.0, bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        locationMarkerDark2Icon,
                        // color: darkSkyBluePrimaryColor,
                        height: 20.0,
                        width: 15.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                       Flexible(
                          child: StandardCustomText(
                        align: TextAlign.start,
                        maxlines: 3,
                            label: orders.deliveryAddress!=null?orders.deliveryAddress!:"",

                            color: negativeButtonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
