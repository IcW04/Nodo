import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.background, AppColors.surface],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: padding.horizontal / 2,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            'SIMPLE Y RÁPIDO',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Cómo funciona NODO',
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
            'Resuelve cualquier problema técnico en 3 pasos.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 64),
          isMobile
              ? Column(
                  children: [
                    _Step(
                      number: '01',
                      icon: Icons.search_rounded,
                      title: 'Solicita el servicio',
                      desc:
                          'Describe tu problema y confirma tu ubicación. En segundos encontramos el técnico ideal.',
                      isLast: false,
                    ),
                    _StepConnectorVertical(),
                    _Step(
                      number: '02',
                      icon: Icons.handshake_rounded,
                      title: 'Te conectamos',
                      desc:
                          'Recibes el perfil del técnico con calificaciones, fotos de trabajos anteriores y precio estimado.',
                      isLast: false,
                    ),
                    _StepConnectorVertical(),
                    _Step(
                      number: '03',
                      icon: Icons.check_circle_rounded,
                      title: '¡Problema resuelto!',
                      desc:
                          'El técnico llega, realiza el trabajo y toma fotos como evidencia. Tú calificas y pagas.',
                      isLast: true,
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _Step(
                        number: '01',
                        icon: Icons.search_rounded,
                        title: 'Solicita el servicio',
                        desc:
                            'Describe tu problema y confirma tu ubicación. En segundos encontramos el técnico ideal.',
                        isLast: false,
                      ),
                    ),
                    _StepConnectorHorizontal(),
                    Expanded(
                      child: _Step(
                        number: '02',
                        icon: Icons.handshake_rounded,
                        title: 'Te conectamos',
                        desc:
                            'Recibes el perfil del técnico con calificaciones, fotos de trabajos anteriores y precio estimado.',
                        isLast: false,
                      ),
                    ),
                    _StepConnectorHorizontal(),
                    Expanded(
                      child: _Step(
                        number: '03',
                        icon: Icons.check_circle_rounded,
                        title: '¡Problema resuelto!',
                        desc:
                            'El técnico llega, realiza el trabajo y toma fotos como evidencia. Tú calificas y pagas.',
                        isLast: true,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final String number;
  final IconData icon;
  final String title;
  final String desc;
  final bool isLast;

  const _Step({
    required this.number,
    required this.icon,
    required this.title,
    required this.desc,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Numbered icon circle
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 36),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.background, width: 2),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _StepConnectorHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 56),
      child: SizedBox(
        width: 60,
        child: Row(
          children: List.generate(
            6,
            (i) => Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: i % 2 == 0
                      ? AppColors.borderLight
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StepConnectorVertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Column(
        children: List.generate(
          6,
          (i) => Expanded(
            child: Container(
              width: 2,
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: i % 2 == 0 ? AppColors.borderLight : Colors.transparent,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
