import 'package:seriousfocus/bloc/learning_category_model.dart';
import 'package:seriousfocus/bloc/learning_flashcard_model.dart';

class CachingService {
  static int? _learningCacheLimit;
  static List<LearningCategoryModel>? cachedLearningCategories;
  static Map<String, List<LearningFlashcardModel>>? _cachedLearningFlashcards;

  //Methods
  //General
  ///Initializes the Cache. Must be called in main() Method!
  static void initializeSfCache({required int learningCacheLimit,}){
    _learningCacheLimit = learningCacheLimit;
    cachedLearningCategories = <LearningCategoryModel>[];
    _cachedLearningFlashcards = <String, List<LearningFlashcardModel>>{};
  }

  //-------------------------------------------------------------------

  //Learning Cache Section
  static bool cachedFlashcardsContains(String key){
    return _cachedLearningFlashcards!.containsKey(key);
  }

  static void removeFlashcardsFromCache(String key){
    _cachedLearningFlashcards!.remove(key);
  }

  static List<LearningFlashcardModel> getFlashcardListWithKey(String key){
    return _cachedLearningFlashcards![key]!;
  }

  ///Caches a LearningFlashcardList, if Cache is full, the first Cached Element will be removed and the new List will be pushed on the Map-Stack
  static void addLearningFlashcardList(String key, List<LearningFlashcardModel> flashcards){
    if (_cachedLearningFlashcards!.length < _learningCacheLimit! && !_cachedLearningFlashcards!.containsKey(key)) {
      _cachedLearningFlashcards![key] = flashcards;
    } 
    else if(_cachedLearningFlashcards!.length > _learningCacheLimit! && !_cachedLearningFlashcards!.containsKey(key)){
      //Remove one Entry from Cache
      _cachedLearningFlashcards!.remove(_cachedLearningFlashcards!.keys.first);
      _cachedLearningFlashcards![key] = flashcards;
    }
    else{
      return;
    }
  }
}