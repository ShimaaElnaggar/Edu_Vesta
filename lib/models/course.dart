import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vesta/models/category.dart';
import 'package:edu_vesta/models/instructor.dart';

class Course {
  String? id;
  String? image;
  String? title;
  double? price;
  String? concurrency;
  String? rank;
  bool? hasCertificate;
  int? totalHours;
  double? rating;
  DateTime? createdDate;
  Instructor? instructor;
  Category? category;

  Course({
    this.id,
    this.image,
    this.title,
    this.price,
    this.concurrency,
    this.hasCertificate,
    this.totalHours,
    this.rating,
    this.instructor,
    this.category,
    required this.rank,
    this.createdDate,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id : json['id'],
      image: json['image'],
      title: json['title'],
      price: json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'].toDouble(),
      rank: json['rank'],
      rating: json['rating'] is int
          ? (json['rating'] as int).toDouble()
          : json['rating'].toDouble(),
      concurrency: json['concurrency'],
      hasCertificate: json['hasCertificate'],
      totalHours: json['totalHours'],
      createdDate: json['created_date'] != null
          ? (json['created_date'] as Timestamp).toDate()
          : null,
        instructor : json['instructor'] != null
            ? Instructor.fromJson(json['instructor'])
            : null,
      category: Category.fromJson({
        'id': (json['category'] as DocumentReference).id,
      }),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'price': price,
      'concurrency': concurrency,
      'hasCertificate': hasCertificate,
      'totalHours': totalHours,
      'rating': rating,
      'instructor': instructor?.toJson(),
      'category': category?.toJson(),
    };
  }
}