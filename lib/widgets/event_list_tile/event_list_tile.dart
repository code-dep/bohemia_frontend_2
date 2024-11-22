import 'package:flutter/material.dart';

class EventListTile extends StatelessWidget {
  final String name;
  final String? userCount;
  final String eventName;
  final VoidCallback onTap;
  final bool showIcon;
  final bool isVerified;

  const EventListTile({
    super.key,
    required this.name,
    required this.userCount,
    required this.eventName,
    required this.onTap,
    this.showIcon = true,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 70,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (eventName.isNotEmpty)
                              Text(
                                eventName,
                                style: TextStyle(fontSize: 12),
                              ),
                          ],
                        ),
                        if (showIcon)
                          IconButton(
                            onPressed: onTap,
                            icon: Icon(isVerified
                                ? Icons.check_circle
                                : Icons.local_activity_outlined),
                          ),
                        if (userCount != null)
                          Text(
                            userCount!,
                            style: TextStyle(fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
