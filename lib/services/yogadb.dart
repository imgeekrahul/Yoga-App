import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yoga_app/model/model.dart';

class YogaDatabase{
  static final YogaDatabase instance = YogaDatabase._init();
  static Database? _database;
  YogaDatabase._init();

  Future<Database> _initalizeDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath , filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future <Database?> get database async{
    if(_database != null) return _database;
    _database = await _initalizeDB("YogaStpesDB.db");

    return _database;
  }

  Future _createDB(Database db, int version) async {

    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final intType = "INTEGER NOT NULL";
    final textType = "TEXT NOT NULL";
    final boolType = "BOOLEAN NOT NULL";
    // id, bool(Seconds), text

    await db.execute('''
      CREATE TABLE ${YogaModel.YogaTable1} (
        ${YogaModel.IDName} $idType,
        ${YogaModel.YogaKeyWorkOuts} $intType,
        ${YogaModel.YogaName} $textType,
        ${YogaModel.ImageName} $textType,
        ${YogaModel.SecondsOrNot} $boolType, 
        ${YogaModel.SecondsOrTimes} $textType
      )
    ''');

    await db.execute(''' 
      CREATE TABLE ${YogaModel.YogaTable2}(
        ${YogaModel.IDName} $idType,
        ${YogaModel.YogaKeyWorkOuts} $intType,
        ${YogaModel.YogaName} $textType,
        ${YogaModel.ImageName} $textType,
        ${YogaModel.SecondsOrNot} $boolType,
        ${YogaModel.SecondsOrTimes} $textType
      )
    ''');

    await db.execute(''' 
      CREATE TABLE ${YogaModel.YogaTable3}(
        ${YogaModel.IDName} $idType,
        ${YogaModel.YogaKeyWorkOuts} $intType,
        ${YogaModel.YogaName} $textType,
        ${YogaModel.ImageName} $textType,
        ${YogaModel.SecondsOrNot} $boolType,
        ${YogaModel.SecondsOrTimes} $textType
      )
    ''');

    await db.execute(''' 
      CREATE TABLE ${YogaModel.YogaSummary}(
        ${YogaModel.IDName} $idType,
        ${YogaModel.YogaWorkOutName} $textType,
        ${YogaModel.YogaKey} $intType,
        ${YogaModel.BackImg} $textType,
        ${YogaModel.TimeTaken} $textType,
        ${YogaModel.TotalNoOfWork} $textType
      )
    ''');
  }


  // Insert the data in DB
  Future<Yoga?> Insert(Yoga yoga, String TableName) async{
    final db = await instance.database;

    final id = await db!.insert(TableName,  yoga.toJson());

    return yoga.copy(id:id);
  }

  Future<YogaSummary?> InsertYogaSum(YogaSummary yogasum) async{
    final db = await instance.database;

    final id = await db!.insert(YogaModel.YogaSummary,  yogasum.toJson());

    return yogasum.copy(id:id);
  }


  Future<List<Yoga>> readAllYoga(String TableName) async{
    final db = await instance.database;

    final orderBy = '${YogaModel.IDName} ASC';
    final query_res = await db!.query(TableName, orderBy: orderBy);
    return query_res.map((json) => Yoga.fromJson(json)).toList();
  }


  Future<List<YogaSummary>> readAllYogaSum() async{
    final db = await instance.database;
    final orderBy = '${YogaModel.IDName} ASC';
    final query_res = await db!.query(YogaModel.YogaSummary, orderBy: orderBy);
    return query_res.map((json) => YogaSummary.fromJson(json)).toList();
  }


  // If we read 1 yoga
  Future<Yoga?> readOneYoga(int id, String TableName) async{
    final db = await instance.database;

    final map = await db!.query(TableName, columns: YogaModel.YogaTable1ColumnName, where: '${YogaModel.IDName} = ?', whereArgs: [id]);

    if(map.isNotEmpty){
      return Yoga.fromJson(map.first);
    } else {
      return null;
    }
  }
}