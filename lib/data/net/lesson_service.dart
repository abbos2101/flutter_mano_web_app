import 'utils/lesson_service_lesson_imp.dart';
import 'utils/lesson_service_word_imp.dart';
import 'utils/lesson_service_rule_imp.dart';
import 'utils/lesson_service_exercise_imp.dart';

export '../../data/model/response.dart';

class LessonService
    with
        LessonLessonServiceImp,
        LessonWordServiceImp,
        LessonRuleImp,
        LessonExerciseImp {}
