import 'package:flutter/material.dart';
import 'sections/nav_bar_section.dart';
import 'sections/hero_section.dart';
import 'sections/problems_section.dart';
import 'sections/how_it_works_section.dart';
import 'sections/features_section.dart';
import 'sections/for_technicians_section.dart';
import 'sections/footer_section.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();

  // Keys for each major section to allow navbar scroll-to
  final List<GlobalKey> _sectionKeys = List.generate(4, (_) => GlobalKey());

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero section — key[0]
                Container(key: _sectionKeys[0], child: const HeroSection()),

                // How it works — key[1]
                Container(
                  key: _sectionKeys[1],
                  child: const HowItWorksSection(),
                ),

                // Problems section
                const ProblemsSection(),

                // Features — key[2]
                Container(key: _sectionKeys[2], child: const FeaturesSection()),

                // For technicians — key[3]
                Container(
                  key: _sectionKeys[3],
                  child: const ForTechniciansSection(),
                ),

                // Footer
                const FooterSection(),
              ],
            ),
          ),

          // Sticky navbar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBarSection(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
            ),
          ),
        ],
      ),
    );
  }
}
