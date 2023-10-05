import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'blog.dart';

class CatalogModel {
  final List<Blog> blogs;
  CatalogModel({
    required this.blogs,
  });

  CatalogModel copyWith({
    List<Blog>? blogs,
  }) {
    return CatalogModel(
      blogs: blogs ?? this.blogs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'blogs': blogs.map((x) => x.toMap()).toList(),
    };
  }

  factory CatalogModel.fromMap(Map<String, dynamic> map) {
    return CatalogModel(
      blogs: List<Blog>.from((map['blogs'] as List<int>).map<Blog>((x) => Blog.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory CatalogModel.fromJson(String source) => CatalogModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CatalogModel(blogs: $blogs)';

  @override
  bool operator ==(covariant CatalogModel other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.blogs, blogs);
  }

  @override
  int get hashCode => blogs.hashCode;
}