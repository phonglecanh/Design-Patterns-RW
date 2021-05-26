//
//  QuestionGroup.swift
//  RabbleWabble
//
//  Created by Lê Cảnh Phong on 24/05/2021.
//

import Foundation



public class QuestionGroup: Codable {
    public let questions: [Question]
    public var score: Score
    public let title: String
    
    public init(questions: [Question],
                score: Score = Score(),
                title: String) {
      self.questions = questions
      self.score = score
      self.title = title
    }
    
    public class Score: Codable {
        public var correctCount: Int = 0
        public var incorrectCount: Int = 0
        public init() { }
    }
}

