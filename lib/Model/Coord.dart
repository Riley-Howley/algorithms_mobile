/*
  Class Title: CoordModel.
  What it does:
  Is the model to house the JsonObjects decoded 
 */

class CoordModel {
  String userid;
  String latitude;
  String longitude;
  String description;

  CoordModel(
    this.userid,
    this.latitude,
    this.longitude,
    this.description,
  );
}
