import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _floatController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<double>(
      begin: 40,
      end: 0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 700),
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: Stack(
        children: [
          // Background grid pattern
          _GridPattern(),
          // Subtle glow orbs (light mode — very low opacity)
          Positioned(
            top: -120,
            left: -120,
            child: _GlowOrb(
              color: AppColors.accent.withValues(alpha: 0.06),
              size: 500,
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: _GlowOrb(
              color: AppColors.primary.withValues(alpha: 0.05),
              size: 400,
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.only(
              left: isMobile ? 24 : 80,
              right: isMobile ? 24 : 80,
              top: isMobile ? 100 : 120,
              bottom: 80,
            ),
            child: isMobile || isTablet
                ? _MobileHeroContent(
                    fadeAnimation: _fadeAnimation,
                    slideAnimation: _slideAnimation,
                    floatAnimation: _floatAnimation,
                  )
                : _DesktopHeroContent(
                    fadeAnimation: _fadeAnimation,
                    slideAnimation: _slideAnimation,
                    floatAnimation: _floatAnimation,
                  ),
          ),
        ],
      ),
    );
  }
}

class _GridPattern extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(child: CustomPaint(painter: _GridPainter()));
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1D3557).withValues(alpha: 0.06)
      ..strokeWidth = 1;

    const step = 60.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color, blurRadius: size * 0.6)],
        color: color,
      ),
    );
  }
}

class _DesktopHeroContent extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<double> slideAnimation;
  final Animation<double> floatAnimation;

  const _DesktopHeroContent({
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.floatAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _HeroText(
            fadeAnimation: fadeAnimation,
            slideAnimation: slideAnimation,
          ),
        ),
        const SizedBox(width: 80),
        Expanded(flex: 4, child: _PhoneMockup(floatAnimation: floatAnimation)),
      ],
    );
  }
}

class _MobileHeroContent extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<double> slideAnimation;
  final Animation<double> floatAnimation;

  const _MobileHeroContent({
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.floatAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeroText(fadeAnimation: fadeAnimation, slideAnimation: slideAnimation),
        const SizedBox(height: 48),
        _PhoneMockup(floatAnimation: floatAnimation),
      ],
    );
  }
}

class _HeroText extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<double> slideAnimation;

  const _HeroText({required this.fadeAnimation, required this.slideAnimation});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return AnimatedBuilder(
      animation: fadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, slideAnimation.value),
          child: Opacity(opacity: fadeAnimation.value, child: child),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pill badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.4),
                width: 1,
              ),
              color: AppColors.accent.withValues(alpha: 0.1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Plataforma disponible en República Dominicana',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Headline
          Text(
            'Servicios\ntécnicos\nconfiables.',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 42 : 58,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              height: 1.05,
              letterSpacing: -2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Cuando los necesitas.',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 42 : 58,
              fontWeight: FontWeight.w800,
              color: AppColors.accent,
              height: 1.05,
              letterSpacing: -2,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Conectamos hogares y negocios con técnicos verificados —\neléctristas, plomeros, técnicos de A/C y más — de forma\nrápida, transparente y sin complicaciones.',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 15 : 17,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.65,
            ),
          ),
          const SizedBox(height: 40),
          // CTA Buttons
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _HeroCta(label: '📱  App Store', isPrimary: true),
              _HeroCta(label: '🤖  Google Play', isPrimary: false),
            ],
          ),
          const SizedBox(height: 40),
          // Trust indicators
          Wrap(
            spacing: 24,
            runSpacing: 12,
            children: [
              _TrustPill(
                icon: Icons.verified_rounded,
                text: 'Técnicos verificados',
              ),
              _TrustPill(
                icon: Icons.star_rounded,
                text: 'Calificaciones reales',
              ),
              _TrustPill(icon: Icons.bolt_rounded, text: 'Respuesta rápida'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroCta extends StatefulWidget {
  final String label;
  final bool isPrimary;
  const _HeroCta({required this.label, required this.isPrimary});

  @override
  State<_HeroCta> createState() => _HeroCtaState();
}

class _HeroCtaState extends State<_HeroCta> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _hovered
            ? (Matrix4.identity()..scale(1.04))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          gradient: widget.isPrimary ? AppColors.accentGradient : null,
          color: widget.isPrimary ? null : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
          border: widget.isPrimary
              ? null
              : Border.all(color: AppColors.borderLight),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.isPrimary
                        ? AppColors.accent.withValues(alpha: 0.35)
                        : Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _TrustPill extends StatelessWidget {
  final IconData icon;
  final String text;
  const _TrustPill({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.accent),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _PhoneMockup extends StatelessWidget {
  final Animation<double> floatAnimation;
  const _PhoneMockup({required this.floatAnimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, floatAnimation.value),
          child: child,
        );
      },
      child: Center(
        child: Container(
          width: 280,
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: AppColors.surface,
            border: Border.all(color: AppColors.borderLight, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.15),
                blurRadius: 40,
                offset: const Offset(0, 16),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(38),
            child: Column(
              children: [
                // Phone status bar
                Container(
                  height: 40,
                  color: AppColors.surface,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
                // App content preview
                Expanded(
                  child: Container(
                    color: AppColors.background,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // NODO mini header
                        Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                gradient: AppColors.accentGradient,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  'N',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'NODO',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '¿Qué servicio\nnecesitas?',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Service chips
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _ServiceChip('⚡ Eléctrico', true),
                            _ServiceChip('🔧 Plomería', false),
                            _ServiceChip('❄️ A/C', false),
                            _ServiceChip('🔨 Mantenimiento', false),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Technician card
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: AppColors.cardGradient,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: AppColors.primary,
                                    child: Text(
                                      'JR',
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'José Ramírez',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        Text(
                                          'Electricista · 2 km',
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.success.withValues(
                                        alpha: 0.15,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Disponible',
                                      style: GoogleFonts.inter(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.success,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 13,
                                    color: Color(0xFFFBBF24),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '4.9',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    ' (148 trabajos)',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        // CTA button
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            gradient: AppColors.accentGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Solicitar servicio',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
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

class _ServiceChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _ServiceChip(this.label, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: selected ? AppColors.accentGradient : null,
        color: selected ? null : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(8),
        border: selected ? null : Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: selected ? Colors.white : AppColors.textSecondary,
        ),
      ),
    );
  }
}
