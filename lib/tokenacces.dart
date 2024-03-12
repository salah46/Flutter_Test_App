import 'package:googleapis_auth/auth_io.dart';

class AccessTokenFireBase {
  String firebasemessaging =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getToken() async {
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "flutteressay",
          "private_key_id": "1ef894ee0441f4ee00655b1a0dc96f660e30e1d2",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZ19pDjY10x8rd\nHbzEJ6z99pNbPe1znmt5WGDaW7yO1T/F8686dzYHRS51owyFNYuzbjsVfIuxCx3N\nklF8x5sKh9cZHXMxj2fc228pfvrb/KINYyT9/Q+rUkiUoz3IXjuillYkfG5IL5w4\n+x9ZJbl7kGOnMwjTOSxeqS6R2i8s5Om5l0gXVlCPboS+tJs3h/kpZftYEmIs73nL\n89Y6wqM9Z1Nn4S/CwzdlJZTY31bxP78noMC3sZ+v0a+pRP59CF+onra8vdu9cPlI\ns9FgSRMpOdXTZq9Tqs/9K6yEkG9Y5qAJTvUt75+I+a7xKTaLe+jdWsl+N2r9IkPH\nTMn4rzlvAgMBAAECggEATpT/5ih047CCrHrisjvBuqctBtfzBScbi91mqr426ath\nYu4Bwuxn7/1zwfm8NX1YVLSp2Zlg5s+kw5hJjuKOOiFAZY3rFPCvPctmcSieI6ch\nagTevkSAV4PKLNwqGFJt3ruufWDpg16xUxi7eTQTkdBHMnRFdbSFHeyXoQN8ywtq\nEMtfkNg2S3n63qGxTHvtj4Zjs1ZmLn2ULmoXjGCPU38EjxkRXVJgdJB5Jq25fpXg\nofES+Nly5BGvbJ13Sj0PoRyGeT2APzIvsSf9itVhul1MP98iO22971I+t/mN+XPK\nhkAYPV8+8zZ0l1gcDsW67Cqihgic/ekvs344dVCAeQKBgQD0CjQMab/N+IAsqwSo\n7v27ax85Bq+LuTDF/p67y0srjzUWk5C/A2DFbhBjXP291MMqrMycaRlIdVxX4bXd\ne4nrZAyHVPL8U+8U+VqXQ6lSDxzOHT4CQtUshTgzELS5kjmE3w5zBMSTE/W2/ubE\nBsrrJy+SbsUno2olkgA3h6VBywKBgQDkhPpXzDa36ccsT81Fabdtux1vO5C2ipMF\n7TWBdD2toM7tcXw3MzBase6Mh45NYhmXzl/2VFRnlbdIs+rImp43TPu0OKfY+7NC\nxn0dy/vjoGCjNYVxpJSx+m8uMOxlxiMmQM0lRIQcXAH9MIcK3ijxefHWYsKtJAHX\n91wv/hfibQKBgQCTjSvFKZc/6PVOjKSHo+CkFfPN3f375B/aRsYg050CnFbD7LsC\n0v8KwC6GdW4x/dd3EP2xwFX6GoOX2y/D13MfcOGmXbWA3RrcOpwMg2t34w1Ojh20\n7kXH4lCFh59N6FyAuwEYiBR2vQW+/EX41gaQwaOgzPrFqad/SdR5vrkrmwKBgHJK\nE46fouo+cI+35bkGk2e9Ao6kIs845Sk8ptr00PgqifN1I6PT5SYnAWClV0Vaf+RN\noe7n5ELePQmOeikUM3cC+Iv9He1GjTQjY2XopDUG++4EkZXxszCESOC4NTL9cozq\nMe+modAxMAl6IMANtjp3O712LVk8vfNOUnvqP/XNAoGAV0qhZcDwbJw5wPWB23tW\nH+BeZYbOS4HB26lb7isFby8IrtOSHkG8vpj8iFLpSI12H2E6pHYyq96gBD1ZqYzP\nD1m+pDtRbRpWjVO6cHd+q+aaDqMUw3OGUmMyAJjfpV3T1wy2YHm+WUKwZuQcw5oN\nVO3N2xYqWpFneY3UzLdD4AM=\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-4so22@flutteressay.iam.gserviceaccount.com",
          "client_id": "104893150974351065864",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-4so22%40flutteressay.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        [firebasemessaging]);
    final accesstoken = client.credentials.accessToken.data;
    return accesstoken;
  }
}
