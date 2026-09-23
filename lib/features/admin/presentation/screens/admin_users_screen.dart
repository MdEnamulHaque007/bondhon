import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/admin/data/admin_repository.dart';
import 'package:flutter/material.dart';
class AdminUsersScreen extends StatefulWidget{const AdminUsersScreen({super.key,this.repository});final AdminRepository? repository;@override State<AdminUsersScreen> createState()=>_AdminUsersScreenState();}
class _AdminUsersScreenState extends State<AdminUsersScreen>{late final AdminRepository _repo;final _search=TextEditingController();
@override void initState(){super.initState();_repo=widget.repository??adminRepository;_search.addListener(()=>setState((){}));}@override void dispose(){_search.dispose();super.dispose();}
@override Widget build(BuildContext context){final s=AppLocalizations.of(context);return AnimatedBuilder(animation:_repo,builder:(context,_){final q=_search.text.trim().toLowerCase();final users=_repo.users.where((u)=>u.name.toLowerCase().contains(q)||u.username.toLowerCase().contains(q)).toList();return Scaffold(appBar:AppBar(title:Text(s.adminUsers)),body:ListView(padding:const EdgeInsets.all(AppSpacing.lg),children:[
TextField(controller:_search,decoration:InputDecoration(labelText:s.adminSearchUsers,prefixIcon:const Icon(Icons.search_rounded))),const SizedBox(height:AppSpacing.md),
...users.map((u)=>Card(child:ListTile(title:Text(u.name),subtitle:Text('@'+u.username),trailing:Wrap(spacing:4,children:[
_StatusBadge(u.status,_status(s,u.status)),PopupMenuButton<AdminUserStatus>(onSelected:(v)=>_repo.setUserStatus(u.id,v),itemBuilder:(context)=>[
PopupMenuItem(value:AdminUserStatus.warned,child:Text(s.adminWarn)),PopupMenuItem(value:AdminUserStatus.suspended,child:Text(s.adminSuspend)),PopupMenuItem(value:AdminUserStatus.banned,child:Text(s.adminBan)),PopupMenuItem(value:AdminUserStatus.active,child:Text(s.adminUnban))])])))]));});}
String _status(AppLocalizations s,AdminUserStatus v){switch(v){case AdminUserStatus.active:return s.adminActive;case AdminUserStatus.warned:return s.adminWarned;case AdminUserStatus.suspended:return s.adminSuspended;case AdminUserStatus.banned:return s.adminBanned;}}}
class _StatusBadge extends StatelessWidget{const _StatusBadge(this.status,this.label);final AdminUserStatus status;final String label;@override Widget build(BuildContext context){final c=Theme.of(context).colorScheme;final a=status==AdminUserStatus.active;return Chip(label:Text(label),backgroundColor:a?c.primaryContainer:c.errorContainer,labelStyle:TextStyle(color:a?c.onPrimaryContainer:c.onErrorContainer));}}