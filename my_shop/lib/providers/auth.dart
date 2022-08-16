import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if(_expiryDate != null && _expiryDate!.isAfter(DateTime.now()) && _token != null){
      return _token!;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> _authentication(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBpjfVEGVcYowWPhhe0fsNmNMkj4q2ax6o');
    try{
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      print('_token = ${responseData['idToken']}');
      _userId = responseData['localId'];
      print('_userId = ${responseData['localId']}');
      _expiryDate = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
      print('_expiryDate = ${DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])))}');
      _autoLogout();
      notifyListeners();
    } catch (error) {
      print('inside catch $error');
      throw error;
    }

  }

  Future<void> signup(String email, String password) async {
    return _authentication(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return _authentication(email, password, 'signInWithPassword');
  }

  void logout() {
    _userId = null;
    _token = null;
    _expiryDate = null;
    if(_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void _autoLogout() {
    if(_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}