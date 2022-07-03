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

int sa(Points a, Points b, Points c) {
  double ans =
      a.x * b.y - b.x * a.y + b.x * c.y - c.x * b.y + c.x * a.y - a.x * c.y;
  return ans > 0
      ? 1
      : ans < 0
          ? -1
          : 0;
}

// public int Compare(PointLatLng a, PointLatLng b)
//             {
//                 double cmp = -GetSignedArea(Pivot,a,b);
                
//                 return cmp > 0 ? 1 : cmp < 0 ? -1 : 0;
                
//                 //return cmp > 0 ? 1 : cmp < 0 ? -1 : 0;
//             }