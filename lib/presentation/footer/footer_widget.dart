import 'package:flutter/material.dart';
import 'package:flutter_google_sheet_test/util/util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: const BoxDecoration(
        color: Color(0xff333333),
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: 800,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: MediaQuery.of(context).size.width < 650
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            launchURL('https://www.facebook.com/instapay.kr');
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.white54,
                            size: 17,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            launchURL(
                                'https://www.instagram.com/instabooks.official/');
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.instagram,
                            color: Colors.white54,
                            size: 17,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            launchURL(
                                'https://blog.naver.com/instapay_official');
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.penToSquare,
                            color: Colors.white54,
                            size: 17,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Copyright © 2022 InstaPay - All Rights Reserved.',
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Copyright © 2022 InstaPay - All Rights Reserved.',
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            launchURL('https://www.facebook.com/instapay.kr');
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.white54,
                            size: 17,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            launchURL(
                                'https://www.instagram.com/instabooks.official/');
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.instagram,
                            color: Colors.white54,
                            size: 17,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            launchURL(
                                'https://blog.naver.com/instapay_official');
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.penToSquare,
                            color: Colors.white54,
                            size: 17,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
