import 'package:edu_vesta/models/category.dart';
import 'package:edu_vesta/models/instructor.dart';

class Course {
  String? image;
  String? title;
  double? price;
  String? concurrency;
  bool? hasCertificate;
  int? totalHours;
  double? rating;
  Instructor? instructor;
  Category? category;

  Course({
    this.image,
    this.title,
    this.price,
    this.concurrency,
    this.hasCertificate,
    this.totalHours,
    this.rating,
    this.instructor,
    this.category,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      image: json['image'],
      title: json['title'],
      price: json['price'],
      concurrency: json['concurrency'],
      hasCertificate: json['hasCertificate'],
      totalHours: json['totalHours'],
      rating: json['rating'],
      instructor: Instructor.fromJson(json['instructor']),
      category: Category.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
