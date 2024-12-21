import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vcarez_delivery/splash/view/splash_screen.dart';
import 'package:vcarez_delivery/ui/login/view/login_screen.dart';
import 'package:vcarez_delivery/ui/dashboard/view/dashboard_screen.dart';
import 'package:vcarez_delivery/ui/registration/view/signup_screen.dart';
import 'utils/route_names.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeSplash:
        return MaterialPageRoute(
          builder: (context) =>
              // BlocProvider(
              //   create: (context) => LoginBloc(),
              //   child:
              const SplashScreen(),
          // )
        );
      //   case routeAddDeliveryMan:
      //     return MaterialPageRoute(
      //       builder: (context) =>
      //           // BlocProvider(
      //           //   create: (context) => LoginBloc(),
      //           //   child:
      //           const AddDeliveryMenScreen(),
      //       // )
      //     );
      case routeLogin:
        return MaterialPageRoute(
          builder: (context) =>
              // BlocProvider(
              //   create: (context) => LoginBloc(),
              //   child:
              const LoginScreen(),
        );
      case routeSignup:
        return MaterialPageRoute(
            builder: (context) =>
                // BlocProvider(
                //   create: (context) => SignupBloc(),
                //   child:
                const SignupScreen(),
            settings: settings
            // )
            );
      //   case routeEditRegistration:
      //     return MaterialPageRoute(
      //         builder: (context) =>
      //             // BlocProvider(
      //             //   create: (context) => SignupBloc(),
      //             //   child:
      //             const EditRegistrationScreen(),
      //         settings: settings
      //         // )
      //         );
      //
      case routeDashboard:
        return MaterialPageRoute(
          builder: (context) =>
              // BlocProvider(
              //   create: (context) => LoginBloc(),
              //   child:
              const DashboardScreen(),
          // )
        );
      //   case routeMedicineDetails:
      //     return MaterialPageRoute(
      //         builder: (context) =>
      //             // BlocProvider(
      //             //   create: (context) => LoginBloc(),
      //             //   child:
      //             const MedicineDetailPageWidget(),
      //         settings: settings
      //         // )
      //         );
      //   case routeMedicineDatabase:
      //     return MaterialPageRoute(
      //         builder: (context) => BlocProvider(
      //               create: (context) => MedicineDatabaseBloc(),
      //               child: const MedicineDatabasePage(),
      //             ));
      //   // case routeMyProfile:
      //   // return MaterialPageRoute(
      //   //   // builder: (context) => const MyProfileScreen(),
      //   // );
      //   // case routeEditProfile:
      //   //   return MaterialPageRoute(
      //   //     builder: (context) => BlocProvider(
      //   //         create: (context) => EditProfileBloc(),
      //   //         child: const EditProfileScreen()),
      //   //   );
      //   // case routeUploadPrescription:
      //   //   return MaterialPageRoute(
      //   //     builder: (context) => AddPrescriptionPage(),
      //   //   );
      //   case routeForgotPassword:
      //     return MaterialPageRoute(
      //       builder: (context) => BlocProvider(
      //           create: (context) => ForgotPasswordBloc(),
      //           child: const ForgotPasswordScreen()),
      //     );
      //
      //   case routePersonalDetails:
      //     return MaterialPageRoute(
      //         builder: (context) =>
      //             // BlocProvider(
      //             //   create: (context) => LoginBloc(),
      //             //   child:
      //             const PersonalDetailScreen(),
      //         settings: settings
      //         // )
      //         );
      //   case routeEditPersonalDetails:
      //     return MaterialPageRoute(
      //         builder: (context) =>
      //             // BlocProvider(
      //             //   create: (context) => LoginBloc(),
      //             //   child:
      //             const EditPersonalDetailScreen(),
      //         settings: settings
      //         // )
      //         );
      //   case routeBusinessDetails:
      //     return MaterialPageRoute(
      //         builder: (context) =>
      //             // BlocProvider(
      //             //   create: (context) => LoginBloc(),
      //             //   child:
      //             const BusinessDetailScreen(),
      //         settings: settings
      //         // )
      //         );
      //   case routeEditBusinessDetails:
      //     return MaterialPageRoute(
      //         builder: (context) =>
      //             // BlocProvider(
      //             //   create: (context) => LoginBloc(),
      //             //   child:
      //             const EditBusinessDetailScreen(),
      //         settings: settings
      //         // )
      //         );
      //   case routeGSTDetails:
      //     return MaterialPageRoute(
      //         builder: (context) =>
      //             // BlocProvider(
      //             //   create: (context) => LoginBloc(),
      //             //   child:
      //             const ShopRegistrationDetailScreen(),
      //         settings: settings
      //         // )
      //         );
      //   case routeEditGSTDetails:
      //     return MaterialPageRoute(
      //         builder: (context) =>
      //             // BlocProvider(
      //             //   create: (context) => LoginBloc(),
      //             //   child:
      //             const EditShopRegistrationDetailScreen(),
      //         settings: settings
      //         // )
      //         );
      //   case routeTopSearchList:
      //     return MaterialPageRoute(
      //         builder: (context) =>
      //             // BlocProvider(
      //             //   create: (context) => LoginBloc(),
      //             //   child:
      //             const PopularMedicineScreen(),
      //         settings: settings
      //         // )
      //         );
      //   case routeLicenseDetails:
      //     return MaterialPageRoute(
      //       builder: (context) => BlocProvider(
      //         create: (context) => RegisterBloc(),
      //         child: const LicenseDetailScreen(),
      //       ),
      //       settings: settings,
      //     );
      //   case routeEditLicenseDetails:
      //     return MaterialPageRoute(
      //       builder: (context) => BlocProvider(
      //         create: (context) => RegisterBloc(),
      //         child: const EditLicenseDetailScreen(),
      //       ),
      //       settings: settings,
      //     );
      //   case routeBidCorner:
      //     return MaterialPageRoute(
      //       builder: (context) => const BidCornerListScreen(),
      //       settings: settings,
      //     );
      //   case routeRFCQuotationDetails:
      //     return MaterialPageRoute(
      //       builder: (context) => const RFCDetailsPage(),
      //       settings: settings,
      //     );
      //   case routeMedicineDataEntry:
      //     return MaterialPageRoute(
      //       builder: (context) => const MedicineDataEntryPage(),
      //       settings: settings,
      //     );
      //
      //     case routeMyQuotation:
      //     return MaterialPageRoute(
      //       builder: (context) => const MyQuotationsScreen(),
      //       settings: settings,
      //     );
      // }
    }
  }
}
