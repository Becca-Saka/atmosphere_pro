import 'dart:io';

import 'package:atsign_atmosphere_pro/services/snackbar_service.dart';
import 'package:atsign_atmosphere_pro/utils/colors.dart';
import 'package:atsign_atmosphere_pro/utils/text_strings.dart';
import 'package:atsign_atmosphere_pro/utils/text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../services/navigation_service.dart';
import '../../view_models/internet_connectivity_checker.dart';

class WebsiteScreen extends StatefulWidget {
  final String? title;
  final String? url;

  const WebsiteScreen({Key? key, this.title, this.url}) : super(key: key);
  @override
  _WebsiteScreenState createState() => _WebsiteScreenState();
}

class _WebsiteScreenState extends State<WebsiteScreen> {
  late bool loading;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    loading = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkForNetwork();
    });
  }

  checkForNetwork() {
    var isConnected = Provider.of<InternetConnectivityChecker>(
            NavService.navKey.currentContext!,
            listen: false)
        .isInternetAvailable;

    if (!isConnected) {
      SnackbarService().showSnackbar(
        NavService.navKey.currentContext!,
        TextStrings.noInternetMsg,
        bgColor: ColorConstants.redAlert,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstants.appBarColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: ColorConstants.fontPrimary,
            size: 22,
          ),
        ),
        title: Text(
          widget.title!,
          style: CustomTextStyles.primaryBold18,
        ),
      ),
      body: Stack(children: [
        WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          gestureRecognizers: {
            Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer()..onUpdate = (_) {},
            )
          },
          onPageFinished: (test1) {
            this.setState(() {
              loading = false;
            });
          },
        ),
        loading
            ? Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                  ColorConstants.blueText,
                )),
              )
            : SizedBox()
      ]),
    );
  }
}
