import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AuthenticationResponseHandler{
  late String errorcode;
  final BuildContext context;

  //Constructor
  AuthenticationResponseHandler.empty({required this.context});

  AuthenticationResponseHandler({required this.context, required this.errorcode,}){
    handleResponse(errorcode);
  }

  //Methods
  void handleResponse(String errorcode){
    this.errorcode = errorcode;
    print("Handling FirebaseAuth error with code: $errorcode");
    switch (errorcode) {
      case "no-email":
        showTopSnackBar(
          context,
          CustomSnackBar.info(
            message: "Zum anmelden wird eine E-Mail Adresse benötigt!",
          ),
        );
        break;
      case "no-password":
        showTopSnackBar(
          context,
          CustomSnackBar.info(
            message: "Zum anmelden wird ein Passwort benötigt!",
          ),
        );
        break;
      case "wrong-password":
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Das eingegebene Passwort ist nicht korrekt. Bitte versuchen Sie es erneut!",
          ),
        );
        break;
      case "user-not-found":
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Es gibt keinen Benutzer zu dieser E-Mail. Bitte veruche eine andere E-Mail Adresse!",
          ),
        );
        break;
      case "too-many-requests":
        showTopSnackBar(
          context,
          CustomSnackBar.info(
            message:"Sie haben es zu oft hintereinander probiert! Warten Sie einen Augenblick!",
          ),
        );
        break;
      default:
        showTopSnackBar(
          context,
          CustomSnackBar.info(
            message: "Es gab einen unbekannten Fehler, bitte versuchen Sie erneut oder wenden Sie sich an einen Admin!",
          ),
        );
        break;
    }
  }
}

