//
//  RandomQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Lê Cảnh Phong on 25/05/2021.
//

import Foundation
import GameplayKit.GKRandomSource

public class RandomQuestionStrategy: BaseQuestionStrategy {
  public convenience init(
    questionGroupCaretaker: QuestionGroupCaretaker) {
    let questionGroup =
      questionGroupCaretaker.selectedQuestionGroup!
    let randomSource = GKRandomSource.sharedRandom()
    let questions = randomSource.arrayByShufflingObjects(
        in: questionGroup.questions) as! [Question]
      self.init(questionGroupCaretaker: questionGroupCaretaker,
                questions: questions)
  }
}
