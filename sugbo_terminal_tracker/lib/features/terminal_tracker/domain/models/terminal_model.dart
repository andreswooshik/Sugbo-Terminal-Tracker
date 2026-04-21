class TerminalUiModel {
  final String id;
  final String name;
  final String subtitle;
  final String estimatedWaitTime;
  final bool isFree;
  final String statusColorHex;

  TerminalUiModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.estimatedWaitTime,
    this.isFree = false,
    required this.statusColorHex,
  });
}
