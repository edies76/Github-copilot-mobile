import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_message.dart';
import '../services/copilot_service.dart';
import '../services/database_service.dart';

class ChatProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  late CopilotService _copilotService;
  
  List<ChatMessageModel> _messages = [];
  String _currentConversationId = '';
  bool _isLoading = false;
  String? _error;
  List<Map<String, dynamic>> _conversations = [];

  List<ChatMessageModel> get messages => _messages;
  String get currentConversationId => _currentConversationId;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Map<String, dynamic>> get conversations => _conversations;

  void initializeCopilotService(String token) {
    _copilotService = CopilotService(token: token);
  }

  Future<void> startNewConversation(String title) async {
    _currentConversationId = const Uuid().v4();
    _messages = [];
    _error = null;
    
    try {
      await _databaseService.createConversation(_currentConversationId, title);
      await _loadConversations();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<void> loadConversation(String conversationId) async {
    _currentConversationId = conversationId;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _messages = await _databaseService.getMessages(conversationId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage(String content) async {
    if (content.isEmpty) return;

    final userMessage = ChatMessageModel(
      id: const Uuid().v4(),
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    await _databaseService.saveMessage(userMessage, _currentConversationId);
    notifyListeners();

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _copilotService.getCodeSuggestion(content);
      
      final aiMessage = ChatMessageModel(
        id: const Uuid().v4(),
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      );

      _messages.add(aiMessage);
      await _databaseService.saveMessage(aiMessage, _currentConversationId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> debugCode(String code) async {
    final userMessage = ChatMessageModel(
      id: const Uuid().v4(),
      content: 'Debug this code:\n$code',
      isUser: true,
      timestamp: DateTime.now(),
      codeBlock: code,
      language: 'dart',
    );

    _messages.add(userMessage);
    await _databaseService.saveMessage(userMessage, _currentConversationId);
    notifyListeners();

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _copilotService.debugCode(code);
      
      final aiMessage = ChatMessageModel(
        id: const Uuid().v4(),
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      );

      _messages.add(aiMessage);
      await _databaseService.saveMessage(aiMessage, _currentConversationId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadConversations() async {
    try {
      _conversations = await _databaseService.getConversations();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<void> deleteConversation(String conversationId) async {
    try {
      await _databaseService.deleteConversation(conversationId);
      if (_currentConversationId == conversationId) {
        _currentConversationId = '';
        _messages = [];
      }
      await _loadConversations();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }
}
