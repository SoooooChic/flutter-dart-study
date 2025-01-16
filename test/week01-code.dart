typedef bulkWords = List<Map<String, String>>;

class Dictionary {
  late Map<String, String> word;

  // 생성자
  Dictionary() {
    word = {};
  }

  // 단어를 추가함.
  void add({
    required String term,
    required String definition,
  }) {
    if (term.isNotEmpty && definition.isNotEmpty) {
      word.putIfAbsent(term, () => definition);
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
      word.update(term, (value) => definition);
    }
  }

  // 사전 단어를 모두 보여줌.
  void showAll() {
    print(word);
    //print(word.keys);
  }

  // 사전 단어들의 총 갯수를 리턴함.
  int count() {
    return word.length;
  }

  // 단어를 업데이트 함. 존재하지 않을시. 이를 추가함. (update + insert = upsert)
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

  // 다음과 같은 방식으로. 여러개의 단어를 한번에 추가할 수 있게 해줌. [{"term":"김치", "definition":"대박이네~"}, {"term":"아파트", "definition":"비싸네~"}]
  void bulkAdd(bulkWords words) {
    if (!words.isEmpty) {
      for (var values in words) {
        if (values.containsKey('term') && values.containsKey('definition')) {
          add(term: values['term']!, definition: values['definition']!);
        }
      }
    }
  }

  // 다음과 같은 방식으로. 여러개의 단어를 한번에 삭제할 수 있게 해줌. ["김치", "아파트"]
  void bulkDelete(List<String> terms) {
    if (!terms.isEmpty) {
      terms.forEach(delete);
    }
  }
}

void main() {
  // class 호출
  var testDictionary = Dictionary();

  // add: 단어를 추가함.
  testDictionary
    ..add(
      term: '빠퇴',
      definition: '빠른 퇴근',
    )
    ..add(
      term: '중꺽마',
      definition: '중요한 것은 꺾이지 않는 마음',
    )
    ..add(
      term: '편커족',
      definition: '편의점과 커피의 앞 글자를 합친 말로 편의점 커피를 애용하는 사람들을 뜻함',
    );

  // get: 단어의 정의를 리턴함.
  print('사전에 등록된 빠퇴 의 뜻은 `${testDictionary.get('빠퇴')}` 입니다.');

  // delete: 단어를 삭제함.
  testDictionary
    ..delete('빠퇴')
    // update: 단어를 업데이트 함.
    ..update(
      term: '중꺽마',
      definition: '중요한 것은 꺾이지 않는 마음가짐',
    )
    // showAll: 사전 단어를 모두 보여줌.
    ..showAll();

  // count: 사전 단어들의 총 갯수를 리턴함.
  print('사전에 등록된 단어의 갯수는 `${testDictionary.count()}`개 입니다.');

  testDictionary
    // upsert 단어를 업데이트 함. 존재하지 않을시. 이를 추가함. (update + insert = upsert)
    ..upsert(
      term: '중꺽마',
      definition: '중요한 것은 꺾이지 않는 마음가짐 이라고 볼수 있습니다',
    )
    ..upsert(
      term: '갓생',
      definition: '신을 의미하는 God과 인생을 뜻하는 생의 합성어로 부지런하고 타의 모범이 되는 삶',
    )
    ..upsert(
      term: '걍생',
      definition: '그냥(걍) 산다의 줄임말로 하루하루 계획적인 삶',
    );

  // exists: 해당 단어가 사전에 존재하는지 여부를 알려줌.
  print('사전에 갓생 이라는 단어의 검색 결과 `${testDictionary.exists('갓생')}` 입니다.');

  testDictionary
    // bulkAdd: 다음과 같은 방식으로. 여러개의 단어를 한번에 추가할 수 있게 해줌. [{"term":"김치", "definition":"대박이네~"}, {"term":"아파트", "definition":"비싸네~"}]
    ..bulkAdd([
      {"term": "김치", "definition": "대박이네~"},
      {"term": "아파트", "definition": "비싸네~"},
      {"term": "식테크", "definition": "식물과 재테크의 합성어"},
      {
        "term": "육각형인간",
        "definition": "외모,성격,학력,집안,직업,자산 여섯 개 축의 육각형 형태로 어디 하나 부족하지 않는 완벽형 인간"
      },
      {"term": "라방", "definition": "라이브방송"},
    ])
    // bulkDelete: 다음과 같은 방식으로. 여러개의 단어를 한번에 삭제할 수 있게 해줌. ["김치", "아파트"]
    ..bulkDelete(["김치", "아파트"])
    // showAll: 사전 단어를 모두 보여줌.
    ..showAll();
}
