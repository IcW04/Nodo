import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      // Footer is a dark navy section (#1D3557)
      decoration: const BoxDecoration(gradient: AppColors.darkSectionGradient),
      child: Column(
        children: [
          // ── Final CTA banner ──────────────────────────────────────────
          Container(
            margin: EdgeInsets.fromLTRB(
              padding.horizontal / 2,
              56,
              padding.horizontal / 2,
              0,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 56),
            decoration: BoxDecoration(
              // Accent blue banner inside the navy footer
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.3),
                  blurRadius: 48,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Empieza a usar NODO hoy',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 26 : 34,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Descarga la app y resuelve tu próximo servicio técnico\nde forma rápida, confiable y transparente.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: Colors.white.withValues(alpha: 0.80),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 36),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _FooterCtaBtn(label: '📱  App Store', isPrimary: true),
                    _FooterCtaBtn(label: '🤖  Google Play', isPrimary: false),
                  ],
                ),
              ],
            ),
          ),

          // ── Logo + links + socials ────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding.horizontal / 2,
              vertical: 48,
            ),
            child: isMobile
                ? Column(
                    children: [
                      _FooterLogo(),
                      const SizedBox(height: 8),
                      Text(
                        'Servicios técnicos confiables en República Dominicana.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.textOnDarkMuted,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _FooterLinks(),
                      const SizedBox(height: 24),
                      _SocialIcons(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _FooterLogo(),
                            const SizedBox(height: 12),
                            Text(
                              'Servicios técnicos confiables\nen República Dominicana.',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: AppColors.textOnDarkMuted,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 80),
                      Expanded(flex: 4, child: _FooterLinks()),
                      const SizedBox(width: 48),
                      _SocialIcons(),
                    ],
                  ),
          ),

          // ── Bottom bar ────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
            child: Text(
              '© 2025 NODO. Todos los derechos reservados. República Dominicana.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textOnDarkMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────────

class _FooterLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
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
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'NODO',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textOnDark,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}

class _FooterLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 10,
      children: [
        _FooterLink('Cómo funciona'),
        _FooterLink('Características'),
        _FooterLink('Para técnicos'),
        _FooterLink('Términos y condiciones'),
        _FooterLink('Privacidad'),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  const _FooterLink(this.label);

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: _hovered ? AppColors.accent : AppColors.textOnDarkMuted,
        ),
        child: Text(widget.label),
      ),
    );
  }
}

class _SocialIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialIcon(Icons.camera_alt_rounded, 'Instagram'),
        const SizedBox(width: 10),
        _SocialIcon(Icons.facebook_rounded, 'Facebook'),
        const SizedBox(width: 10),
        _SocialIcon(Icons.chat_rounded, 'WhatsApp'),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  const _SocialIcon(this.icon, this.label);

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.label,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.accent
                : Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent
                  : Colors.white.withValues(alpha: 0.15),
            ),
          ),
          child: Icon(widget.icon, color: AppColors.textOnDark, size: 17),
        ),
      ),
    );
  }
}

class _FooterCtaBtn extends StatefulWidget {
  final String label;
  final bool isPrimary;
  const _FooterCtaBtn({required this.label, required this.isPrimary});

  @override
  State<_FooterCtaBtn> createState() => _FooterCtaBtnState();
}

class _FooterCtaBtnState extends State<_FooterCtaBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: widget.isPrimary
              ? (_hovered ? Colors.grey[100] : Colors.white)
              : Colors.white.withValues(alpha: _hovered ? 0.15 : 0.08),
          borderRadius: BorderRadius.circular(12),
          border: widget.isPrimary
              ? null
              : Border.all(color: Colors.white.withValues(alpha: 0.35)),
          boxShadow: _hovered && widget.isPrimary
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: widget.isPrimary ? AppColors.accent : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
