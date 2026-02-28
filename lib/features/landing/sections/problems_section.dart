import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';

class ProblemsSection extends StatelessWidget {
  const ProblemsSection({super.key});

  static const List<_Problem> _problems = [
    _Problem(
      emoji: '😰',
      title: 'No encuentras técnicos confiables',
      desc:
          'Buscar por WhatsApp o grupos da resultados inciertos y sin garantía de calidad.',
    ),
    _Problem(
      emoji: '💸',
      title: 'Precios que cambian de la nada',
      desc:
          'El presupuesto acordado rara vez es el precio final. Sin transparencia ni facturas.',
    ),
    _Problem(
      emoji: '😤',
      title: 'Miedo a ser estafado',
      desc:
          'Sin historial ni fotos del trabajo, no sabes qué servicio estás realmente pagando.',
    ),
    _Problem(
      emoji: '⏰',
      title: 'Pierdes horas buscando',
      desc:
          'Llamadas sin respuesta, técnicos que cancelan, desplazamientos en vano.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: padding.horizontal / 2,
        vertical: 80,
      ),
      child: Column(
        children: [
          // Section label
          Text(
            '¿TE SUENA FAMILIAR?',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'La frustración de conseguir\nun buen técnico',
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
            'En República Dominicana, encontrar servicios técnicos confiables es\nun reto diario para miles de familias.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 56),
          // Problem cards grid
          isMobile
              ? Column(
                  children: _problems
                      .map(
                        (p) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _ProblemCard(problem: p),
                        ),
                      )
                      .toList(),
                )
              : GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.4,
                  children: _problems
                      .map((p) => _ProblemCard(problem: p))
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _Problem {
  final String emoji;
  final String title;
  final String desc;
  const _Problem({
    required this.emoji,
    required this.title,
    required this.desc,
  });
}

class _ProblemCard extends StatefulWidget {
  final _Problem problem;
  const _ProblemCard({super.key, required this.problem});

  @override
  State<_ProblemCard> createState() => _ProblemCardState();
}

class _ProblemCardState extends State<_ProblemCard> {
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
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.4)
                : AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? AppColors.accent.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: _hovered ? 20 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.problem.emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.problem.title,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.problem.desc,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
