import 'package:flutter/foundation.dart';

enum AdminUserStatus { active, warned, suspended, banned }
enum AdminReportStatus { open, reviewed, dismissed }

class AdminActionRecord {
  const AdminActionRecord({
    required this.userId,
    required this.action,
    required this.reason,
    required this.createdAt,
  });
  final String userId;
  final AdminUserStatus action;
  final String reason;
  final DateTime createdAt;
}

class AdminUser {
  const AdminUser({required this.id, required this.name, required this.username, this.status = AdminUserStatus.active});
  final String id; final String name; final String username; final AdminUserStatus status;
  AdminUser copyWith({AdminUserStatus? status}) => AdminUser(id:id,name:name,username:username,status:status??this.status);
}
class AdminReport {
  const AdminReport({required this.id,required this.target,required this.kind,this.status=AdminReportStatus.open});
  final String id; final String target; final String kind; final AdminReportStatus status;
  AdminReport copyWith({AdminReportStatus? status}) => AdminReport(id:id,target:target,kind:kind,status:status??this.status);
}
class AdminContentFlag {
  const AdminContentFlag({required this.id,required this.title,required this.kind,this.removed=false});
  final String id; final String title; final String kind; final bool removed;
  AdminContentFlag copyWith({bool? removed}) => AdminContentFlag(id:id,title:title,kind:kind,removed:removed??this.removed);
}
class AdminRepository extends ChangeNotifier {
  AdminRepository({List<AdminUser>? users,List<AdminReport>? reports,List<AdminContentFlag>? content})
      : _users=List.of(users??_mockUsers),_reports=List.of(reports??_mockReports),_content=List.of(content??_mockContent);
  static final _mockUsers=<AdminUser>[
    const AdminUser(id:'u1',name:'Ayesha Rahman',username:'ayesha'),const AdminUser(id:'u2',name:'Rafi Hasan',username:'rafi_h'),
    const AdminUser(id:'u3',name:'Nabila Sultana',username:'nabila'),const AdminUser(id:'u4',name:'Tanvir Ahmed',username:'tanvir'),const AdminUser(id:'u5',name:'Sabbir Khan',username:'sabbir')];
  static final _mockReports=<AdminReport>[
    const AdminReport(id:'r1',target:'Rafi Hasan',kind:'user'),const AdminReport(id:'r2',target:'Room: Dhaka Foodies',kind:'room'),
    const AdminReport(id:'r3',target:'Post #104',kind:'post'),const AdminReport(id:'r4',target:'Message #77',kind:'message')];
  static final _mockContent=<AdminContentFlag>[
    const AdminContentFlag(id:'c1',title:'Giveaway post #104',kind:'post'),const AdminContentFlag(id:'c2',title:'Dhaka Foodies room',kind:'room'),const AdminContentFlag(id:'c3',title:'Comment #881',kind:'comment')];
  final List<AdminUser> _users; final List<AdminReport> _reports; final List<AdminContentFlag> _content;
  final List<AdminActionRecord> _actionHistory = [];
  List<AdminUser> get users=>List.unmodifiable(_users); List<AdminReport> get reports=>List.unmodifiable(_reports); List<AdminContentFlag> get content=>List.unmodifiable(_content);
  List<AdminActionRecord> historyFor(String userId) => List.unmodifiable(_actionHistory.where((item) => item.userId == userId).toList().reversed);
  int get totalUsers=>_users.length; int get dailyActiveUsers=>3; int get messagesSent=>128; int get activeRooms=>4;
  int get openReports=>_reports.where((r)=>r.status==AdminReportStatus.open).length;
  void setUserStatus(String id,AdminUserStatus status){final i=_users.indexWhere((u)=>u.id==id);if(i<0)return;_users[i]=_users[i].copyWith(status:status);_actionHistory.add(AdminActionRecord(userId:id,action:status,reason:'Quick action',createdAt:DateTime.now()));notifyListeners();}
  void setUserStatusWithReason(String id,AdminUserStatus status,String reason){final i=_users.indexWhere((u)=>u.id==id);if(i<0)return;_users[i]=_users[i].copyWith(status:status);_actionHistory.add(AdminActionRecord(userId:id,action:status,reason:reason.trim().isEmpty?'No reason provided':reason.trim(),createdAt:DateTime.now()));notifyListeners();}
  void setReportStatus(String id,AdminReportStatus status){final i=_reports.indexWhere((r)=>r.id==id);if(i<0)return;_reports[i]=_reports[i].copyWith(status:status);notifyListeners();}
  void setContentRemoved(String id,bool removed){final i=_content.indexWhere((c)=>c.id==id);if(i<0)return;_content[i]=_content[i].copyWith(removed:removed);notifyListeners();}
}
final adminRepository=AdminRepository();