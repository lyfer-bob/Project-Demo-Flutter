import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:/model/FromJSON/CustomerLoginModel.dart';
import 'package:/model/FromJSON/ProfileUserCredentialModel.dart';
import 'package:/model/FromJSON/SuccessModel.dart';
import 'package:/model/FromJSON/requestOTPRegistModel.dart';
import 'package:/model/FromJSON/requestOTPforgotModel.dart';
import 'package:/model/FromJSON/requestOTPmedel.dart';
import 'package:/model/FromJSON/requestOTPLoginModel.dart';
import 'package:/model/FromJSON/verfityOTPforgotModel.dart';
import 'package:/model/FromJSON/verifyOTPLoginModel.dart';
import 'package:/model/FromJSON/verifyOTPRegistRodel.dart';
import 'package:/model/ToJSON/CustomerSignUpModel.dart';
import 'package:/screen/Fragment/FragmentProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/services/auth_service.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/DialogsStatus.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:/screen/Fragment/Account/Authen/provider/RigisterProvider.dart';

class AuthBloc {
  final authService = AuthService();

  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   // Optional clientId
  //   // clientId: '',
  //   scopes: <String>[
  //     'email',
  //   ],
  // );

  SharedPreferences? preferences;

  Stream<User?> get currentUser => authService.currentUser;

  ProfileUserCredentialModel? credentialModel;

  CustomerLoginModel? signInModel;
  CustomerSignUpModel? createUserModel;
  SuccessModel? successModel;

  RequestOTPMedel? requestOTPmodel;
  RequestOTPForgotModel? requestOTPForgotModel;
  VerfityOTPForgotModel? verfityOTPForgotModel;
  RequestOTPLoginModel? requestOTPLogin;
  VerifyOTPLoginModel? verifyOTPLoginModel;
  RequestOTPRegistModel? requestOTPRegistModel;
  VerifyOTPRegistModel? verifyOTPRegistModel;

  String? firebaseUserType;

  /////////////////////////////////////////////////////////////////////////////
  ///     AFTER FIND GetX Snippets                                          ///
  /////////////////////////////////////////////////////////////////////////////
//google_sign_in: ^5.2.1
  Future<Null> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
s
      // Once signed in, return the UserCredential
      var result = await FirebaseAuth.instance.signInWithCredential(credential);

      credentialModel = ProfileUserCredentialModel.fromJson(
          result.additionalUserInfo!.profile);

      // var preferences = await SharedPreferences.getInstance();

      // preferences.setString('avatorImg', credentialModel!.picture.toString());

      // print("FromcredentialModel:::${credentialModel!.givenName}");
      // print("FromcredentialModel:::${credentialModel!.familyName}");
      // print("FromcredentialModel:::${credentialModel!.picture}");

      RegisterProvider().sendCreateUserThirdParty(
        context: context,
        email: credentialModel!.email,
        firstname: credentialModel!.givenName != null
            ? credentialModel!.givenName
            : '',
        lastname: credentialModel!.familyName != null
            ? credentialModel!.familyName
            : '',
      );
    } on Exception catch (_) {
      normalDialog(context, 'ไม่สามารถทำการเข้าสู่ระบบได้');
    } catch (err) {
      print('loginGoogleError   ::::$err');
      normalDialog(context, 'ไม่สามารถทำการเข้าสู่ระบบได้');
    }
  }

  //sign_in_with_apple: ^3.0.0
  //crypto: ^3.0.1
  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<Null> signInWithApple(BuildContext context) async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      var result =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      String _firstNameStr =
          result.user!.displayName.toString().split(' ').first.toString();

      String _lastNameStr =
          result.user!.displayName.toString().split(' ').last.toString();

      // var preferences = await SharedPreferences.getInstance();

      // preferences.setString('avatorImg', result.user!.photoURL.toString());

      if (result.user != null) {
        RegisterProvider().sendCreateUserThirdParty(
            context: context,
            email: result.user!.email!,
            firstname: _firstNameStr,
            lastname: _lastNameStr);
      } else {
        print('credential access denine');
      }
    } catch (err) {
      print('loginAppleError:: $err');
    }
  }

  Future<Null> sendChangePassword({
    @required context,
    @required oldPassword,
    @required currentPassword,
    @required password,
  }) async {
    var preferences = await SharedPreferences.getInstance();
    var cusId = preferences.getString('id');
    try {
      var body = {
        "customer_id": cusId,
        "action": "MyAccount",
        "page": "ChangePassword",
        "oldPassword": oldPassword,
        "password": password
      };
      RestAPI().getData(url: ApiPath.changePassword, body: body).then((value) {
        successModel = SuccessModel.fromJson(value);
        if (successModel!.status == 'OK' &&
            successModel!.result!.success == '1') {
          statusDialog(context, 'เปลี่ยนรหัสผ่านสำเร็จแล้ว');
        } else {
          normalDialog(context, 'รหัสผ่านเก่าไม่ตรงกัน');
        }
      });
    } catch (e) {
      normalDialog(context, '$e');
      print('sendChangePassword:: $e');
    }
  }

  Future<void> dialogSignInSusses(context, String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Image.asset(
                'assets/images/logo.jpg',
                width: 100.0,
                height: 100.0,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          actions: <Widget>[
            Consumer3<FragmentProvider, AddressSavePageProvider,
                RestaurantMainProvider>(
              builder: (context, pvd, pvdAddrs, pvdrest, child) => TextButton(
                child: Text(
                  'ตกลง',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  await pvd.initSigin(context);
                  pvdrest.getDataListMenuMain(
                      latitude: pvdAddrs.showAddress.latitude,
                      longitude: pvdAddrs.showAddress.longitude,
                      context: context,
                      flagPage: 'MainFlagment');
                  Navigator.popUntil(context, ModalRoute.withName('/fragment'));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
