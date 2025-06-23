import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/chart/bindings/chart_binding.dart';
import '../modules/chart/views/chart_page.dart';
import '../modules/dealing_with_model/bindings/dealing_with_model_binding.dart';
import '../modules/dealing_with_model/views/dealing_with_model_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/streamlit/bindings/streamlit_binding.dart';
import '../modules/streamlit/views/streamlit_view.dart';
import '../modules/user_history/bindings/user_history_binding.dart';
import '../modules/user_history/views/user_history_view.dart';
import '../modules/verification/bindings/verification_binding.dart';
import '../modules/verification/views/verification_view.dart';
import '../modules/verification_success/bindings/verification_success_binding.dart';
import '../modules/verification_success/views/verification_success_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.DEALING_WITH_MODEL,
      page: () => const DealingWithModelView(),
      binding: DealingWithModelBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.CHART,
      page: () => const ChartPage(),
      binding: ChartBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => const VerificationView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION_SUCCESS,
      page: () => const VerificationSuccessView(),
      binding: VerificationSuccessBinding(),
    ),
    GetPage(
      name: _Paths.USER_HISTORY,
      page: () => const UserHistoryView(),
      binding: UserHistoryBinding(),
    ),
    GetPage(
      name: _Paths.STREAMLIT,
      page: () => const StreamlitView(),
      binding: StreamlitBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
  ];
}
