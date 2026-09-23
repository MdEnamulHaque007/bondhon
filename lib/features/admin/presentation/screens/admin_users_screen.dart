import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/admin/data/admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key, this.repository});
  final AdminRepository? repository;
  @override State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}
class _AdminUsersScreenState extends State<AdminUsersScreen> {
  late final AdminRepository _repo; final _search=TextEditingController();
  @override void initState(){super.initState();_repo=widget.repository??adminRepository;_search.addListener(()=>setState((){}));}
  @override void dispose(){_search.dispose();super.dispose();}
  @override Widget build(BuildContext context){final s=AppLocalizations.of(context);return AnimatedBuilder(animation:_repo,builder:(context,_){
    final q=_search.text.trim().toLowerCase();final users=_repo.users.where((u)=>u.name.toLowerCase().contains(q)||u.username.toLowerCase().contains(q)).toList();
    return Scaffold(appBar:AppBar(title:Text(s.adminUsers)),body:ListView(padding:const EdgeInsets.all(AppSpacing.lg),children:[
      TextField(controller:_search,decoration:InputDecoration(labelText:s.adminSearchUsers,prefixIcon:const Icon(Icons.search_rounded))),const SizedBox(height:AppSpacing.md),
      for(final user in users) Card(child:ListTile(
        leading:CircleAvatar(child:Text(user.name.substring(0,1))),title:Text(user.name),subtitle:Text('@${user.username}'),
        onTap:()=>context.go('${AppRoutes.adminUsers}/${user.id}'),
        trailing:Wrap(spacing:4,children:[
          _StatusBadge(user.status,_statusLabel(s,user.status)),
          PopupMenuButton<AdminUserStatus>(tooltip:s.adminActions,onSelected:(v)=>_showActionDialog(context,user,v),itemBuilder:(context)=>[
            PopupMenuItem(value:AdminUserStatus.warned,child:Text(s.adminWarn)),PopupMenuItem(value:AdminUserStatus.suspended,child:Text(s.adminSuspend)),
            PopupMenuItem(value:AdminUserStatus.banned,child:Text(s.adminBan)),PopupMenuItem(value:AdminUserStatus.active,child:Text(s.adminUnban)),
          ]),
        ]),
      )),
    ]));});}
  String _statusLabel(AppLocalizations s,AdminUserStatus v){switch(v){case AdminUserStatus.active:return s.adminActive;case AdminUserStatus.warned:return s.adminWarned;case AdminUserStatus.suspended:return s.adminSuspended;case AdminUserStatus.banned:return s.adminBanned;}}
  Future<void> _showActionDialog(BuildContext context,AdminUser user,AdminUserStatus status) async{
    final s=AppLocalizations.of(context);final controller=TextEditingController();
    final confirmed=await showDialog<bool>(context:context,builder:(context)=>AlertDialog(
      title:Text(_actionTitle(s,status)),content:TextField(controller:controller,maxLines:3,decoration:InputDecoration(labelText:s.adminActionReason,hintText:s.adminActionReasonHint)),
      actions:[TextButton(onPressed:()=>Navigator.pop(context,false),child:Text(s.cancel)),FilledButton(onPressed:()=>Navigator.pop(context,true),child:Text(s.adminConfirmAction))]));
    if(context.mounted&&confirmed==true){_repo.setUserStatusWithReason(user.id,status,controller.text);ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(s.adminActionSaved)));}
    controller.dispose();
  }
  String _actionTitle(AppLocalizations s,AdminUserStatus v){switch(v){case AdminUserStatus.warned:return s.adminWarn;case AdminUserStatus.suspended:return s.adminSuspend;case AdminUserStatus.banned:return s.adminBan;case AdminUserStatus.active:return s.adminUnban;}}
}
class _StatusBadge extends StatelessWidget{const _StatusBadge(this.status,this.label);final AdminUserStatus status;final String label;
@override Widget build(BuildContext context){final c=Theme.of(context).colorScheme;final active=status==AdminUserStatus.active;return Chip(label:Text(label),backgroundColor:active?c.primaryContainer:c.errorContainer,labelStyle:TextStyle(color:active?c.onPrimaryContainer:c.onErrorContainer));}}
