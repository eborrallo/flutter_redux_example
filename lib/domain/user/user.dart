class User {
    final String email;
    final String uid;

    User(this.email, this.uid);

    Map<String, dynamic> toJSON() => <String, dynamic>{
        'email': this.email,
        'uid': this.uid
    };

    factory User.fromJSON(Map<String, dynamic> json) => new User(
        json['email'],
        json['uid'],
    );

    @override
    String toString() {
        return '{email: $email, uid: $uid}';
    }
}