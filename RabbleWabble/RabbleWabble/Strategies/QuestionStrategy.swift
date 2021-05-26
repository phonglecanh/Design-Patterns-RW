//
//  QuestionStrategy.swift
//  RabbleWabble
//
//  Created by Lê Cảnh Phong on 25/05/2021.
//

import Foundation

public protocol QuestionStrategy: class {
// 1
  var title: String { get }
// 2
  var correctCount: Int { get }
  var incorrectCount: Int { get }
// 3
  func advanceToNextQuestion() -> Bool
// 4
  func currentQuestion() -> Question
// 5
    func markQuestionCorrect(_ question: Question)
    func markQuestionIncorrect(_ question: Question)
// 6
    func questionIndexTitle() -> String
}
