import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/chat_message.dart';

class DatabaseService {
  static const String _databaseName = 'copilot_mobile.db';
  static const int _databaseVersion = 1;
  static const String _messagesTable = 'messages';
  static const String _conversationsTable = 'conversations';

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_conversationsTable (
        id TEXT PRIMARY KEY,
        title TEXT,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $_messagesTable (
        id TEXT PRIMARY KEY,
        conversationId TEXT,
        content TEXT,
        isUser INTEGER,
        timestamp TEXT,
        codeBlock TEXT,
        language TEXT,
        FOREIGN KEY (conversationId) REFERENCES $_conversationsTable(id)
      )
    ''');
  }

  Future<void> saveMessage(ChatMessageModel message, String conversationId) async {
    final db = await database;
    await db.insert(
      _messagesTable,
      {
        'id': message.id,
        'conversationId': conversationId,
        'content': message.content,
        'isUser': message.isUser ? 1 : 0,
        'timestamp': message.timestamp.toIso8601String(),
        'codeBlock': message.codeBlock,
        'language': message.language,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ChatMessageModel>> getMessages(String conversationId) async {
    final db = await database;
    final maps = await db.query(
      _messagesTable,
      where: 'conversationId = ?',
      whereArgs: [conversationId],
      orderBy: 'timestamp ASC',
    );

    return List.generate(maps.length, (i) {
      return ChatMessageModel(
        id: maps[i]['id'] as String,
        content: maps[i]['content'] as String,
        isUser: (maps[i]['isUser'] as int) == 1,
        timestamp: DateTime.parse(maps[i]['timestamp'] as String),
        codeBlock: maps[i]['codeBlock'] as String?,
        language: maps[i]['language'] as String?,
      );
    });
  }

  Future<void> createConversation(String id, String title) async {
    final db = await database;
    await db.insert(
      _conversationsTable,
      {
        'id': id,
        'title': title,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getConversations() async {
    final db = await database;
    return await db.query(
      _conversationsTable,
      orderBy: 'updatedAt DESC',
    );
  }

  Future<void> deleteConversation(String id) async {
    final db = await database;
    await db.delete(
      _conversationsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    await db.delete(
      _messagesTable,
      where: 'conversationId = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete(_messagesTable);
    await db.delete(_conversationsTable);
  }
}
