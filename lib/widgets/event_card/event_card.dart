import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class EventCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String date;
  final Function onTap;

  const EventCard(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.date,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              onTap();
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: imageUrl,
                      placeholder: (context, url) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(
                            sigmaX: 3.0,
                            sigmaY: 3.0,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.3),
                            ),
                            child: Text(
                              date.split(' ')[0],
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(
                            sigmaX: 3.0,
                            sigmaY: 3.0,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.3),
                            ),
                            child: Text(
                              name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
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
          ),
        ),
      ),
    );
  }
}
