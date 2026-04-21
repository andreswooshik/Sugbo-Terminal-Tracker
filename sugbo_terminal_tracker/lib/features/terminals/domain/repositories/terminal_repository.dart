import '../models/terminal_wait_model.dart';

abstract class TerminalRepository {
  Future<List<TerminalWaitModel>> getAllTerminals();
  Future<TerminalWaitModel?> getTerminalByName(String name);
  Future<void> updateWaitTime(String terminalName, String waitTime);
}
