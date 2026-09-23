import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/admin/data/admin_repository.dart';
import 'package:flutter/material.dart';
class AdminContentScreen extends StatelessWidget{const AdminContentScreen({super.key,this.repository});final AdminRepository? repository;
@override Widget build(BuildContext context){final s=AppLocalizations.of(context);final r=repository??adminRepository;return AnimatedBuilder(animation:r,builder:(context,_)=>
Scaffold(appBar:AppBar(title:Text(s.adminContent)),body:ListView(padding:const EdgeInsets.all(AppSpacing.lg),children:r.content.map((x)=>Card(child:ListTile(leading:Icon(x.removed?Icons.delete_outline:Icons.flag_outlined),title:Text(x.title),subtitle:Text(x.kind),trailing:Wrap(spacing:4,children:[TextButton(onPressed:()=>r.setContentRemoved(x.id,true),child:Text(s.adminRemove)),TextButton(onPressed:()=>r.setContentRemoved(x.id,false),child:Text(s.adminKeep))])))).toList())));});}}