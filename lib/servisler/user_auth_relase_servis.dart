import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:physiomarapp/modeller/user_model.dart';
import 'package:physiomarapp/servisler/user_auth_base_servis.dart';



class UserAuthReleaseServis implements UserAuthBaseServis {
 final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String randomSayiUret() {
    int rasageleSayi = Random().nextInt(99999);
    return rasageleSayi.toString();
  }

  @override
  Future<User> signInAnonimusUser() async {
/*
    AuthResult _authResult = await _firebaseAuth.signInAnonymously();
    FirebaseUser _user = _authResult.user;

    var sonuc2 = User(
      email: "misafir@mail.com",
      userID: _user.uid,
      userName: "misafir" + randomSayiUret(),
      seviye: 1,
      latessRommName: "genel",
      createAT: DateTime.now(),
      updateAT: DateTime.now(),
      profilURL: "https://hakankucuk.com/images/user.png",
    );
    print("DB signInAnonimusUser return oldu");
    return sonuc2;

 */
return null;
  }

  @override
  Future<bool> signOutUser() async {

    try
    {
      await FirebaseAuth.instance.signOut();
    } catch (e)
    {
      print("sing Out User Error: "+e.toString());
    }

    print("DB signOutUser return oldu");
    return true;
  }

  @override
  Future<User> currentUser() async {
    User _user;
    var sonuc = await _firebaseAuth.currentUser();
    if(sonuc!=null)
      _user = User(
        userID: sonuc.uid,
        email: sonuc.email??"misafir@mail.com",
      );
    print("DB currentUser return oldu");
    return _user;
  }

  @override
  Future<User> signInWithGoogle() async {
    /*
    User _userModel;
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        AuthResult sonuc = await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        FirebaseUser _user = sonuc.user;
        if(sonuc!=null)
          _userModel = User(
            userID: _user.uid,
            email: _user.email,
            profilURL: _user.photoUrl
          );
        print("DB signInWithGoogle return oldu:"+_userModel.userID);
        return _userModel;
      }
    }
    return _userModel;

     */
    return null;
  }

  @override
  Future<User> signInWithFacebook() async {

    //final _userModel = Provider.of<UserViewModel>(context, listen: false);
/*
    FacebookLogin facebookLogin2 = FacebookLogin();
    //final result2 = await facebookLogin2.logIn(['email','public_profile']);
    FacebookLoginResult result3 =  await facebookLogin2.logIn((['email','public_profile']));

    switch (result3.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessTokenFacebook = result3.accessToken;
        print("Gelen Token :"+accessTokenFacebook.token.toString());
        //hatamiz=hatamiz+" Gelen Token :"+ accessTokenFacebook.token.toString();
        //hatamiz = accessTokenFacebook.token.toString();
        var sonucFaceBookFirebase = await FirebaseAuth.instance.signInWithCredential(
            FacebookAuthProvider.getCredential(accessToken: accessTokenFacebook.token.toString()));
       // hatamiz=hatamiz+" Firebase user oluşturulacak";
        FirebaseUser _user = sonucFaceBookFirebase.user;
       // hatamiz=hatamiz+" Firebase user Taemamm ";
        var userolustur = User(
          email: _user.email,
          userID: _user.uid,
          profilURL: _user.photoUrl + "?width=9999",
         // hata: "Token:"+accessTokenFacebook.token.toString(),
         // hata2: hatamiz,
          //profilURL: _user.photoUrl + "?width=9999",
          //createAT: DateTime.now(),
         // updateAT: DateTime.now(),
        );
        print("DB signInWithFacebook return oldu:");
        return userolustur;
        break;
    }
  return null;

 */
return null;

  }

  @override
  Future<User> createEmailPassword(String email, String password) async {
    print("release create amail deyiz $email $password");

    try
    {

      AuthResult sonuc = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print("user geldi : UID : "+ sonuc.user.uid);
      var sonuc2 = User(
        email: sonuc.user.email,
        userID: sonuc.user.uid,
        //userName: "misafir",
        //seviye: 1,
        //latessRommName: "genel",
        createAT: DateTime.now(),
        updateAT: DateTime.now(),

      );
      return sonuc2;
    } catch(e)
    {
      print("Hata :"+e.toString());

    }

    return null;
  }

  @override
  Future<User> signInEmailPassword(String email, String password) async {
    AuthResult sonuc = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    print("singin user geldi : UID : "+ sonuc.user.uid);
    var sonuc2 = User(
      email: sonuc.user.email,
      userID: sonuc.user.uid,
      //userName: "misafir",
      //seviye: 1,
      //latessRommName: "genel",
      createAT: DateTime.now(),
      updateAT: DateTime.now(),
    );
    return sonuc2;
  }
}
