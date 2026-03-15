/// Responsive breakpoints for the calculator app.
///
/// - compact: phones (< 600dp)
/// - medium: tablets portrait, foldables (600-839dp)
/// - expanded: tablets landscape, desktop (>= 840dp)
enum Breakpoint {
  compact,
  medium,
  expanded;

  static const double compactMax = 600;
  static const double mediumMax = 840;

  /// Determines the breakpoint for a given width.
  static Breakpoint fromWidth(double width) {
    if (width < compactMax) return Breakpoint.compact;
    if (width < mediumMax) return Breakpoint.medium;
    return Breakpoint.expanded;
  }
}
