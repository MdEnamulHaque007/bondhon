import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/admin/data/admin_repository.dart';
import 'package:flutter/material.dart';
class AdminReportsScreen extends StatelessWidget{const AdminReportsScreen({super.key,this.repository});final AdminRepository? repository;
@override Widget build(BuildContext context){final s=AppLocalizations.of(context);final r=repository??adminRepository;return AnimatedBuilder(animation:r,builder:(context,_)=>
Scaffold(appBar:AppBar(title:Text(s.adminReports)),body:ListView(padding:const EdgeInsets.all(AppSpacing.lg),children:r.reports.map((x)=>Card(child:ListTile(leading:const Icon(Icons.flag_outlined),title:Text(x.target),subtitle:Text(x.kind),trailing:x.status==AdminReportStatus.open?Wrap(spacing:4,children:[TextButton(onPressed:()=>r.setReportStatus(x.id,AdminReportStatus.reviewed),child:Text(s.adminMarkReviewed)),TextButton(onPressed:()=>r.setReportStatus(x.id,AdminReportStatus.dismissed),child:Text(s.adminDismiss))]):Chip(label:Text(_status(s,x.status)))))).toList())));});}
String _status(AppLocalizations s,AdminReportStatus v){switch(v){case AdminReportStatus.open:return s.adminOpen;case AdminReportStatus.reviewed:return s.adminReviewed;case AdminReportStatus.dismissed:return s.adminDismissed;}}}