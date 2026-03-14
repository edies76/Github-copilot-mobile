import 'package:flutter_test/flutter_test.dart';
import 'package:github_copilot_mobile/services/copilot_service.dart';

void main() {
  group('CopilotService Tests', () {
    late CopilotService copilotService;

    setUp(() {
      copilotService = CopilotService(token: 'test_token');
    });

    test('getCodeSuggestion returns a string', () async {
      final suggestion = await copilotService.getCodeSuggestion('async function');
      expect(suggestion, isNotEmpty);
      expect(suggestion, isA<String>());
    });

    test('debugCode returns a string', () async {
      final debug = await copilotService.debugCode('void main() {}');
      expect(debug, isNotEmpty);
      expect(debug, isA<String>());
    });

    test('generateDocumentation returns a string', () async {
      final docs = await copilotService.generateDocumentation('void main() {}');
      expect(docs, isNotEmpty);
      expect(docs, isA<String>());
    });

    test('reviewCode returns a string', () async {
      final review = await copilotService.reviewCode('void main() {}');
      expect(review, isNotEmpty);
      expect(review, isA<String>());
    });
  });
}
