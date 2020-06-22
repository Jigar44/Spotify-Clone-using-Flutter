import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/components/spotify_home.dart';
import 'package:spotify_clone/logic/auth_logic.dart';
import 'package:spotify_clone/logic/basic_ui.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future onloadDecider() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) {
      print("No User");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Material(
                    child: ChangeNotifierProvider(
                      create: (BuildContext context) => SessionManagement(),
                      child: FirebaseSession(),
                    ),
                  )));
    } else {
      print("Current User : " + user.uid);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Material(
                    child: MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                            create: (BuildContext context) =>
                                SessionManagement()),
                      ],
                      child: SpotifyHome(),
                    ),
                  )));
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      onloadDecider();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset("./images/spotify_logo_title.png"),
      ),
    );
  }
}

class FirebaseSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromRGBO(48, 170, 3, 1),
              Color.fromRGBO(6, 20, 0, 1),
              Color.fromRGBO(0, 0, 0, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: AuthUI(),
        ));
  }
}

class AuthUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            './images/spotify_logo_banner_black.png',
            height: MediaQuery.of(context).size.height * 0.12,
          ),
          Text(
            "Millions of songs. \n Free on Spotify.",
            style: TextStyle(
              fontFamily: 'Proxima Nova',
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Continue with",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupOrLogin()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.mail_outline,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "EMAIL",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 10.0,
                ),
//                MaterialButton(
//                  onPressed: (){
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Material(
//                      child: ChangeNotifierProvider(
//                        create: (BuildContext context) =>Admin(),
//                        child: SpotifyAdmin(),
//                      ),
//                    )));
//                  },
//                  child: Container(
//                    padding: EdgeInsets.all(10.0),
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius: BorderRadius.circular(100.0),
//                    ),
//                    margin: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        Icon(Icons.person, color: Colors.black,),
//                        SizedBox(
//                          width: 5.0,
//                        ),
//                        Text("Admin", style: TextStyle(
//                          color: Colors.black,
//                          fontWeight: FontWeight.bold,
//                          fontSize: 16.0,
//                        ),),
//                      ],
//                    ),
//                  )
//                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignupOrLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromRGBO(48, 170, 3, 1),
          Color.fromRGBO(6, 20, 0, 1),
          Color.fromRGBO(0, 0, 0, 1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Email",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontFamily: 'Proxima Nova Bold',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Material(
                                child: MultiProvider(
                                  providers: [
                                    ChangeNotifierProvider(
                                      create: (BuildContext context) =>
                                          CreateUserAccount(),
                                    ),
                                    ChangeNotifierProvider(
                                      create: (BuildContext context) =>
                                          ShowCustomAlertDialog(),
                                    ),
                                  ],
                                  child: CreateAccount(),
                                ),
                              )));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 300.0,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Text(
                    "SIGN UP FREE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      height: 2.0,
                      width: MediaQuery.of(context).size.width * 0.35,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      height: 2.0,
                      width: MediaQuery.of(context).size.width * 0.35,
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Material(
                                child: MultiProvider(
                                  providers: [
                                    ChangeNotifierProvider(
                                        create: (BuildContext context) =>
                                            LoginLogic()),
                                    ChangeNotifierProvider(
                                      create: (BuildContext context) =>
                                          ShowCustomAlertDialog(),
                                    ),
                                  ],
                                  child: LoginPage(),
                                ),
                              )));
                },
                child: Container(
                  width: 300.0,
                  padding: EdgeInsets.all(12.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Text(
                    "LOG IN",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
//              Padding(
//                padding: EdgeInsets.all(10),
//                child: Align(
//                  alignment: Alignment.bottomCenter,
//                  child: Image.asset(
//                    './images/spotify_logo_banner_black.png',
//                    height: MediaQuery.of(context).size.height * 0.12,
//                  ),
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionObj = Provider.of<CreateUserAccount>(context);
    final uiComponents = Provider.of<ShowCustomAlertDialog>(context);
    return Scaffold(
      body: PageView(
        controller: sessionObj.pctrl,
        physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(48, 170, 3, 1),
                  Color.fromRGBO(6, 20, 0, 1),
                  Color.fromRGBO(0, 0, 0, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 5),
                  child: Align(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                ),
                Padding(
                  child: Text(
                    "Create account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontFamily: 'Proxima Nova Bold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                ),
                Text(
                  "What's your email?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontFamily: 'Proxima Nova Bold',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    showCursor: true,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16.0),
                      fillColor: Colors.transparent,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    onChanged: (String text) {
                      sessionObj.emailNextButtonListener(text);
                      sessionObj.email = text;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                MaterialButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    sessionObj.emailNextEnabled
                        ? sessionObj.pctrl.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn)
                        : uiComponents.showCustomDialog(
                            context, "Please Enter your Email");
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "NEXT",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(48, 170, 3, 1),
                  Color.fromRGBO(6, 20, 0, 1),
                  Color.fromRGBO(0, 0, 0, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 5),
                  child: Align(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                ),
                Padding(
                  child: Text(
                    "Create a Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontFamily: 'Proxima Nova Bold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: !sessionObj.showPassword,
                    autofocus: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16.0),
                        fillColor: Colors.transparent,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            sessionObj.showPassFun();
                          },
                          icon: sessionObj.showPassword
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Colors.white,
                                ),
                        )),
                    onChanged: (String text) {
                      sessionObj.passNextButtonListener(text);
                      sessionObj.password = text;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                MaterialButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    sessionObj.passNextEnabled
                        ? sessionObj.pctrl.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn)
                        : uiComponents.showCustomDialog(
                            context, "Password must of atleast 8 Charecters");
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "NEXT",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(48, 170, 3, 1),
                  Color.fromRGBO(6, 20, 0, 1),
                  Color.fromRGBO(0, 0, 0, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 25, left: 5),
                      child: Align(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    Text(
                      "What's your name?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontFamily: 'Proxima Nova Bold',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          fillColor: Colors.transparent,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onChanged: (String text) {
                          sessionObj.nameNextButtonListener(text);
                          sessionObj.name = text;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 5.0),
                      child: Text("This appears on your Spotify profile.",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 12)),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: sessionObj.isCreatingAccount
                          ? CircularProgressIndicator()
                          : MaterialButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          sessionObj.nameNextEnabled
                              ? sessionObj.signUp(context, sessionObj.name,
                              sessionObj.email, sessionObj.password)
                              : uiComponents.showCustomDialog(context,
                              "Name should be atleast 6 Charecters");
                        },
                        padding: EdgeInsets.fromLTRB(45.0, 15.0, 45.0, 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Container(
                          height: 50,
                          width: 150,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Center(
                            child: Text(
                              "CREATE",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "By creating an account, you agree to Spotify's Terms of Service.",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 12)
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              "To learn more about how Spotify collects, uses, shares and protects your personal data please read Spotify's Privacy Policy",
                              textAlign: TextAlign.center,
                              style: new TextStyle(color: Colors.green, fontWeight: FontWeight.w300, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginLogic = Provider.of<LoginLogic>(context);
    final uiComponents = Provider.of<ShowCustomAlertDialog>(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(48, 170, 3, 1),
            Color.fromRGBO(6, 20, 0, 1),
            Color.fromRGBO(0, 0, 0, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, left: 5),
                child: Align(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  alignment: Alignment.topLeft,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Email or userame",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontFamily: 'Proxima Nova Bold',
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    fillColor: Colors.transparent,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onChanged: (String text) {
                    loginLogic.email = text;
                    loginLogic.loginButtonListener(
                        loginLogic.email, loginLogic.password);
                  },
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontFamily: 'Proxima Nova Bold',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  cursorColor: Colors.white,
                  obscureText: !loginLogic.showPassword,
                  autofocus: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16.0),
                      fillColor: Colors.transparent,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          loginLogic.showPassFun();
                        },
                        icon: loginLogic.showPassword
                            ? Icon(
                                Icons.visibility,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: Colors.white,
                              ),
                      )),
                  onChanged: (String text) {
                    loginLogic.password = text;
                    loginLogic.loginButtonListener(
                        loginLogic.email, loginLogic.password);
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: loginLogic.isAuthenticating
                    ? CircularProgressIndicator()
                    : MaterialButton(
                  color: Colors.white,
                        padding: EdgeInsets.fromLTRB(45.0, 15.0, 45.0, 15.0),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          loginLogic.loginButton
                              ? loginLogic.loginIn(context, loginLogic.email,
                                  loginLogic.password)
                              : uiComponents.showCustomDialog(
                                  context, "Enter your Email and Password");
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Text(
                          "LOG IN",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: 'Proxima Nova Bold'),
                        ),
                      ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Material(
                                  child: ChangeNotifierProvider(
                                    create: (BuildContext context) =>
                                        SessionManagement(),
                                    child: PasswordRecovery(),
                                  ),
                                )));
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        "FORGOT YOUR PASSWORD?",
                        style: TextStyle(
                          fontFamily: 'Proxima Nova Bold',
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PasswordRecovery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final forgotObj = Provider.of<ForgotPassword>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(48, 170, 3, 1),
              Color.fromRGBO(6, 20, 0, 1),
              Color.fromRGBO(0, 0, 0, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 5),
                  child: Align(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Email or Username",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontFamily: 'Proxima Nova Bold',
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      contentPadding: EdgeInsets.all(16.0),
                      fillColor: Colors.grey,
                      filled: true,
                      border: OutlineInputBorder(),
                      disabledBorder: InputBorder.none,
                    ),
                    onChanged: (String text) {
                      forgotObj.buttonActivateListener(text);
                    },
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text("We'll send a link to your email that will log you in."),
                SizedBox(
                  height: 25.0,
                ),
                Center(
                  child: MaterialButton(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(35.0, 20.0, 35.0, 20.0),
                    onPressed: () async {
                      forgotObj.getLinkEnable
                          ? (await forgotObj.sendEmail(context, forgotObj.email))
                          ? forgotObj.showCustomAlertDialog.showCustomDialog(
                          context,
                          "An Email was sent to you to reset your Password, Check your inbox.")
                          : print("Something went wrong")
                          : forgotObj.showCustomAlertDialog.showCustomDialog(
                          context, "Please enter valid Email");
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Text(
                      "GET LINK",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'Proxima Nova Bold',
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
