import 'package:flutter/material.dart';

class AppColors {
  // ── Primary Purple Family ────────────────────────────────
  static const Color primary = Color(0xFF6B21A8);        // Deep rich purple (main brand)
  static const Color primaryDark = Color(0xFF4C1D95);    // Darker purple for pressed states
  static const Color primaryLight = Color(0xFF9333EA);   // Brighter purple for accents
  static const Color softPurple = Color(0xFFF3E8FF);     // Very light purple backgrounds
  static const Color lilac = Color(0xFFC084FC);          // Soft lilac for highlights

  // ── Neutrals ─────────────────────────────────────────────
  static const Color darkBlue = Color(0xFF1E1B4B);       // Almost black-purple for text
  static const Color textColor = Color(0xFF1E1B4B);
  static const Color gray = Color(0xFF6B7280);
  static const Color lightGray = Color(0xFFF9FAFB);
  static const Color white = Colors.white;
  static const Color border = Color(0xFFE5E7EB);

  // ── Aliases (so your existing code doesn’t break) ────────
  static const Color purple = primary;                   // ← main purple
  static const Color mainBlue = primary;                 // keep old name working
  static const Color grey = Color(0xFFD1D5DB);
}