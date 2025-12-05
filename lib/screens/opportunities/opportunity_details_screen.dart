import 'package:flutter/material.dart';
import 'package:masari_masari/core/halpers/navigation.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../models/opportunity_model.dart';
import '../../core/widgets/custom_button.dart';
import '../../routes.dart';

class OpportunityDetailsScreen extends StatelessWidget {
  const OpportunityDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments;
    final Opportunity op = arg as Opportunity? ??
        Opportunity(
            id: 'na',
            title: 'تفاصيل غير متوفرة',
            company: '',
            location: '',
            description: '');

    return Scaffold(
      appBar: CustomAppBar(title: 'تفاصيل الفرصة'),
      body: Stack(
        children: [
          // دوائر تصميمية خلفية بسيطة
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            right: -40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // الشعار في المنتصف
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'), // ضع مسار شعارك هنا
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  op.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  '${op.company} • ${op.location}',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 22, 22, 22),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      op.description,
                      style: TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      label: 'تقديم',
                      
                      onPressed: () =>
                          NavHelper.push(context, Routes.opportunityApply, args: op),
                    ),
                    SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text('مشاركة'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
