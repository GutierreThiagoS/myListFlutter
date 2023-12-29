// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductDao? _productDaoInstance;

  CategoryDao? _categoryDaoInstance;

  ItemShoppingDao? _itemShoppingDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Product` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT NOT NULL, `image` TEXT NOT NULL, `brand` TEXT NOT NULL, `categoryIdFk` INTEGER, `ean` TEXT NOT NULL, `price` REAL NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ItemShopping` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `productId` INTEGER, `quantity` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductInItemShopping` (`id` INTEGER, `productId` INTEGER, `description` TEXT, `image` TEXT, `brand` TEXT, `categoryId` INTEGER, `categoryDescription` TEXT, `ean` TEXT, `price` REAL, `quantity` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }

  @override
  ItemShoppingDao get itemShoppingDao {
    return _itemShoppingDaoInstance ??=
        _$ItemShoppingDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _productInsertionAdapter = InsertionAdapter(
            database,
            'Product',
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'image': item.image,
                  'brand': item.brand,
                  'categoryIdFk': item.categoryIdFk,
                  'ean': item.ean,
                  'price': item.price
                }),
        _productUpdateAdapter = UpdateAdapter(
            database,
            'Product',
            ['id'],
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'image': item.image,
                  'brand': item.brand,
                  'categoryIdFk': item.categoryIdFk,
                  'ean': item.ean,
                  'price': item.price
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Product> _productInsertionAdapter;

  final UpdateAdapter<Product> _productUpdateAdapter;

  @override
  Future<Product?> findId(int id) async {
    return _queryAdapter.query('SELECT * FROM Product WHERE id = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => Product(
            row['id'] as int?,
            row['description'] as String,
            row['image'] as String,
            row['brand'] as String,
            row['categoryIdFk'] as int?,
            row['ean'] as String,
            row['price'] as double),
        arguments: [id]);
  }

  @override
  Future<List<Product>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Product',
        mapper: (Map<String, Object?> row) => Product(
            row['id'] as int?,
            row['description'] as String,
            row['image'] as String,
            row['brand'] as String,
            row['categoryIdFk'] as int?,
            row['ean'] as String,
            row['price'] as double));
  }

  @override
  Future<List<ProductInItemShopping>> getAllShopping() async {
    return _queryAdapter.queryList(
        'SELECT I.id | 0 AS id, P.id AS productId, P.description AS description, P.image AS image, P.brand AS brand, C.id AS categoryId, C.name AS categoryDescription, P.ean AS ean, P.price AS price, I.quantity AS quantity FROM Product AS P LEFT JOIN ItemShopping AS I ON P.id = I.productId LEFT JOIN Category AS C ON P.categoryIdFk = C.id',
        mapper: (Map<String, Object?> row) => ProductInItemShopping(
            row['id'] as int?,
            row['productId'] as int?,
            row['description'] as String?,
            row['image'] as String?,
            row['brand'] as String?,
            row['categoryId'] as int?,
            row['categoryDescription'] as String?,
            row['ean'] as String?,
            row['price'] as double?,
            row['quantity'] as int?));
  }

  @override
  Stream<List<ProductInItemShopping>> getAllShoppingAsync() {
    return _queryAdapter.queryListStream(
        'SELECT I.id | 0 AS id, P.id AS productId, P.description AS description, P.image AS image, P.brand AS brand, C.id AS categoryId, C.name AS categoryDescription, P.ean AS ean, P.price AS price, I.quantity AS quantity FROM Product AS P LEFT JOIN ItemShopping AS I ON P.id = I.productId LEFT JOIN Category AS C ON P.categoryIdFk = C.id',
        mapper: (Map<String, Object?> row) => ProductInItemShopping(
            row['id'] as int?,
            row['productId'] as int?,
            row['description'] as String?,
            row['image'] as String?,
            row['brand'] as String?,
            row['categoryId'] as int?,
            row['categoryDescription'] as String?,
            row['ean'] as String?,
            row['price'] as double?,
            row['quantity'] as int?),
        queryableName: 'Product',
        isView: false);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Product');
  }

  @override
  Future<int> insertProduct(Product product) {
    return _productInsertionAdapter.insertAndReturnId(
        product, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertAll(List<Product> products) {
    return _productInsertionAdapter.insertListAndReturnIds(
        products, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateProduct(Product product) {
    return _productUpdateAdapter.updateAndReturnChangedRows(
        product, OnConflictStrategy.abort);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'Category',
            (Category item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  @override
  Future<List<Category>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Category',
        mapper: (Map<String, Object?> row) =>
            Category(row['id'] as int?, row['name'] as String));
  }

  @override
  Future<Category?> findId(int id) async {
    return _queryAdapter.query('SELECT * FROM Category WHERE id = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) =>
            Category(row['id'] as int?, row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Category');
  }

  @override
  Future<void> insertCategory(Category category) async {
    await _categoryInsertionAdapter.insert(category, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertAll(List<Category> categories) {
    return _categoryInsertionAdapter.insertListAndReturnIds(
        categories, OnConflictStrategy.abort);
  }
}

class _$ItemShoppingDao extends ItemShoppingDao {
  _$ItemShoppingDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _itemShoppingInsertionAdapter = InsertionAdapter(
            database,
            'ItemShopping',
            (ItemShopping item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'quantity': item.quantity
                }),
        _itemShoppingUpdateAdapter = UpdateAdapter(
            database,
            'ItemShopping',
            ['id'],
            (ItemShopping item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'quantity': item.quantity
                }),
        _itemShoppingDeletionAdapter = DeletionAdapter(
            database,
            'ItemShopping',
            ['id'],
            (ItemShopping item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'quantity': item.quantity
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ItemShopping> _itemShoppingInsertionAdapter;

  final UpdateAdapter<ItemShopping> _itemShoppingUpdateAdapter;

  final DeletionAdapter<ItemShopping> _itemShoppingDeletionAdapter;

  @override
  Future<ItemShopping?> findId(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM ItemShopping WHERE id = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => ItemShopping(row['id'] as int?,
            row['productId'] as int?, row['quantity'] as int),
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM ItemShopping');
  }

  @override
  Future<List<ProductInItemShopping>> getAllShopping() async {
    return _queryAdapter.queryList(
        'SELECT I.id | 0 AS id, P.id AS productId, P.description AS description, P.image AS image, P.brand AS brand, C.id AS categoryId, C.name AS categoryDescription, P.ean AS ean, P.price AS price, I.quantity AS quantity FROM Product AS P INNER JOIN ItemShopping AS I ON P.id = I.productId INNER JOIN Category AS C ON P.categoryIdFk = C.id',
        mapper: (Map<String, Object?> row) => ProductInItemShopping(
            row['id'] as int?,
            row['productId'] as int?,
            row['description'] as String?,
            row['image'] as String?,
            row['brand'] as String?,
            row['categoryId'] as int?,
            row['categoryDescription'] as String?,
            row['ean'] as String?,
            row['price'] as double?,
            row['quantity'] as int?));
  }

  @override
  Stream<List<ProductInItemShopping>> getAllShoppingAsync() {
    return _queryAdapter.queryListStream(
        'SELECT DISTINCT I.id | 0 AS id, P.id AS productId, P.description AS description, P.image AS image, P.brand AS brand, C.id AS categoryId, C.name AS categoryDescription, P.ean AS ean, P.price AS price, I.quantity AS quantity FROM Product AS P INNER JOIN ItemShopping AS I ON P.id = I.productId INNER JOIN Category AS C ON P.categoryIdFk = C.id',
        mapper: (Map<String, Object?> row) => ProductInItemShopping(
            row['id'] as int?,
            row['productId'] as int?,
            row['description'] as String?,
            row['image'] as String?,
            row['brand'] as String?,
            row['categoryId'] as int?,
            row['categoryDescription'] as String?,
            row['ean'] as String?,
            row['price'] as double?,
            row['quantity'] as int?),
        queryableName: 'Product',
        isView: false);
  }

  @override
  Future<int> insertItemShopping(ItemShopping itemShopping) {
    return _itemShoppingInsertionAdapter.insertAndReturnId(
        itemShopping, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItemShopping(ItemShopping itemShopping) {
    return _itemShoppingUpdateAdapter.updateAndReturnChangedRows(
        itemShopping, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItemShopping(ItemShopping itemShopping) {
    return _itemShoppingDeletionAdapter
        .deleteAndReturnChangedRows(itemShopping);
  }
}
