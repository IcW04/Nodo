import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  static const List<_Testimonial> _testimonials = [
    _Testimonial(
      initials: 'MC',
      name: 'María Contreras',
      location: 'Santo Domingo Este',
      role: 'Cliente',
      quote:
          'Tenía una fuga de agua desde hacía semanas y nadie confiable a quien llamar. Con NODO encontré un plomero en menos de 10 minutos, llegó puntual y el precio fue exactamente el acordado. ¡Increíble!',
      rating: 5,
      color: Color(0xFF1565C0),
    ),
    _Testimonial(
      initials: 'JR',
      name: 'José Ramírez',
      location: 'Santiago',
      role: 'Electricista',
      quote:
          'Antes dependía solo del boca a boca. Desde que entré a NODO tengo trabajos casi todos los días. Mi calificación de 4.9 me ha abierto puertas que antes no imaginaba. Valió la pena.',
      rating: 5,
      color: Color(0xFFFF6D00),
    ),
    _Testimonial(
      initials: 'SA',
      name: 'Sandra Almonte',
      location: 'Los Alcarrizos',
      role: 'Cliente',
      quote:
          'Lo que más me gusta es poder ver las fotos antes y después del trabajo. Ya no tengo que fiarme de nada: el técnico llegó, hizo el trabajo, tomó evidencia y yo pagué segura.',
      rating: 5,
      color: Color(0xFF6A1B9A),
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
          Text(
            'TESTIMONIOS',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Lo que dicen quienes\nya usan NODO',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 56),
          isMobile
              ? Column(
                  children: _testimonials
                      .map(
                        (t) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _TestimonialCard(testimonial: t),
                        ),
                      )
                      .toList(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _testimonials
                      .map(
                        (t) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: t == _testimonials[1] ? 10 : 0,
                            ),
                            child: _TestimonialCard(testimonial: t),
                          ),
                        ),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _Testimonial {
  final String initials;
  final String name;
  final String location;
  final String role;
  final String quote;
  final int rating;
  final Color color;

  const _Testimonial({
    required this.initials,
    required this.name,
    required this.location,
    required this.role,
    required this.quote,
    required this.rating,
    required this.color,
  });
}

class _TestimonialCard extends StatefulWidget {
  final _Testimonial testimonial;
  const _TestimonialCard({super.key, required this.testimonial});

  @override
  State<_TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<_TestimonialCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final t = widget.testimonial;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: _hovered
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.cardBg, t.color.withValues(alpha: 0.12)],
                )
              : AppColors.cardGradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? t.color.withValues(alpha: 0.4) : AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? t.color.withValues(alpha: 0.10)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: _hovered ? 24 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stars
            Row(
              children: List.generate(
                t.rating,
                (_) => const Padding(
                  padding: EdgeInsets.only(right: 2),
                  child: Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFBBF24),
                    size: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Quote
            Text(
              '"${t.quote}"',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.65,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            // Author
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: t.color,
                  child: Text(
                    t.initials,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.name,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '${t.role} · ${t.location}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
