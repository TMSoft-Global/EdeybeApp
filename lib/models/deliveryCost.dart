class DeliveryCost {
  DeliveryCost({
    this.deliveryCost,
    this.overallCost,
    this.totalDistance,
    this.totalDistanceCost,
    this.totalWeight,
    this.totalWeightCost,
  });
  factory DeliveryCost.fromJson(Map<String, dynamic> json) => DeliveryCost(
      deliveryCost: json['deliveryCost'],
      overallCost: json['overallCost'],
      totalDistance: json['totalDistance'],
      totalDistanceCost: json['totalDistanceCost'],
      totalWeight: json['totalWeight'].toDouble(),
      totalWeightCost: json['totalWeightCost'].toDouble());
  double deliveryCost;
  String overallCost;
  double totalDistance;
  double totalDistanceCost;
  double totalWeight;
  double totalWeightCost;
  Map<String, dynamic> toJson() => {
        "deliveryCost": deliveryCost,
        "overallCost": overallCost,
        "totalDistance": totalDistance,
        "totalDistanceCost": totalDistanceCost,
        "totalWeight": totalWeight,
        "totalWeightCost": totalWeightCost
      };
}
