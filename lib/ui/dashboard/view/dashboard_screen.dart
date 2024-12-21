import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vcarez_delivery/components/common_loader.dart';
import 'package:vcarez_delivery/ui/dashboard/bloc/assigned/assigned_bloc.dart';
import 'package:vcarez_delivery/ui/dashboard/bloc/dashboard_bloc.dart';
import 'package:vcarez_delivery/ui/dashboard/model/new_order_model.dart';
import 'package:vcarez_delivery/ui/deliveryhistory/view/delivery_history_screen.dart';
import 'package:vcarez_delivery/utils/common_utils.dart';
import 'package:vcarez_delivery/utils/images_utils.dart';

import '../../../../components/SizeConfig.dart';
import '../../../../components/my_theme_button.dart';
import '../../../../components/standard_regular_text.dart';
import '../../../../utils/strings.dart';
import '../../../components/custom_app_bar.dart';
import '../../../services/repo/common_repo.dart';
import '../../../storage/shared_pref_const.dart';
import '../../../utils/colors_utils.dart';
import '../model/assign_order_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  var demoList = [1, 2, 3, 4, 5];
  String dropdownValue = 'Preparing';
  String dropdownValue2 = 'Pick Up';
  late TextEditingController _searchMedicineController;
  late TabController _tabController;
  DashboardBloc dashboardBloc = DashboardBloc();
  AssignedBloc assignedBloc = AssignedBloc();
  NewOrderModel newOrderModel = NewOrderModel();
  DateTime dateTime = DateTime.now();
  int? reasonType = 1;

  AssignOrderModel assignOrderModel = AssignOrderModel();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _searchMedicineController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dashboardBloc.add(GetCurrentLocationName());
      getNewOrderList();
      getAssignedList();
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RefreshController _refreshAssignedController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    dashboardBloc.add(GetCurrentLocationName());
    getNewOrderList();
    getAssignedList();

    _refreshController.refreshCompleted();
    _refreshAssignedController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if (mounted) {
      setState(() {
        dashboardBloc.add(GetCurrentLocationName());
        getNewOrderList();
        getAssignedList();

        _refreshController.loadComplete();
        _refreshAssignedController.loadComplete();
      });
    }
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
            child: BlocProvider(
          create: (context) => dashboardBloc,
          child: BlocListener<DashboardBloc, DashboardState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is OnLocationLoadedState ||
                  state is AcceptOrderSuccessState ||
                  state is RejectOrderSuccessState) {
                // dashboardBloc.add(GetNewOrderEvent());
                // assignedBloc.add(GetAssignOrderEvent());
              }
            },
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: imageAppLogo(),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DeliveryHistoryScreen()),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                        deliveryHistoryIcon,
                                        height: 25.0,
                                        width: 10.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Navigator.pop(context);
                                      },
                                      child: SvgPicture.asset(
                                        notificationIcon,
                                        height: 25.0,
                                        width: 10.0,
                                      ),
                                    ),
                                  ],
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
                                label: 'My Orders',
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                                fontSize: 22.0,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 10.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: SvgPicture.asset(
                                      calenderWhiteIcon,
                                      color: whiteColor,
                                      height: 20.0,
                                      width: 25.0,
                                    ),
                                  ),
                                  const StandardCustomText(
                                    label: '18 July 2022',
                                    fontWeight: FontWeight.bold,
                                    color: whiteColor,
                                    fontSize: 14.0,
                                  ),

                                  // Text(
                                  //     dateTimeFormatter(
                                  //         myPrescriptionModel
                                  //             .prescriptionList![
                                  //         index]
                                  //             .createdAt!,
                                  //         format: "yyyy/MM/dd"),
                                  //     style: const TextStyle(
                                  //         color:
                                  //         darkSkyBluePrimaryColor,
                                  //         fontWeight:
                                  //         FontWeight.w700,
                                  //         fontSize: 12.0)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: SvgPicture.asset(
                                      downArrowIcon,
                                      height: 15.0,
                                      width: 15.0,
                                    ),
                                  )
                                ],
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
          ),
        )));
  }

  Widget bottomContent() {
    return Positioned(
        top: MediaQuery.of(context).size.height * .23,

        // bottom: -50, // alig
        // nment: FractionalOffset.center,
        child: Container(
          width: MediaQuery.of(context).size.width,
          // transform: Matrix4.translationValues(0.0, -45.0, 0.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: bgColor,
              ),
              color: bgColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: MediaQuery.of(context).size.height * .75,
//               color: bgColor,
          child: SizedBox(
            // height: MediaQuery.of(context).size.height-SizeConfig.blockSizeVertical! * 50.0,
            child: Column(
              children: [
                TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.red,
                  tabs: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.safeBlockVertical! * 2.0,
                          SizeConfig.safeBlockVertical! * 2.0,
                          SizeConfig.safeBlockVertical! * 2.0,
                          SizeConfig.safeBlockVertical! * 2.0),
                      child: SizedBox(
                        // width: 100,
                        // margin: const EdgeInsets.only(top: 24.0),
                        width: SizeConfig.blockSizeHorizontal! * 85.0,
                        height: SizeConfig.blockSizeVertical! * 5.0,

                        child: MaterialButton(
                          // onPressed: onPressed,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 1.0, 15.0, 1.0),
                          color: darkSkyBluePrimaryColor,
                          splashColor: Theme.of(context).primaryColor,
                          disabledColor: Theme.of(context).disabledColor,
                          onPressed: () {
                            _tabController.index = 0;
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'New Orders',
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockVertical! * 1.5,
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.safeBlockVertical! * 2.0,
                          SizeConfig.safeBlockVertical! * 0.4,
                          SizeConfig.safeBlockVertical! * 2.0,
                          SizeConfig.safeBlockVertical! * 0.4),
                      child: SizedBox(
                        // width: 100,
                        // margin: const EdgeInsets.only(top: 24.0),
                        width: SizeConfig.blockSizeHorizontal! * 85.0,
                        height: SizeConfig.blockSizeVertical! * 5.0,
                        child: MaterialButton(
                          // onPressed: onPressed,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 1.0, 15.0, 1.0),
                          color: Colors.white,
                          splashColor: Theme.of(context).primaryColor,
                          disabledColor: Theme.of(context).disabledColor,
                          onPressed: () {
                            _tabController.index = 1;
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Assigned Order',
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockVertical! * 1.5,
                                  fontWeight: FontWeight.bold,
                                  color: darkSkyBluePrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
                Expanded(
                    // child: SmartRefresher(
                    //     enablePullDown: true,
                    //     enablePullUp: true,
                    //     header: WaterDropHeader(),
                    //     // footer: CustomFooter(
                    //     //   builder: (BuildContext context,LoadStatus mode){
                    //     //     Widget body ;
                    //     //     if(mode==LoadStatus.idle){
                    //     //       body =  Text("pull up load");
                    //     //     }
                    //     //     else if(mode==LoadStatus.loading){
                    //     //       body =  CupertinoActivityIndicator();
                    //     //     }
                    //     //     else if(mode == LoadStatus.failed){
                    //     //       body = Text("Load Failed!Click retry!");
                    //     //     }
                    //     //     else if(mode == LoadStatus.canLoading){
                    //     //       body = Text("release to load more");
                    //     //     }
                    //     //     else{
                    //     //       body = Text("No more Data");
                    //     //     }
                    //     //     return Container(
                    //     //       height: 55.0,
                    //     //       child: Center(child:body),
                    //     //     );
                    //     //   },
                    //     // ),
                    //     controller: _refreshController,
                    //     onRefresh: _onRefresh,
                    //     onLoading: _onLoading,
                    child: TabBarView(
                  controller: _tabController,
                  children: [myOrderList(), assignedOrderList()],
                )),
                // ),
              ],
            ),

            // child: PageView.builder(
            //   itemCount: 5,
            //   itemBuilder: (context, i) => Container(
            //     // color: Colors.blue,
            //     margin: const EdgeInsets.only(right: 10),
            //     child: i == 0 ? myOrderList() : assignedOrderList(),
            //   ),
            //   controller: PageController(viewportFraction: .7),
            // ),
          ),
        ));
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

  Widget myOrderList() {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is NewOrderDataLoaded) {
          newOrderModel = state.newOrderModel;
        }
      },
      builder: (context, state) {
        return state is NewOrderLoading ||
                state is AcceptOrderLoadingState ||
                state is RejectOrderLoadingState ||
                state is OnLocationLoadingState
            ? Center(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * .60,
                    child: const Center(child: CustomLoader())),
              )
            : (newOrderModel.orders != null)
                ? newOrderModel.orders!.isNotEmpty
                    ? SizedBox(
                        // height: MediaQuery.of(context).size.height * .80,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 30),
                          child: SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: true,
                              header: WaterDropHeader(),
                              // footer: CustomFooter(
                              //   builder: (BuildContext context,LoadStatus mode){
                              //     Widget body ;
                              //     if(mode==LoadStatus.idle){
                              //       body =  Text("pull up load");
                              //     }
                              //     else if(mode==LoadStatus.loading){
                              //       body =  CupertinoActivityIndicator();
                              //     }
                              //     else if(mode == LoadStatus.failed){
                              //       body = Text("Load Failed!Click retry!");
                              //     }
                              //     else if(mode == LoadStatus.canLoading){
                              //       body = Text("release to load more");
                              //     }
                              //     else{
                              //       body = Text("No more Data");
                              //     }
                              //     return Container(
                              //       height: 55.0,
                              //       child: Center(child:body),
                              //     );
                              //   },
                              // ),
                              controller: _refreshController,
                              onRefresh: _onRefresh,
                              onLoading: _onLoading,
                              child: SingleChildScrollView(
                                  child: newOrderModel.orders != null
                                      ? ListView.builder(
                                          itemCount:
                                              newOrderModel.orders!.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            NewOrders orders =
                                                newOrderModel.orders![index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 5, 7, 5),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    debugPrint(
                                                        "vacrez the click is called ");
                                                  },
                                                  child:
                                                      // index < 2 ?
                                                      readyNotReadyQuotes(
                                                          index, orders)
                                                  // : readyQuotes(index)
                                                  ),
                                            );
                                          })
                                      : Center(
                                          child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .60,
                                              child: Center(
                                                  child: CommonUtils
                                                      .NoDataFoundPlaceholder(
                                                          context,
                                                          message:
                                                              "No New Order Found"))),
                                        ))),
                        ),
                      )
                    : Center(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * .60,
                            child: Center(
                                child: CommonUtils.NoDataFoundPlaceholder(
                                    context,
                                    message: "No New Order Found"))),
                      )
                : Center(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * .60,
                        child: Center(
                            child: CommonUtils.NoDataFoundPlaceholder(context,
                                message: "No New Order Found"))),
                  );
      },
    );
  }

  Widget assignedOrderList() {
    return SmartRefresher(
        // enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        // footer: CustomFooter(
        //   builder: (BuildContext context,LoadStatus mode){
        //     Widget body ;
        //     if(mode==LoadStatus.idle){
        //       body =  Text("pull up load");
        //     }
        //     else if(mode==LoadStatus.loading){
        //       body =  CupertinoActivityIndicator();
        //     }
        //     else if(mode == LoadStatus.failed){
        //       body = Text("Load Failed!Click retry!");
        //     }
        //     else if(mode == LoadStatus.canLoading){
        //       body = Text("release to load more");
        //     }
        //     else{
        //       body = Text("No more Data");
        //     }
        //     return Container(
        //       height: 55.0,
        //       child: Center(child:body),
        //     );
        //   },
        // ),
        enablePullDown: true,
        controller: _refreshAssignedController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: BlocProvider(
          create: (context) => assignedBloc,
          child: BlocConsumer<AssignedBloc, AssignedState>(
            listener: (context, state) {
              // TODO: implement listener

              // debugPrint("jigar listner state is " + state.toString());
              // if (state is AssignOrderDataLoaded) {
              //   // debugPrint("jigar assignorder state is " +
              //   //     state.assignOrderModel.orders!.length.toString());
              //   assignOrderModel = state.assignOrderModel;
              //   debugPrint("jigar after assign state is " +
              //       assignOrderModel.orders!.length.toString());
              // }
            },
            builder: (context, state) {
              debugPrint("jigar current state is $state");
              return state is AssignOrderLoading
                  ? Center(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * .60,
                          child: const Center(child: CustomLoader())),
                    )
                  :
                  // state is AssignOrderDataLoaded
                  //         ?
                  (assignOrderModel.orders != null &&
                          assignOrderModel.orders!.isNotEmpty)
                      ? SizedBox(
                          // height: MediaQuery.of(context).size.height * .80,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 30),
                            child: SingleChildScrollView(
                                child: assignOrderModel.orders != null
                                    ? ListView.builder(
                                        itemCount:
                                            assignOrderModel.orders!.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          AssignOrders orders =
                                              assignOrderModel.orders![index];
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 5, 7, 5),
                                            child: GestureDetector(
                                                onTap: () {
                                                  debugPrint(
                                                      "vacrez the click is called ");
                                                },
                                                child:
                                                    // index < 2 ?
                                                    assignedOrderItem(
                                                        index, orders)
                                                // : readyQuotes(index)
                                                ),
                                          );
                                        })
                                    : Center(
                                        child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .60,
                                            child: Center(
                                                child: CommonUtils
                                                    .NoDataFoundPlaceholder(
                                                        context,
                                                        message:
                                                            "No New Order Found"))),
                                      )),
                          ),
                        )
                      // : Center(
                      //     child: SizedBox(
                      //         height:
                      //             MediaQuery.of(context).size.height * .60,
                      //         child: Center(
                      //             child: CommonUtils.NoDataFoundPlaceholder(
                      //                 context,
                      //                 message: "No Assign Order Found"))),
                      //   )
                      // : Center(
                      //     child: SizedBox(
                      //         height:
                      //             MediaQuery.of(context).size.height * .60,
                      //         child: Center(
                      //             child: CommonUtils.NoDataFoundPlaceholder(
                      //                 context,
                      //                 message: "No Assign Order Found"))),
                      //   )
                      : Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * .60,
                              child: Center(
                                  child: CommonUtils.NoDataFoundPlaceholder(
                                      context,
                                      message: "No Assign Order Found"))),
                        );
            },
          ),
        ));

