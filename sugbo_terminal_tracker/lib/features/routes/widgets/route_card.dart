import 'package:flutter/material.dart';
import '../models/route_model.dart';

class RouteCard extends StatelessWidget {
  final RouteModel route;

  const RouteCard({Key? key, required this.route}) : super(key: key);

  // ---------------------------------------------------------------------------
  // Colors per routeType
  // ---------------------------------------------------------------------------
  Color get _accentColor {
    switch (route.routeType) {
      case 'libreng_sakay':
        return const Color(0xFF21D98F); // green
      case 'free_ride':
        return const Color(0xFF21D98F); // green
      default:
        if (route.title.contains('CBRT') || route.title.contains('BRT')) {
          return const Color(0xFF388CFF); // blue
        }
        if (route.title.contains('Love Bus')) {
          return const Color(0xFFFF6199); // pink
        }
        return const Color(0xFF21D98F); // green default for MyBus
    }
  }

  Color get _badgeBg => _accentColor.withOpacity(0.15);
  Color get _badgeText => _accentColor;

  Color get _borderColor {
    if (route.isFree) return _accentColor.withOpacity(0.5);
    return Colors.transparent;
  }

  Color get _priceColor {
    if (route.isFree) return const Color(0xFF21D98F);
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF151B26),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: route.isFree
              ? _accentColor.withOpacity(0.35)
              : const Color(0xFF1E2535),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top section ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge chip
                _Chip(label: route.badgeLabel, color: _badgeText, bg: _badgeBg),
                const SizedBox(width: 8),

                // "FREE NOW" secondary chip when active
                if (route.isFree && route.isLibrengSakay) ...[
                  _Chip(
                    label: 'FREE NOW',
                    color: const Color(0xFF21D98F),
                    bg: const Color(0xFF21D98F).withOpacity(0.12),
                  ),
                  const SizedBox(width: 8),
                ],

                // Subtitle
                Expanded(
                  child: Text(
                    route.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF8A93A6),
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // ── Route path ─────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
            child: Text(
              route.path,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),

          // ── Duration ───────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 0),
            child: Text(
              route.duration,
              style: const TextStyle(color: Color(0xFF8A93A6), fontSize: 11),
            ),
          ),

          // ── Free window banner (only when isFree=false but hasFreeWindow) ─
          if (!route.isFree && route.hasFreeWindow)
            Container(
              margin: const EdgeInsets.fromLTRB(14, 10, 14, 0),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF21D98F).withOpacity(0.07),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF21D98F).withOpacity(0.2),
                  width: 0.5,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    color: Color(0xFF21D98F),
                    size: 12,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Free window: ${route.freeWindowLabel}',
                    style: const TextStyle(
                      color: Color(0xFF21D98F),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

          // ── Divider ────────────────────────────────────────────────────────
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: Color(0xFF1E2535), height: 0, thickness: 0.5),
          ),

          // ── Price / comparison / status row ────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Price
                Text(
                  route.displayPrice,
                  style: TextStyle(
                    color: _priceColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(width: 8),

                // Comparison (vs Grab, savings, etc.)
                Expanded(
                  child: Text(
                    route.comparison,
                    style: const TextStyle(
                      color: Color(0xFF8A93A6),
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(width: 8),

                // Status / next departure
                Text(
                  route.status,
                  style: const TextStyle(
                    color: Color(0xFF8A93A6),
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Private chip widget ───────────────────────────────────────────────────────
class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  final Color bg;

  const _Chip({required this.label, required this.color, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
