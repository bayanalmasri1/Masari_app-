import 'package:flutter/material.dart';
import 'package:masari_masari/core/halpers/navigation.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../models/opportunity_model.dart';

import '../home/widgets/opportunity_card.dart';
import '../../routes.dart';


class OpportunitiesScreen extends StatelessWidget {
  OpportunitiesScreen({Key? key}) : super(key: key);
   final sampleOpportunities = List.generate(
    20,
    (i) => Opportunity(
      id: 'op$i',
      title: 'تدريب صيفي ${i + 1}',
      company: 'شركة مثال ${i + 1}',
      location: i % 2 == 0 ? 'الرياض' : 'جدة',
      description: 'وصف تفصيلي للفرصة رقم ${i + 1}.',
    ),
  );


  final items = List.generate(
    12,
    (i) => Opportunity(
      id: 'o$i',
      title: 'فرصة رقم ${i + 1}',
      company: 'شركة ${i + 1}',
      location: i % 2 == 0 ? 'جدة' : 'الرياض',
      description: 'وصف الفرصة ${i + 1}',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'الفرص المتاحة'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(children: [
            Row(children: [
              Text('الفرص المتاحة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () => NavHelper.push(context, Routes.opportunityFilter),
                icon: Icon(Icons.filter_alt),
                label: Text('تصفية'),
              ),
            ]),
            SizedBox(height: 16),
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
    );
  }
}
