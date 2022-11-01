class ProfileUserCredentialModel {
  ProfileUserCredentialModel({
    String? atHash,
    int? exp,
    String? azp,
    String? nonce,
    String? picture,
    String? locale,
    String? iss,
    bool? emailVerified,
    String? sub,
    String? aud,
    String? familyName,
    int? iat,
    String? email,
    String? name,
    String? givenName,
  }) {
    _atHash = atHash;
    _exp = exp;
    _azp = azp;
    _nonce = nonce;
    _picture = picture;
    _locale = locale;
    _iss = iss;
    _emailVerified = emailVerified;
    _sub = sub;
    _aud = aud;
    _familyName = familyName;
    _iat = iat;
    _email = email;
    _name = name;
    _givenName = givenName;
  }

  ProfileUserCredentialModel.fromJson(dynamic json) {
    _atHash = json['at_hash'];
    _exp = json['exp'];
    _azp = json['azp'];
    _nonce = json['nonce'];
    _picture = json['picture'];
    _locale = json['locale'];
    _iss = json['iss'];
    _emailVerified = json['email_verified'];
    _sub = json['sub'];
    _aud = json['aud'];
    _familyName = json['family_name'];
    _iat = json['iat'];
    _email = json['email'];
    _name = json['name'];
    _givenName = json['given_name'];
  }

  String? _atHash;
  int? _exp;
  String? _azp;
  String? _nonce;
  String? _picture;
  String? _locale;
  String? _iss;
  bool? _emailVerified;
  String? _sub;
  String? _aud;
  String? _familyName;
  int? _iat;
  String? _email;
  String? _name;
  String? _givenName;

  String? get atHash => _atHash;

  int? get exp => _exp;

  String? get azp => _azp;

  String? get nonce => _nonce;

  String? get picture => _picture;

  String? get locale => _locale;

  String? get iss => _iss;

  bool? get emailVerified => _emailVerified;

  String? get sub => _sub;

  String? get aud => _aud;

  String? get familyName => _familyName;

  int? get iat => _iat;

  String? get email => _email;

  String? get name => _name;

  String? get givenName => _givenName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['at_hash'] = _atHash;
    map['exp'] = _exp;
    map['azp'] = _azp;
    map['nonce'] = _nonce;
    map['picture'] = _picture;
    map['locale'] = _locale;
    map['iss'] = _iss;
    map['email_verified'] = _emailVerified;
    map['sub'] = _sub;
    map['aud'] = _aud;
    map['family_name'] = _familyName;
    map['iat'] = _iat;
    map['email'] = _email;
    map['name'] = _name;
    map['given_name'] = _givenName;
    return map;
  }
}
