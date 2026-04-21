import '../repositories/terminal_repository.dart';

class ReportWaitTimeUseCase {
  final TerminalRepository repository;

  ReportWaitTimeUseCase(this.repository);

  Future<Result<void, Exception>> call(String terminalId) {
    if (terminalId.isEmpty) {
      return Future.value(Failure(Exception('Terminal ID cannot be empty')));
    }
    return repository.reportWaitTime(terminalId);
  }
}

