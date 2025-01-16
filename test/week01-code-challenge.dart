typedef bulkWords = List<Map<String, String>>;

class Dictionary {
  Map<String, String> word = {};

  // 단어를 추가함.
  void add({
    required String term,
    required String definition,
  }) {
    if (term.isNotEmpty && definition.isNotEmpty) {
      if (!word.containsKey(term)) {
        word[term] = definition;
      } else {
        print('이미 사전에 추가된 단어 [$term]');
      }
    }
  }

  // 단어의 정의를 리턴함.
  String get(String term) {
    return word[term] ?? '';
  }

  // 단어를 삭제함.
  void delete(String term) {
    word.remove(term);
  }

  // 단어를 업데이트 함.
  void update({
    required String term,
    required String definition,
  }) {
    if (term.isNotEmpty && definition.isNotEmpty) {
      if (word.containsKey(term)) {
        word.update(term, (value) => definition);
      } else {
        print('사전에 존재하지 않는 단어[$term]');
      }
    }
  }

  // 사전 단어를 모두 보여줌.
  void showAll() {
    var sortedKeys = word.keys.toList()..sort();
    for (var key in sortedKeys) {
      print('$key: ${word[key]}');
    }
  }

  // 사전 단어들의 총 갯수를 리턴함.
  int count() {
    return word.length;
  }

  // 단어를 업데이트 함. 존재하지 않을 시 이를 추가함.
  void upsert({
    required String term,
    required String definition,
  }) {
    if (exists(term)) {
      update(term: term, definition: definition);
    } else {
      add(term: term, definition: definition);
    }
  }

  // 해당 단어가 사전에 존재하는지 여부를 알려줌.
  bool exists(String term) {
    return word.containsKey(term);
  }

  // 여러 개의 단어를 추가.
  void bulkAdd(bulkWords words) {
    if (words.isNotEmpty) {
      for (var values in words) {
        if (values.containsKey('term') && values.containsKey('definition')) {
          final term = values['term'];
          final definition = values['definition'];
          if (term != null && definition != null) {
            add(term: term, definition: definition);
          }
        } else {
          print('단어 추가 실패 [$values]');
        }
      }
    }
  }

  // 여러 개의 단어를 삭제.
  void bulkDelete(List<String> terms) {
    if (terms.isNotEmpty) {
      for (var term in terms) {
        delete(term);
      }
    }
  }
}

void main() {
  var testDictionary = Dictionary();

  // 단어 추가 테스트
  testDictionary.add(term: '빠퇴', definition: '빠른 퇴근');
  testDictionary.add(term: '중꺽마', definition: '중요한 것은 꺾이지 않는 마음');
  testDictionary.add(term: '편커족', definition: '편의점 커피 애용자');
  testDictionary.showAll();

  // 단어 조회 테스트
  print('단어 "빠퇴"의 정의: ${testDictionary.get('빠퇴')}');

  // 단어 삭제 테스트
  testDictionary.delete('빠퇴');
  testDictionary.showAll();

  // 단어 업데이트 테스트
  testDictionary.update(term: '중꺽마', definition: '중요한 것은 꺾이지 않는 마음가짐');
  testDictionary.showAll();

  // 단어 존재 여부 확인
  bool exists = testDictionary.exists('중꺽마');
  print('단어 "중꺽마" 존재 여부: $exists');

  // Upsert 테스트 (존재하면 업데이트, 없으면 추가)
  testDictionary.upsert(term: '중꺽마', definition: '중요한 것은 포기하지 않는 마음');
  testDictionary.upsert(term: '갓생', definition: '부지런하고 모범적인 삶');
  testDictionary.showAll();

  // 여러 단어 추가 테스트 (bulkAdd)
  testDictionary.bulkAdd([
    {"term": "김치", "definition": "한국 전통 음식"},
    {"term": "라방", "definition": "라이브 방송"},
    {"term": "식테크", "definition": "식물과 재테크의 합성어"}
  ]);
  testDictionary.showAll();

  // 여러 단어 삭제 테스트 (bulkDelete)
  testDictionary.bulkDelete(["김치", "라방"]);
  testDictionary.showAll();

  // 단어 개수 확인
  print('사전에 등록된 단어 개수: ${testDictionary.count()}');
}
