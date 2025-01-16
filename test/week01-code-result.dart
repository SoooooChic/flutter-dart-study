/**
 * TA 가 제시하는 솔루션
 * https://github.com/devgony/flutter-study/commit/dab37dc3c949ee764c0ef0db56f3594cd5606409
 * class 는 속성과 동작을 하나의 템플릿으로 정의합니다. 이번 챌린지의 경우 Dictionary 는 words 를 속성으로 가지고 add, get.. 등과 같은 동작을 포함하고 있습니다.
 * typedef 는 Dart의 기본 type 을 사용자 정의의 이름으로 aliasing 해줍니다.
 * List 는 순서가 있는 항목들의 집합입니다. List는 다른 언어에서의 배열과 유사하며, 각 항목은 인덱스를 통해 접근할 수 있습니다. 인덱스는 0부터 시작합니다.
 * Map 은 키-값 쌍을 저장하는 데이터 구조입니다. 각 키는 고유해야 하며, 각 키는 하나의 값을 가리킵니다. 이러한 특성 때문에 Map은 빠르게 특정 값을 찾는 데 사용될 수 있습니다.
 * 솔루션에서는 Dictionary 내 word 의 유니크함을 보장하기 위해 List 보다는 Map을 사용 하였습니다.
 * Map은 == 연산자로 비교할 경우 주소값을 비교하기 때문에 모든 key와 value 를 비교하는 메서드가 필요합니다. 이를 위해 equals 메서드를 Extension 으로 구현하여 체이닝 메서드 호출을 통해 사용성을 높였습니다.
 * 해당 솔루션은 replit 에 편리하게 제출하기 위해서 하나의 파일에서 assert를 통해 테스트를 구현하였습니다. 실행을 위해서는 아래와 같이 추가 옵션을 주어야 합니다.
 * dart --enable-asserts main.dart
 * 실제 개발 환경에서는 test 패키지 를 통해 유닛 및 통합 테스팅이 가능합니다.
 * https://dart.dev/tools/testing
 * 틱톡 클론 30강 에서도 테스팅에 대해 자세히 배울 수 있습니다.
 * https://nomadcoders.co/tiktok-clone/lectures/4377
 * 요약
 * Dart 와 같은 객체 지향 언어에서 클래스는 매우 중요한 요소입니다. 특히 Flutter 는 모든 widget이 class로 이루어져 있기 때문에 미리 익숙해질 수 있도록 충분한 연습이 필요합니다.
 * Testing 역시 중요한 요소입니다.
 * Test를 먼저 작성하고 개발을 시작한다면 목표를 명확하게 할 수 있을 뿐만 아니라 이번 챌린지에서 배운 클래스를 더욱 세분화 된 클래스로 분리할 때에도 안심하고 refactoring 이 가능합니다.
 */
class Word {
  final String term;
  final String definition;
  Word({
    required this.term,
    required this.definition,
  });
}

typedef WordsInput = List<Map<String, String>>;

class Dictionary {
  Map<String, Word> words = {};

  bool exists(String term) {
    return words.containsKey(term);
  }

  Word? get(String term) {
    return words[term];
  }

  void add(String term, String definition) {
    if (!exists(term)) {
      words[term] = Word(
        term: term,
        definition: definition,
      );
    }
  }

  void showAll() {
    print("----");
    words.forEach((key, value) {
      print("${value.term}: ${value.definition}\n");
    });
    print("----");
  }

  int count() {
    return words.length;
  }

  void update(String term, String definition) {
    if (exists(term)) {
      words[term] = Word(
        term: term,
        definition: definition,
      );
    }
  }

  void delete(String term) {
    if (exists(term)) {
      words.remove(term);
    }
  }

  void upsert(String term, String definition) {
    if (exists(term)) {
      update(term, definition);
    } else {
      add(term, definition);
    }
  }

  void bulkAdd(WordsInput words) {
    for (var word in words) {
      if (word.containsKey('term') && word.containsKey('definition')) {
        add(word["term"] ?? "", word["definition"] ?? "");
      }
    }
  }

  void bulkDelete(List<String> keys) {
    for (var key in keys) {
      delete(key);
    }
  }
}

void main() {
  var dictionary = Dictionary();

  dictionary.add("김치", "한국 음식");
  dictionary.showAll();

  // Count
  print(dictionary.count());

  // Update
  dictionary.update("김치", "밋있는 한국 음식!!!");
  print(dictionary.get("김치"));

  // Delete
  dictionary.delete("김치");
  print(dictionary.count());

  // Upsert
  dictionary.upsert("김치", "밋있는 한국 음식!!!");
  print(dictionary.get("김치"));
  dictionary.upsert("김치", "진짜 밋있는 한국 음식!!!");
  print(dictionary.get("김치"));

  // Exists
  print(dictionary.exists("김치"));

  // Bulk Add
  dictionary.bulkAdd([
    {"term": "A", "definition": "B"},
    {"term": "X", "definition": "Y"}
  ]);
  dictionary.showAll();

  // Bulk Delete
  dictionary.bulkDelete(["A", "X"]);
  dictionary.showAll();
}
