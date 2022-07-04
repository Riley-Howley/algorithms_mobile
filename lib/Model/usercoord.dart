/*
  Class Title: UserCoord.
  What it does:
  Is the model to house the JsonObjects decoded 
 */

class UserCoord {
  String userid;
  String latitude;
  String longitude;
  String description;
  String created_at;

  UserCoord(this.userid, this.latitude, this.longitude, this.description,
      this.created_at);
}
