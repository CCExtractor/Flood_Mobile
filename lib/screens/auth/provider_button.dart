import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class ProviderButton extends StatefulWidget {
  final BuildContext context;
  final String signInType;

  const ProviderButton({Key key, this.context, this.signInType})
      : super(key: key);

  @override
  _ProviderButtonState createState() => _ProviderButtonState();
}

class _ProviderButtonState extends State<ProviderButton> {
  @override
  Widget build(BuildContext context) {
    switch (widget.signInType) {
      case "google":
        return InkWell(
          onTap: () => context.signInWithGoogle(),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black26,
              ),
            ),
            child: LitAuthIcon.google(
              size: const Size(30, 30),
            ),
          ),
        );

        break;
      case "apple":
        return InkWell(
          onTap: () => context.signInWithApple(),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black26,
              ),
            ),
            child: Transform.translate(
              offset: const Offset(-1, 0),
              child: LitAuthIcon.appleBlack(
                size: const Size(30, 30),
              ),
            ),
          ),
        );
        break;
      case "twitter":
        return InkWell(
          onTap: () => context.signInWithTwitter(),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black26,
              ),
            ),
            child: Transform.scale(
              scale: 1.2,
              child: LitAuthIcon.twitter(
                size: const Size(30, 30),
              ),
            ),
          ),
        );
        break;
      default:
        return const Text("error");
    }
  }
}
