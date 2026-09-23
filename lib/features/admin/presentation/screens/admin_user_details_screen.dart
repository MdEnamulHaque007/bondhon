import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/admin/data/admin_repository.dart';
import 'package:flutter/material.dart';

class AdminUserDetailsScreen extends StatelessWidget {
  const AdminUserDetailsScreen({super.key, required this.userId, this.repository});
  final String userId; final AdminRepository? repository;
  @override Widget build(BuildContext context){final s=AppLocalizations.of(context);final r=repository??adminRepository;return AnimatedBuilder(animation:r,builder:(context,_){
    AdminUser? user;
    for (final candidate in r.users) { if (candidate.id == userId) { user = candidate; break; } }
    if(user==null)return Scaffold(appBar:AppBar(title:Text(s.adminUserDetails)),body:Center(child:Text(s.userNotFound)));
    final history=r.historyFor(user.id);
    return Scaffold(appBar:AppBar(title:Text(s.adminUserDetails)),body:ListView(padding:const EdgeInsets.all(AppSpacing.lg),children:[
      Card(child:ListTile(leading:CircleAvatar(radius:28,child:Text(user.name.substring(0,1))),title:Text(user.name,style:Theme.of(context).textTheme.titleLarge),subtitle:Text('@${user.username}'),trailing:_StatusBadge(user.status,_status(s,user.status)))),
      const SizedBox(height:AppSpacing.md),
      Text(s.adminActions,style:Theme.of(context).textTheme.titleMedium),const SizedBox(height:AppSpacing.sm),
      Wrap(spacing:8,runSpacing:8,children:AdminUserStatus.values.map((v)=>OutlinedButton(onPressed:()=>_action(context,r,user,v),child:Text(_status(s,v)))).toList()),
      const SizedBox(height:AppSpacing.lg),Text(s.adminActionHistory,style:Theme.of(context).textTheme.titleMedium),const SizedBox(height:AppSpacing.sm),
      if(history.isEmpty) Text(s.adminNoHistory)
      else ...history.map((item)=>Card(child:ListTile(leading:const Icon(Icons.history_rounded),title:Text(_status(s,item.action)),subtitle:Text('${item.reason}\n${item.createdAt.toLocal().toString().substring(0,16)}')))),
    ]));
  });}
  String _status(AppLocalizations s,AdminUserStatus v){switch(v){case AdminUserStatus.active:return s.adminActive;case AdminUserStatus.warned:return s.adminWarned;case AdminUserStatus.suspended:return s.adminSuspended;case AdminUserStatus.banned:return s.adminBanned;}}
  Future<void> _action(BuildContext context,AdminRepository r,AdminUser user,AdminUserStatus status)async{final s=AppLocalizations.of(context);final c=TextEditingController();final ok=await showDialog<bool>(context:context,builder:(context)=>AlertDialog(title:Text(_status(s,status)),content:TextField(controller:c,maxLines:3,decoration:InputDecoration(labelText:s.adminActionReason,hintText:s.adminActionReasonHint)),actions:[TextButton(onPressed:()=>Navigator.pop(context,false),child:Text(s.cancel)),FilledButton(onPressed:()=>Navigator.pop(context,true),child:Text(s.adminConfirmAction))]));if(context.mounted&&ok==true){r.setUserStatusWithReason(user.id,status,c.text);ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(s.adminActionSaved)));}c.dispose();}
}
class _StatusBadge extends StatelessWidget{const _StatusBadge(this.status,this.label);final AdminUserStatus status;final String label;@override Widget build(BuildContext context){final c=Theme.of(context).colorScheme;final active=status==AdminUserStatus.active;return Chip(label:Text(label),backgroundColor:active?c.primaryContainer:c.errorContainer,labelStyle:TextStyle(color:active?c.onPrimaryContainer:c.onErrorContainer));}}
