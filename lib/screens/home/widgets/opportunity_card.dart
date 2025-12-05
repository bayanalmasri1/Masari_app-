import 'package:flutter/material.dart';
import '../../../models/opportunity_model.dart';
import '../../../app_colors.dart';

class OpportunityCard extends StatefulWidget {
  final Opportunity opportunity;
  final VoidCallback onDetails;
  final VoidCallback onApply;

  const OpportunityCard({
    Key? key,
    required this.opportunity,
    required this.onDetails,
    required this.onApply,
  }) : super(key: key);

  @override
  State<OpportunityCard> createState() => _OpportunityCardState();
}

class _OpportunityCardState extends State<OpportunityCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 180),
        width: 320,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _hover
              ? [
                  AppColors.softShadow,
                  BoxShadow(
                    color: AppColors.teal.withOpacity(0.08),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ]
              : [AppColors.softShadow],
          border: Border.all(
            color: _hover
                ? AppColors.teal.withOpacity(0.12)
                : Colors.transparent,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.opportunity.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.deepNavy,
              ),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.business, size: 16, color: AppColors.lightGray),
                SizedBox(width: 6),
                Text(
                  widget.opportunity.company,
                  style: TextStyle(color: AppColors.lightGray),
                ),
                Spacer(),
                Icon(Icons.location_on, size: 16, color: AppColors.lightGray),
                SizedBox(width: 6),
                Text(
                  widget.opportunity.location,
                  style: TextStyle(color: AppColors.lightGray),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              widget.opportunity.description,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: widget.onApply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.teal,
                  ),
                  child: Text('تقديم', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 8),
                TextButton(onPressed: widget.onDetails, child: Text('تفاصيل')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
