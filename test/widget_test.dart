import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GitHub Copilot Mobile Tests', () {
    test('Basic app test', () {
      expect(true, isTrue);
    });

    test('String concatenation test', () {
      final result = 'Hello' + ' ' + 'World';
      expect(result, 'Hello World');
    });

    test('List operations test', () {
      final list = [1, 2, 3, 4, 5];
      expect(list.length, 5);
      expect(list.contains(3), isTrue);
      expect(list.contains(10), isFalse);
    });
  });
}
