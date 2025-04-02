import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? name;
  final String? employmentDate;
  final String? jobTitle;
  final String? salary;
  final String? hourlyRate;
  final String? workedHours;
  final String? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? totalAbsence;
  final int? totalVacation;
  final int? totalAttendance;
  final int? totalPermissions;
  final int? totalExtraTime;

  const Datum({
    this.id,
    this.name,
    this.employmentDate,
    this.jobTitle,
    this.salary,
    this.hourlyRate,
    this.workedHours,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.totalAbsence,
    this.totalVacation,
    this.totalAttendance,
    this.totalPermissions,
    this.totalExtraTime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        employmentDate: json['employment_date'] as String?,
        jobTitle: json['job_title'] as String?,
        salary: json['salary'] as String?,
        hourlyRate: json['hourly_rate'] as String?,
        workedHours: json['worked_hours'] as String?,
        phone: json['phone'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        totalAbsence: json['total_absence'] as int?,
        totalVacation: json['total_vacation'] as int?,
        totalAttendance: json['total_attendance'] as int?,
        totalPermissions: json['total_permissions'] as int?,
        totalExtraTime: json['total_extra_time'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'employment_date': employmentDate,
        'job_title': jobTitle,
        'salary': salary,
        'hourly_rate': hourlyRate,
        'worked_hours': workedHours,
        'phone': phone,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'total_absence': totalAbsence,
        'total_vacation': totalVacation,
        'total_attendance': totalAttendance,
        'total_permissions': totalPermissions,
        'total_extra_time': totalExtraTime,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      employmentDate,
      jobTitle,
      salary,
      hourlyRate,
      workedHours,
      phone,
      createdAt,
      updatedAt,
      totalAbsence,
      totalVacation,
      totalAttendance,
      totalPermissions,
      totalExtraTime,
    ];
  }
}
