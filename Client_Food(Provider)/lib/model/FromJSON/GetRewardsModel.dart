class GetRewardsModel {
  String? status;
  Result? result;

  GetRewardsModel({this.status, this.result});

  GetRewardsModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  dynamic rewardPoint;
  dynamic minimumOrder;
  dynamic maximumValue;
  dynamic rewardPercentage;
  dynamic earnPoint;
  String? rewardAmount;
  String? rewardPoints;
  int? success;

  Result(
      {this.rewardPoint,
      this.minimumOrder,
      this.maximumValue,
      this.rewardPercentage,
      this.earnPoint,
      this.rewardAmount,
      this.rewardPoints,
      this.success});

  Result.fromJson(Map<String, dynamic> json) {
    this.rewardPoint = json["rewardPoint"];
    this.minimumOrder = json["minimum_order"];
    this.maximumValue = json["maximum_value"];
    this.rewardPercentage = json["rewardPercentage"];
    this.earnPoint = json["earn_point"];
    this.rewardAmount = json["rewardAmount"];
    this.rewardPoints = json["rewardPoints"];
    this.success = json["success"];
  }
}
