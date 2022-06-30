import 'package:aula_2_persistencia_de_dados/database/dao/contato_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async /**Tudo oq for executado está dentro de um Future */
{
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(path, onCreate: (db, version)
  {
    db.execute(ContatoDao.tableSql);
  },
    version: 1,
//  onDowngrade: onDatabaseDowngradeDelete, //*Limpa dos dados da lista*
  );
}