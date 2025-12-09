// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:masari_masari/firebase_options.dart';
import 'package:masari_masari/screens/auth/profile_screen.dart';
import 'package:masari_masari/screens/auth/rigester_screen.dart';
import 'package:masari_masari/screens/notifications/view/notifications_screen.dart';
import 'theme.dart';
import 'routes.dart';
import 'screens/home/home_screen.dart';
import 'screens/search/search_screen.dart';
import 'screens/opportunities/opportunities_screen.dart';
import 'screens/opportunities/opportunity_details_screen.dart';
import 'screens/opportunities/opportunity_apply_screen.dart';
import 'screens/opportunities/filter_screen.dart';
import 'screens/cv/cv_builder_screen.dart';
import 'screens/events/events_screen.dart';
import 'screens/experts/mentor_chat_screen.dart';
import 'screens/community/community_screen.dart';
import 'screens/auth/login_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MasariApp());
}

class MasariApp extends StatelessWidget {
  const MasariApp({Key? key}) : super(key: key);

  Route<dynamic>? _onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.notifications:
        return MaterialPageRoute(builder: (_) => NotificationsScreen());
      case Routes.search:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case Routes.opportunities:
        return MaterialPageRoute(builder: (_) => OpportunitiesScreen());
      case Routes.opportunityDetails:
        return MaterialPageRoute(builder: (_) => OpportunityDetailsScreen(), settings: settings);
      case Routes.opportunityApply:
        return MaterialPageRoute(builder: (_) => OpportunityApplyScreen(), settings: settings);
      case Routes.opportunityFilter:
        return MaterialPageRoute(builder: (_) => FilterScreen());
      case Routes.cvBuilder:
        return MaterialPageRoute(builder: (_) => CVBuilderScreen());
      case Routes.events:
        return MaterialPageRoute(builder: (_) => EventsScreen());
      case Routes.experts:
        return MaterialPageRoute(builder: (_) => MentorChatScreen());
      case Routes.community:
        return MaterialPageRoute(builder: (_) => CommunityScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مساري',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: _onGenerate,
      initialRoute: Routes.home,
      builder: (context, child) => Directionality(textDirection: TextDirection.rtl, child: child ?? SizedBox.shrink()),
    );
  }
}
