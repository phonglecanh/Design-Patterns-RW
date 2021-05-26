//
//  SequentialQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Lê Cảnh Phong on 25/05/2021.
//

import Foundation

public class SequentialQuestionStrategy: BaseQuestionStrategy {
  public convenience init(
    questionGroupCaretaker: QuestionGroupCaretaker) {
    let questionGroup =
      questionGroupCaretaker.selectedQuestionGroup!
    let questions = questionGroup.questions
    self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
}

