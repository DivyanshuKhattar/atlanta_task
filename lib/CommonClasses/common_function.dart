import 'dart:io';

class CommonFunction{

  /// checking network before calling api
  Future<bool> checkNetwork() async{
    final result = await InternetAddress.lookup('www.google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  }
}