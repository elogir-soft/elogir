/// Maps a display position (0–6) to the alarm's internal day index (0=Mon, 6=Sun).
int displayToDay(int displayIndex, {required bool weekStartsOnMonday}) {
  if (weekStartsOnMonday) return displayIndex;
  // Sunday-first: display 0 → Sunday (6), display 1–6 → Mon–Sat (0–5).
  return displayIndex == 0 ? 6 : displayIndex - 1;
}

/// Maps an internal day index (0=Mon, 6=Sun) to a display position.
int dayToDisplay(int dayIndex, {required bool weekStartsOnMonday}) {
  if (weekStartsOnMonday) return dayIndex;
  // Sunday-first: Sunday (6) → display 0, Mon–Sat (0–5) → display 1–6.
  return dayIndex == 6 ? 0 : dayIndex + 1;
}
