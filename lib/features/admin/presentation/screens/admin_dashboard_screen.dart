import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/admin/data/admin_repository.dart';
import 'package:bondhon/features/admin/presentation/widgets/admin_demo_banner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class AdminDashboardScreen extends StatelessWidget{const AdminDashboardScreen({super.key,this.repository});final AdminRepository? repository;
@override Widget build(BuildContext context){final s=AppLocalizations.of(context);final r=repository??adminRepository;return AnimatedBuilder(animation:r,builder:(context,_)=>
Scaffold(appBar:AppBar(title:Text(s.adminDashboard)),body:ListView(padding:const EdgeInsets.all(AppSpacing.lg),children:[
const AdminDemoBanner(),const SizedBox(height:AppSpacing.md),Text(s.adminLastUpdated,style:Theme.of(context).textTheme.bodySmall),const SizedBox(height:AppSpacing.md),
LayoutBuilder(builder:(context,c){final n=c.maxWidth>=760?5:2;final w=(c.maxWidth-(n-1)*AppSpacing.md)/n;return Wrap(spacing:AppSpacing.md,runSpacing:AppSpacing.md,children:[
_KpiCard(s.totalUsers,r.totalUsers,w),_KpiCard(s.dailyActiveUsers,r.dailyActiveUsers,w),_KpiCard(s.messagesSent,r.messagesSent,w),_KpiCard(s.activeRooms,r.activeRooms,w),_KpiCard(s.openReports,r.openReports,w)]);}),
const SizedBox(height:AppSpacing.lg),Card(child:Column(children:[
ListTile(leading:const Icon(Icons.people_outline_rounded),title:Text(s.adminUsers),trailing:const Icon(Icons.chevron_right_rounded),onTap:()=>context.go(AppRoutes.adminUsers)),
const Divider(height:1),ListTile(leading:const Icon(Icons.flag_outlined),title:Text(s.adminReports),trailing:const Icon(Icons.chevron_right_rounded),onTap:()=>context.go(AppRoutes.adminReports)),
const Divider(height:1),ListTile(leading:const Icon(Icons.gavel_outlined),title:Text(s.adminContent),trailing:const Icon(Icons.chevron_right_rounded),onTap:()=>context.go(AppRoutes.adminContent))]))]));});}}
class _KpiCard extends StatelessWidget{const _KpiCard(this.label,this.value,this.width);final String label;final int value;final double width;
@override Widget build(BuildContext context)=>SizedBox(width:width,child:Card(child:Padding(padding:const EdgeInsets.all(AppSpacing.md),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(label),const SizedBox(height:8),Text('$value',style:Theme.of(context).textTheme.headlineSmall)]))));}