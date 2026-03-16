import 'package:dio/dio.dart';
import '../models/chat_message.dart';

class CopilotService {
  static const String _apiUrl = 'https://api.github.com/copilot';
  
  final Dio _dio = Dio();
  final String _token;

  CopilotService({required String token}) : _token = token;

  Future<String> getCodeSuggestion(String prompt) async {
    try {
      // Simular respuesta de Copilot
      // En producción, esto llamaría a la API real de GitHub Copilot
      await Future.delayed(const Duration(seconds: 2));
      
      return _generateMockSuggestion(prompt);
    } catch (e) {
      print('Error getting code suggestion: $e');
      rethrow;
    }
  }

  Future<String> debugCode(String code) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return _generateMockDebugSuggestion(code);
    } catch (e) {
      print('Error debugging code: $e');
      rethrow;
    }
  }

  Future<String> generateDocumentation(String code) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return _generateMockDocumentation(code);
    } catch (e) {
      print('Error generating documentation: $e');
      rethrow;
    }
  }

  Future<String> reviewCode(String code) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return _generateMockCodeReview(code);
    } catch (e) {
      print('Error reviewing code: $e');
      rethrow;
    }
  }

  String _generateMockSuggestion(String prompt) {
    final suggestions = {
      'async': '''
Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
    }
  } catch (e) {
    print('Error: \$e');
  }
}
''',
      'widget': '''
class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Widget')),
      body: Center(child: Text('Hello World')),
    );
  }
}
''',
      'api': '''
Future<List<User>> fetchUsers() async {
  final response = await Dio().get('https://api.example.com/users');
  if (response.statusCode == 200) {
    return (response.data as List)
        .map((u) => User.fromJson(u))
        .toList();
  }
  throw Exception('Failed to load users');
}
''',
    };

    for (final key in suggestions.keys) {
      if (prompt.toLowerCase().contains(key)) {
        return suggestions[key]!;
      }
    }

    return '''
// Suggested code based on your prompt:
// $prompt

void main() {
  print('Hello, World!');
}
''';
  }

  String _generateMockDebugSuggestion(String code) {
    return '''
**Potential Issues Found:**

1. **Null Safety**: Check for null values before accessing properties
2. **Error Handling**: Add try-catch blocks for API calls
3. **Performance**: Consider using const constructors where possible
4. **Memory Leaks**: Ensure resources are properly disposed

**Suggested Fix:**
```dart
try {
  final result = await someAsyncOperation();
  if (result != null) {
    // Process result
  }
} catch (e) {
  print('Error: \$e');
}
```
''';
  }

  String _generateMockDocumentation(String code) {
    return '''
## Function Documentation

### Purpose
This function performs an important operation in your application.

### Parameters
- `input` (String): The input data to process

### Returns
- `Future<String>`: A future that resolves to the processed result

### Example Usage
```dart
final result = await myFunction('example');
print(result);
```

### Exceptions
- `FormatException`: Thrown if input format is invalid
- `TimeoutException`: Thrown if operation takes too long
''';
  }

  String _generateMockCodeReview(String code) {
    return '''
## Code Review

### ✅ Strengths
- Good use of async/await
- Proper error handling
- Clear variable naming

### ⚠️ Areas for Improvement
1. Add null safety checks
2. Consider extracting repeated code into helper functions
3. Add unit tests for edge cases
4. Document public APIs

### 💡 Suggestions
- Use const constructors where applicable
- Consider using freezed for immutable classes
- Add logging for debugging purposes

### Rating: 7/10
''';
  }
}
