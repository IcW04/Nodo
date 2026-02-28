import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  static const List<_Feature> _features = [
    _Feature(
      icon: Icons.verified_user_rounded,
      title: 'Técnicos verificados',
      desc:
          'Cada técnico tiene perfil completo con calificaciones, comentarios reales y fotos de trabajos anteriores.',
      gradientColors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
    ),
    _Feature(
      icon: Icons.price_check_rounded,
      title: 'Precios transparentes',
      desc:
          'Conoce el costo estimado antes de aceptar. Sin sorpresas ni cambios de último minuto.',
      gradientColors: [Color(0xFF6A1B9A), Color(0xFF9C27B0)],
    ),
    _Feature(
      icon: Icons.photo_camera_rounded,
      title: 'Evidencia visual',
      desc:
          'El técnico toma fotos antes, durante y después del trabajo. Sabes exactamente qué se hizo.',
      gradientColors: [Color(0xFF00695C), Color(0xFF00897B)],
    ),
    _Feature(
      icon: Icons.local_offer_rounded,
      title: 'Código NODO en ferreterías',
      desc:
          'Accede a precios preferenciales y facturación en ferreterías aliadas. Ahorra en materiales.',
      gradientColors: [Color(0xFFE65100), Color(0xFFFF6D00)],
    ),
    _Feature(
      icon: Icons.history_rounded,
      title: 'Historial completo',
      desc:
          'Todos tus servicios, facturas y garantías guardados en un solo lugar. Siempre a la mano.',
      gradientColors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
    ),
    _Feature(
      icon: Icons.support_agent_rounded,
      title: 'Mediación de conflictos',
      desc:
          'Si algo sale mal, NODO te respalda. Canal de soporte y mediación para resolver reclamos.',
      gradientColors: [Color(0xFF880E4F), Color(0xFFAD1457)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final padding = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: padding.horizontal / 2,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            'POR QUÉ NODO',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Todo lo que necesitas,\nen una sola plataforma',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Diseñado para los hogares dominicanos que merecen\nservicios técnicos con estándares modernos.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 56),
          // Use LayoutBuilder + Wrap so cards size to their content (no fixed aspect ratio)
          LayoutBuilder(
            builder: (context, constraints) {
              final totalWidth = constraints.maxWidth;
              final columns = isMobile ? 1 : (isTablet ? 2 : 3);
              const spacing = 20.0;
              final cardWidth =
                  (totalWidth - spacing * (columns - 1)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: _features
                    .map(
                      (f) => SizedBox(
                        width: cardWidth,
                        child: _FeatureCard(feature: f),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Feature {
  final IconData icon;
  final String title;
  final String desc;
  final List<Color> gradientColors;

  const _Feature({
    required this.icon,
    required this.title,
    required this.desc,
    required this.gradientColors,
  });
}

class _FeatureCard extends StatefulWidget {
  final _Feature feature;
  const _FeatureCard({super.key, required this.feature});

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: _hovered
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.cardBg,
                    widget.feature.gradientColors[0].withValues(alpha: 0.08),
                  ],
                )
              : AppColors.cardGradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? widget.feature.gradientColors[0].withValues(alpha: 0.4)
                : AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? widget.feature.gradientColors[0].withValues(alpha: 0.12)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: _hovered ? 24 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with gradient background
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.feature.gradientColors,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: widget.feature.gradientColors[0].withValues(
                      alpha: 0.3,
                    ),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(widget.feature.icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 16),
            Text(
              widget.feature.title,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.feature.desc,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
