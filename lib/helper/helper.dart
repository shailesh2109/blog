
import 'package:flutter/material.dart';


abstract class ModifiedConstraints{
  static width(BuildContext context)=>MediaQuery.of(context).size.width;
  static height(BuildContext context)=>MediaQuery.of(context).size.height;
}
