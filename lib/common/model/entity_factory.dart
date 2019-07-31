import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/model/test/cofig_result_entity.dart';
import 'package:flutter_smallworld/common/model/test/rank_list_result.dart';

typedef T CreateEntity<T>(Map<String, dynamic> json);

class BaseEntity {
  void onParseComplete() => null;

  Map<String, dynamic> toJson() => null;
}

class EntityCreatorFactory {
  static void registerAllCreator() {
    _EntityFactory.instance.registerCreator(TaskhallResult, (Map<String, dynamic> json) => TaskhallResult.fromJson(json));
    _EntityFactory.instance.registerCreator(LoginResult, (Map<String, dynamic> json) => LoginResult.fromJson(json));
    _EntityFactory.instance.registerCreator(UserInfo, (Map<String, dynamic> json) => UserInfo.fromJson(json));
    _EntityFactory.instance.registerCreator(HomeTabResult, (Map<String, dynamic> json) => HomeTabResult.fromJson(json));
    _EntityFactory.instance.registerCreator(Entity, (Map<String, dynamic> json) => Entity.fromJson(json));
    _EntityFactory.instance.registerCreator(RankListResult, (Map<String, dynamic> json) => RankListResult.fromJson(json));

  }

  static T createEntity<T>(Map<dynamic, dynamic> json) {
    return _EntityFactory.instance.generateEntity<T>(mapDynamicDynamicToStringDynamic(json));
  }

  static List<T> createEntityList<T>(List<dynamic> jsonList) {
    return _EntityFactory.instance.generateList<T>(jsonList);
  }

  static Map<String, dynamic> mapDynamicDynamicToStringDynamic(Map<dynamic, dynamic> map) {
    List<dynamic> keyList = map.keys.toList();
    Map<String, dynamic> targetMap = {};
    for(dynamic key in keyList) {
      targetMap[key.toString()] = map[key];
    }
    return targetMap;
  }
}

class _EntityFactory {
  Map<Type, CreateEntity> typeMaps = new Map();

  static _EntityFactory _sInstance = _EntityFactory._internal();

  static _EntityFactory get instance => _sInstance;

  _EntityFactory._internal() {

  }

  registerCreator(Type type, CreateEntity creator) {
    typeMaps[type] = creator;
  }

  E generateEntity<E>(Map<String, dynamic> json) {
    CreateEntity creator = typeMaps[E];
    E e = creator(json);
    (e as BaseEntity).onParseComplete();
    return e;
  }

  List<E> generateList<E>(List<dynamic> jsonList) {
    CreateEntity creator = typeMaps[E];
    return jsonList.map((dynamic json) {
      if (json != null) {
        E e = creator(json);
        (e as BaseEntity).onParseComplete();
        return e;
      }
      return null;
    }).toList();
  }

  Map<String, dynamic> generateJsonMap<E>(E e) {
    return (e as BaseEntity).toJson();
  }

}