//     return BlocConsumer<DashboardBloc, DashboardState>(
//   listener: (context, state) {
//     // TODO: implement listener
//     if(state is AssignOrderDataLoaded)
//       {
//
//       }
//   },
//   builder: (context, state) {
//     return SizedBox(
//       // height: MediaQuery.of(context).size.height * .80,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 10.0, bottom: 30),
//         child: SingleChildScrollView(
//             child: ListView.builder(
//                 itemCount: demoList.length,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 padding: EdgeInsets.zero,
//                 scrollDirection: Axis.vertical,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.fromLTRB(8, 5, 7, 5),
//                     child: GestureDetector(
//                         onTap: () {
//                           debugPrint("vacrez the click is called ");
//                         },
//                         child:
//                             // index < 2 ?
//                             assignedOrderItem(index)
//                         // : readyQuotes(index)
//                         ),
//                   );
//                 })),
//       ),
//     );
//   },
// );
  }

  Widget readyNotReadyQuotes(int index, NewOrders orders) {
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
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: const [
                      Expanded(
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
                        label: 'Delivery Time',
                        color: descriptionTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                        ),
                        child: StandardCustomText(
                          align: TextAlign.start,
                          label: orders.orderNumber != null
                              ? orders.orderNumber!
                              : "",
                          color: darkSkyBluePrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )),
                      const Expanded(
                          child: StandardCustomText(
                        align: TextAlign.start,
                        label: '2:30 PM',
                        color: greyLightTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                const Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 20, right: 10.0),
                      child: StandardCustomText(
                        align: TextAlign.start,
                        label: 'Shop Address ',
                        color: descriptionTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(10),
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
                        label: orders.shopAddress != null
                            ? orders.shopAddress!
                            : "",
                        // label: 'Bamboo Bazaar ,Bangalore , Karnataka ',
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
                      padding: EdgeInsets.only(left: 10, top: 20, right: 10.0),
                      child: StandardCustomText(
                        align: TextAlign.start,
                        label: 'User Address ',
                        color: descriptionTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(10),
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
                        label: orders.deliveryAddress != null
                            ? orders.deliveryAddress!
                            : "",
                        color: negativeButtonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                      child: Row(
                        children: [
                          Expanded(
                              // flex: 1,

                              child: Container(
                                  height: SizeConfig.safeBlockVertical! * 5.0,
                                  width: SizeConfig.safeBlockHorizontal! * 5.0,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(rfcDemoImage))))
                              // Image(
                              //   height: SizeConfig.safeBlockVertical! * 6.6,
                              //   width:
                              //   SizeConfig.safeBlockHorizontal! * 6.6,
                              //   image: AssetImage(rfcDemoImage),
                              //   fit: BoxFit.scaleDown,
                              // ),
                              ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StandardCustomText(
                                    align: TextAlign.start,
                                    fontSize: 14,
                                    maxlines: 2,
                                    label: orders.customerName != null
                                        ? orders.customerName!
                                        : "",
                                  ),
                                  StandardCustomText(
                                    align: TextAlign.start,
                                    fontSize: 14,
                                    maxlines: 2,
                                    label: orders.customerPhone != null
                                        ? orders.customerPhone!
                                        : "",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            // flex: 1,
                            child: SvgPicture.asset(
                              callWithWhiteBackgroundIcon,
                              height: SizeConfig.safeBlockVertical! * 4.0,
                              width: SizeConfig.safeBlockHorizontal! * 4.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4.0),
                            child: SizedBox(
                              // width: 100,
                              // margin: const EdgeInsets.only(top: 24.0),
                              height: 45,
                              child: MyThemeButton(
                                fontSize: 12,
                                buttonText: 'Accept',
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  showCustomAcceptDialog(context, orders.id!);
                                },
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4.0),
                            child: SizedBox(
                              // width: 100,
                              // margin: const EdgeInsets.only(top: 24.0),
                              height: 45,
                              child: MyThemeButton(
                                fontSize: 12,
                                color: redColor,
                                buttonText: 'Reject',
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  showCustomRejectDialog(context, orders.id!);
                                },
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget assignedOrderItem(int index, AssignOrders orders) {
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
            padding: const EdgeInsets.fromLTRB(1.0, 5.0, 10.0, 5.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                        ),
                        child: StandardCustomText(
                          align: TextAlign.start,
                          label: orders.shop!,
                          color: negativeButtonColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )),
                      Expanded(
                          flex: 2,
                          child: Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  size: 12,
                                  Icons.access_time,
                                  color: descriptionTextColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Text('${orders.timeLeft!} min left ',
                                      style: const TextStyle(
                                          color: descriptionTextColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.0)),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(
                          left: 8,
                        ),
                        child: StandardCustomText(
                          align: TextAlign.start,
                          label: 'ORDER NO. ${orders.orderNumber!}',
                          color: descriptionTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )),
                    ],
                  ),
                ),
                const Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 20, right: 10.0),
                      child: StandardCustomText(
                        align: TextAlign.start,
                        label: 'Shop Address ',
                        color: descriptionTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
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
                          flex: 4,
                          child: StandardCustomText(
                            align: TextAlign.start,
                            maxlines: 4,
                            label: orders.shopAddress != null
                                ? orders.shopAddress!
                                : "",
                            color: negativeButtonColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          )),
                      Flexible(
                          flex: 1,
                          child: SvgPicture.asset(
                            sendLocationMarkerIcon,
                            // color: darkSkyBluePrimaryColor,
                            height: 40.0,
                            width: 40.0,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  StandardCustomText(
                                      align: TextAlign.start,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      maxlines: 2,
                                      label: "Total Amount"),
                                  StandardCustomText(
                                      color: descriptionTextColor,
                                      align: TextAlign.start,
                                      fontSize: 14,
                                      maxlines: 2,
                                      label: "Paid"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            // flex: 1,
                            child: StandardCustomText(
                                color: darkSkyBluePrimaryColor,
                                align: TextAlign.start,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                maxlines: 2,
                                label: '$rupeesString ${orders.total}'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4.0),
                            child: SizedBox(
                              // width: 100,
                              // margin: const EdgeInsets.only(top: 24.0),
                              height: 45,
                              child: MyThemeButton(
                                fontSize: 10,
                                buttonText: orders.orderStatus == 2
                                    ? 'Confirm Order Picked'
                                    : orders.orderStatus == 3
                                        ? 'Confirm Delivery'
                                        : orders.orderStatus == 4
                                            ? 'Delivered'
                                            : 'Confirm Order Picked',
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  if (orders.orderStatus == 2) {
                                    showCustomOrderPickedDialog(
                                        context, orders.id!);
                                  } else if (orders.orderStatus == 3) {
                                    showCustomOrderDeliveredDialog(
                                        context, orders.id!);
                                  }
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const ModifyQuotationScreen()),
                                  // );
                                },

                                // StandardCustomText(
                                //   label: 'Place an Order',
                                //   fontSize: 12,
                                //   fontWeight: FontWeight.w900,
                                //   color:
                                //       darkSkyBluePrimaryColor,
                                // ),
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4.0),
                            child: SizedBox(
                              // width: 100,
                              // margin: const EdgeInsets.only(top: 24.0),
                              height: 45,
                              child: MyThemeButton(
                                fontSize: 10,
                                color: redColor,
                                buttonText: 'Need more time',
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  showCustomNeedMoreTimeDialog(
                                      context, orders.id!);

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //       const PaymentMethodScreen()),
                                  // );
                                  // if (_formKey.currentState!
                                  //     .validate()) {
                                  //   onLoginButtonClicked();
                                  // }
                                },

                                // StandardCustomText(
                                //   label: 'Place an Order',
                                //   fontSize: 12,
                                //   fontWeight: FontWeight.w900,
                                //   color:
                                //       darkSkyBluePrimaryColor,
                                // ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void showCustomAcceptDialog(BuildContext context, int intOrderID) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
              color: Colors.transparent,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: SizeConfig.safeBlockVertical! * 20,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        SizeConfig.safeBlockVertical! * 2.0,
                        SizeConfig.safeBlockVertical! * 2.0,
                        SizeConfig.safeBlockVertical! * 2.0,
                        0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                          child: Center(
                            child: StandardCustomText(
                              label: 'Do you want to Accept Order?',
                              align: TextAlign.center,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 3.0,
                        ),
                        Row(
                          children: [
                            Center(
                              child: SizedBox(
                                width: SizeConfig.safeBlockHorizontal! * 40.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MyThemeButton(
                                    fontSize: 12,
                                    buttonText: 'Yes',
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (intOrderID != null) {
                                        dashboardBloc
                                            .add(AcceptOrderEvent(intOrderID));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: SizeConfig.safeBlockHorizontal! * 40.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MyThemeButton(
                                    fontSize: 12,
                                    buttonText: 'No',
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 1.0,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  void showCustomNeedMoreTimeDialog(BuildContext context, int intOrderID) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
              color: Colors.transparent,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: SizeConfig.safeBlockVertical! * 22,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        SizeConfig.safeBlockVertical! * 2.0,
                        SizeConfig.safeBlockVertical! * 2.0,
                        SizeConfig.safeBlockVertical! * 2.0,
                        0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                          child: Center(
                            child: Text(
                              // label:
                              'Do you need to Extra Time to Deliver Order?',

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 4,
                            ),

                            // child: StandardCustomText(
                            //   label:
                            //       'Do you need to Extra Time to Deliver Order?',
                            //   align: TextAlign.center,
                            //   fontSize: 15,
                            //   fontWeight: FontWeight.bold,
                            // ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 3.0,
                        ),
                        Row(
                          children: [
                            Center(
                              child: SizedBox(
                                width: SizeConfig.safeBlockHorizontal! * 40.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MyThemeButton(
                                    fontSize: 12,
                                    buttonText: 'Yes',
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (intOrderID != null) {
                                        dashboardBloc.add(
                                            ExtraTimeOrderEvent(intOrderID));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: SizeConfig.safeBlockHorizontal! * 40.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MyThemeButton(
                                    fontSize: 12,
                                    buttonText: 'No',
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 1.0,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  Future<void> showCustomRejectDialog(
      BuildContext context, int intOrderID) async {
    return await showDialog(
        context: context,
        builder: (context) {
          // bool isChecked = false;
          int reasonType = 0;
          String? deliveryType = "deliver";
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(20),
              content: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10),
                      child: Column(
                        children: [
                          Column(
                            // mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // width: 100,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: 1,
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          // contentPadding: EdgeInsets.all(0),
                                          groupValue: reasonType,
                                          onChanged: (value) {
                                            setState(() {
                                              reasonType = value as int;
                                            });
                                          },
                                        ),
                                        StandardCustomText(
                                            label: 'Address is too far.',
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.safeBlockVertical! *
                                                    1.7),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: 0,
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          groupValue: reasonType,
                                          onChanged: (value) {
                                            setState(() {
                                              reasonType = value as int;
                                            });
                                          },
                                        ),
                                        StandardCustomText(
                                            label:
                                                'I don’t have particular reason.',
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.safeBlockVertical! *
                                                    1.7),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 3.0,
                    ),
                    Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal! * 30.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyThemeButton(
                                fontSize: 12,
                                buttonText: 'Submit',
                                onPressed: () {
                                  Navigator.pop(context);
                                  if (intOrderID != null) {
                                    dashboardBloc
                                        .add(RejectOrderEvent(intOrderID));
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal! * 30.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyThemeButton(
                                fontSize: 12,
                                buttonText: 'Cancel',
                                onPressed: () {
                                  Navigator.pop(context);
                                  // if (intOrderID != null) {
                                  //   dashboardBloc.add(RejectOrderEvent(intOrderID));
                                  // }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 1.0,
                    ),
                  ],
                ),
              ),
              title: Text('FAQ for rejected order'),
            );
          });
        });
  }

  getAssignedList() async {
    var storage = FlutterSecureStorage();

    String? token = await storage.read(key: keyUserToken);
    debugPrint("vcarez customer reading access token have is $token");
    AssignOrderModel responseData =
        await ApiController().getAssignOrderList(token!);

    if (responseData.success == false) {
      CommonUtils.utils.showToast(responseData.message as String);
      // emit(ErrorAssignOrderLoading());
    } else if (responseData.success!) {
      setState(() {
        assignOrderModel = responseData;
      });
      // emit(AssignOrderDataLoaded(responseData));
    }
  }

  getNewOrderList() async {
    var storage = FlutterSecureStorage();

    String? token = await storage.read(key: keyUserToken);
    debugPrint("vcarez customer reading access token have is $token");
    String? strLatitude = await storage.read(key: keyUserLat);
    String? strLongitude = await storage.read(key: keyUserLong);
    NewOrderModel responseData = await ApiController()
        .getNewOrderList(token!, strLatitude!, strLongitude!);

    if (responseData.success == false) {
      CommonUtils.utils.showToast(responseData.message as String);
      // emit(ErrorAssignOrderLoading());
    } else if (responseData.success!) {
      setState(() {
        newOrderModel = responseData;
      });
      // emit(AssignOrderDataLoaded(responseData));
    }
  }

  void showCustomOrderPickedDialog(BuildContext context, int intOrderID) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
              color: Colors.transparent,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: SizeConfig.safeBlockVertical! * 22,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        SizeConfig.safeBlockVertical! * 2.0,
                        SizeConfig.safeBlockVertical! * 2.0,
                        SizeConfig.safeBlockVertical! * 2.0,
                        0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                          child: Center(
                            child: Text(
                              // label:
                              'Have you picked order for delivery?',

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 4,
                            ),

                            // child: StandardCustomText(
                            //   label:
                            //       'Do you need to Extra Time to Deliver Order?',
                            //   align: TextAlign.center,
                            //   fontSize: 15,
                            //   fontWeight: FontWeight.bold,
                            // ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 3.0,
                        ),
                        Row(
                          children: [
                            Center(
                              child: SizedBox(
                                width: SizeConfig.safeBlockHorizontal! * 40.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MyThemeButton(
                                    fontSize: 12,
                                    buttonText: 'Yes',
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (intOrderID != null) {
                                        dashboardBloc
                                            .add(OrderPickedEvent(intOrderID));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: SizeConfig.safeBlockHorizontal! * 40.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MyThemeButton(
                                    fontSize: 12,
                                    buttonText: 'No',
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 1.0,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  void showCustomOrderDeliveredDialog(BuildContext context, int intOrderID) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
              color: Colors.transparent,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: SizeConfig.safeBlockVertical! * 22,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        SizeConfig.safeBlockVertical! * 2.0,
                        SizeConfig.safeBlockVertical! * 2.0,
                        SizeConfig.safeBlockVertical! * 2.0,
                        0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                          child: Center(
                            child: Text(
                              // label:
                              'Is the Order Delivered Successfully ?',

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 4,
                            ),

                            // child: StandardCustomText(
                            //   label:
                            //       'Do you need to Extra Time to Deliver Order?',
                            //   align: TextAlign.center,
                            //   fontSize: 15,
                            //   fontWeight: FontWeight.bold,
                            // ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 3.0,
                        ),
                        Row(
                          children: [
                            Center(
                              child: SizedBox(
                                width: SizeConfig.safeBlockHorizontal! * 40.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MyThemeButton(
                                    fontSize: 12,
                                    buttonText: 'Yes',
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (intOrderID != null) {
                                        dashboardBloc.add(
                                            OrderDeliveredEvent(intOrderID));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: SizeConfig.safeBlockHorizontal! * 40.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MyThemeButton(
                                    fontSize: 12,
                                    buttonText: 'No',
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 1.0,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
