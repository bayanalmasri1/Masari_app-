import 'package:flutter/material.dart';
import 'package:masari_masari/core/halpers/navigation.dart';
import 'package:masari_masari/screens/home/widgets/opportunity_card.dart';
import '../../app_colors.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/search_bar.dart';

import '../../models/opportunity_model.dart';
import '../../routes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final sampleOpportunities = List.generate(
    6,
    (i) => Opportunity(
      id: 'op$i',
      title: 'تدريب صيفي ${i + 1}',
      company: 'شركة مثال ${i + 1}',
      location: i % 2 == 0 ? 'الرياض' : 'جدة',
      description: 'وصف تفصيلي للفرصة رقم ${i + 1}.',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'مساري'),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: 0,
            onDestinationSelected: (i) {
              // simple navigation mapping
              if (i == 1) NavigationHelper.pushToOpportunities(context);
              if (i == 2) NavigationHelper.pushToCV(context);
              if (i == 3) NavigationHelper.pushToEvents(context);
              if (i == 4) NavigationHelper.pushToExperts(context);
            },
            labelType: NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CircleAvatar(radius: 26, backgroundColor: AppColors.teal, child: Text('ب', style: TextStyle(color: Colors.white))),
            ),
            destinations: [
              NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: Text('الرئيسية')),
              NavigationRailDestination(icon: Icon(Icons.work_outline), selectedIcon: Icon(Icons.work), label: Text('الفرص')),
              NavigationRailDestination(icon: Icon(Icons.article_outlined), selectedIcon: Icon(Icons.article), label: Text('السيرة')),
              NavigationRailDestination(icon: Icon(Icons.event_note_outlined), selectedIcon: Icon(Icons.event_note), label: Text('ورش')),
              NavigationRailDestination(icon: Icon(Icons.forum_outlined), selectedIcon: Icon(Icons.forum), label: Text('المرشدون')),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('أهلاً بك في مساري', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 26)),
                SizedBox(height: 8),
                Row(children: [
                  SearchBarInline(),
                  SizedBox(width: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.tealDark),
                    onPressed: () => NavHelper.push(context, Routes.notifications),
                    icon: Icon(Icons.notifications,color: Colors.white),
                    label: Text('التنبيهات',style: TextStyle(color: Colors.white),),
                  ),
                ]),
                SizedBox(height: 18),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(children: [
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('ابحث عن فرصة عمل', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 6),
                          Text('ابدأ بالبحث الآن عن تدريب أو وظيفة متاحة تناسب مهاراتك.'),
                        ]),
                      ),
                      CustomSearchBox(onTap: () => NavHelper.push(context, Routes.opportunities)),
                    ]),
                  ),
                ),
                SizedBox(height: 20),
                Text('فرص مقترحة لك', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: sampleOpportunities
                      .map((op) => OpportunityCard(
                            opportunity: op,
                            onDetails: () => NavHelper.push(context, Routes.opportunityDetails, args: op),
                            onApply: () => NavHelper.push(context, Routes.opportunityApply, args: op),
                          ))
                      .toList(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// small custom mini search box used in home card
class CustomSearchBox extends StatelessWidget {
  final VoidCallback onTap;
  const CustomSearchBox({Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(Icons.search,color: Colors.white),
      label: Text('ابحث الآن',style: TextStyle(color: Colors.white),),
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.teal),
    );
  }
}

// helper mapper for quick navigation used above
class NavigationHelper {
  static pushToOpportunities(BuildContext ctx) => NavHelper.push(ctx, Routes.opportunities);
  static pushToCV(BuildContext ctx) => NavHelper.push(ctx, Routes.cvBuilder);
  static pushToEvents(BuildContext ctx) => NavHelper.push(ctx, Routes.events);
  static pushToExperts(BuildContext ctx) => NavHelper.push(ctx, Routes.experts);
}
