import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';

class ForTechniciansSection extends StatelessWidget {
  const ForTechniciansSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.darkSectionGradient),
      padding: EdgeInsets.symmetric(
        horizontal: padding.horizontal / 2,
        vertical: 80,
      ),
      child: isMobile
          ? Column(
              children: [
                _TechContent(),
                const SizedBox(height: 48),
                _TechStats(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 5, child: _TechContent()),
                const SizedBox(width: 80),
                Expanded(flex: 4, child: _TechStats()),
              ],
            ),
    );
  }
}

class _TechContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.5),
              width: 1,
            ),
            color: AppColors.accent.withValues(alpha: 0.15),
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
                'Para técnicos y trabajadores',
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
        Text(
          '¿Eres técnico?\nÚnete a NODO.',
          style: GoogleFonts.inter(
            fontSize: isMobile ? 30 : 40,
            fontWeight: FontWeight.w800,
            color: AppColors.textOnDark,
            height: 1.15,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Deja de depender del boca a boca. Construye tu reputación digital y recibe trabajos de forma constante.',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.textOnDarkMuted,
            height: 1.65,
          ),
        ),
        const SizedBox(height: 32),
        ...[
          _BenefitRow(
            Icons.people_rounded,
            'Más clientes',
            'Llega a cientos de hogares que buscan tus servicios hoy.',
          ),
          _BenefitRow(
            Icons.star_rate_rounded,
            'Reputación digital',
            'Acumula calificaciones y conviértete en el técnico más elegido de tu zona.',
          ),
          _BenefitRow(
            Icons.sell_rounded,
            'Materiales más baratos',
            'Compra con el código NODO en ferreterías aliadas y ahorra en cada trabajo.',
          ),
          _BenefitRow(
            Icons.payment_rounded,
            'Pagos seguros',
            'Sin riesgo de no cobrar. La plataforma respalda la transacción.',
          ),
        ],
        const SizedBox(height: 40),
        _TechCtaButton(),
      ],
    );
  }
}

class _BenefitRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _BenefitRow(this.icon, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textOnDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textOnDarkMuted,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechCtaButton extends StatefulWidget {
  @override
  State<_TechCtaButton> createState() => _TechCtaButtonState();
}

class _TechCtaButtonState extends State<_TechCtaButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: _hovered
              ? AppColors.accentGradient
              : AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: (_hovered ? AppColors.accent : AppColors.primary)
                  .withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Registrarme como técnico',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'De informal a profesional\nreconocido',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textOnDark,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(child: _StatItem('0→∞', 'Clientes digitales')),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withValues(alpha: 0.15),
              ),
              Expanded(child: _StatItem('⭐ 4.9', 'Calificación promedio')),
            ],
          ),
          const SizedBox(height: 24),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.1)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _StatItem('🏷️ -15%', 'En materiales')),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withValues(alpha: 0.15),
              ),
              Expanded(child: _StatItem('💬 Chat', 'Con tus clientes')),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Sin burocracia. Registra tu perfil en minutos y empieza a recibir trabajos.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.success,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textOnDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textOnDarkMuted,
          ),
        ),
      ],
    );
  }
}
