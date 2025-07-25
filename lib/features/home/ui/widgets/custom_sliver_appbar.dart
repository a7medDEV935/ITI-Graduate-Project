import 'package:flutter/material.dart';

SliverAppBar customAnimationAppbar({
  required BuildContext context,
  required String image,
  required String title,
  required String descripton,
  required bool isActions,
  List<Widget> actions = const [],
}) {
  return SliverAppBar(
    pinned: true,
    backgroundColor: Colors.grey.shade900,
    elevation: 0,
    expandedHeight: MediaQuery.of(context).size.height / 4.7,
    actions: isActions ? actions : null, // Use actions if isActions is true
    flexibleSpace: LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxHeight < 140;
        return FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(left: isCompact ? 56 : 16, bottom: 16),
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 0),
            child: isCompact
                ? AnimatedRowScreen(image: image, name: title)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: image.isEmpty
                            ? CircleAvatar(
                                radius: 55,
                                child: Icon(Icons.person),
                              )
                            : CircleAvatar(
                                radius: 55,
                                backgroundImage: NetworkImage(image),
                              ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        descripton,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
          ),
          centerTitle: true,
        );
      },
    ),
  );
}

class AnimatedRowScreen extends StatefulWidget {
  const AnimatedRowScreen({super.key, required this.name, required this.image});
  final String name;
  final String image;

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedRowScreenState createState() => _AnimatedRowScreenState();
}

class _AnimatedRowScreenState extends State<AnimatedRowScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // from bottom
      end: Offset.zero, // to normal position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 15),
            SizedBox(
              height: 30,
              width: 30,
              child: widget.image.isEmpty
                  ? CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.person),
                    )
                  : CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(widget.image),
                    ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
