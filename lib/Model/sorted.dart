import 'package:algorithm_mobile/Model/usercoord.dart';

/*
  Class Title: SortedUse.
  What it does:
  Is a model that stores all a users Positions. UserID and List of usercoords.
 */

class SortedUser {
  String UserID;
  List<UserCoord> list;

  SortedUser(this.UserID, this.list);
}
