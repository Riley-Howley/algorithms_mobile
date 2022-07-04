/*
  Class Title: Points.
  What it does:
  Is a model used by the convex hull algorithm. The x and y stand for latitude and longitude.
  Within the Points class there is a tostring for testing purposes to print the Point.
  == operator to tell the HashSet how to identify one from another
  hashCode to do that aswell

 */

class Points {
  double x;
  double y;

  Points(
    this.x,
    this.y,
  );

  @override
  String toString() {
    return ("(${x},${y})");
  }

  @override
  bool operator ==(other) {
    Points o = other as Points;
    return x == o.x && y == o.y;
  }

  @override
  int get hashCode => (x + y).hashCode;

  double dist(Points o) {
    return (x - o.x) * (x - o.x) + (y - o.y) * (y - o.y);
  }
}

/*
  Method Title: SA (SignedArea).
  What it does:
  Using the abba formula tells us if the coordinate is Clockwise or anticlockwise based on the postion of
  the pivot. Due to LatLngs being double the signedArea returns an int variable but the ans is a double
  so we dont lose the accuracy. As Ken Described it as Circumcison.
 */

int sa(Points a, Points b, Points c) {
  double ans =
      a.x * b.y - b.x * a.y + b.x * c.y - c.x * b.y + c.x * a.y - a.x * c.y;
  return ans > 0
      ? 1
      : ans < 0
          ? -1
          : 0;
}
