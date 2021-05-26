//
//  SelectQuestionGroupViewController.swift
//  RabbleWabble
//
//  Created by Lê Cảnh Phong on 24/05/2021.
//

import UIKit

public class SelectQuestionGroupViewController: UIViewController
{
// MARK: - Outlets
    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    // MARK: Properties
    private let questionGroupCaretaker = QuestionGroupCaretaker()
    private var questionGroups: [QuestionGroup] {
      return questionGroupCaretaker.questionGroups
    }
    private var selectedQuestionGroup: QuestionGroup! {
      get { return questionGroupCaretaker.selectedQuestionGroup }
      set { questionGroupCaretaker.selectedQuestionGroup =
    newValue
      }
    }
    
    private let appSettings = AppSettings.shared
}

// MARK: - UITableViewDataSource
extension SelectQuestionGroupViewController:
UITableViewDataSource {
  public func tableView(_ tableView: UITableView,
                        numberOfRowsInSection section: Int)
                        -> Int {
    return questionGroups.count
}
  public func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath)
                        -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
       withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
     let questionGroup = questionGroups[indexPath.row]
     cell.titleLabel.text = questionGroup.title
    cell.percentageSubscriber =
      questionGroup.score.$runningPercentage // 1
        .receive(on: DispatchQueue.main) // 2
        .map() { // 3
          return String(format: "%.0f %%", round(100 * $0))
      }.assign(to: \.text, on: cell.percentageLabel) // 4
     return cell
  }
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
      super.viewDidLoad()
      questionGroups.forEach {
        print("\($0.title): " +
          "correctCount \($0.score.correctCount), " +
          "incorrectCount \($0.score.incorrectCount)"
        )
      }
        
    }
}


// MARK: - UITableViewDelegate
extension SelectQuestionGroupViewController: UITableViewDelegate
{
// 1
  public func tableView(_ tableView: UITableView,
                        willSelectRowAt indexPath: IndexPath)
                        -> IndexPath? {
    selectedQuestionGroup = questionGroups[indexPath.row]
    return indexPath
  }
  // 2
    public func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  // 3
    
    public override func prepare(
      for segue: UIStoryboardSegue, sender: Any?) {
      // 1
      if let viewController =
        segue.destination as? QuestionViewController {
        viewController.questionStrategy =
          appSettings.questionStrategy(for: questionGroupCaretaker)
        viewController.delegate = self
    // 2
      } else if let navController =
          segue.destination as? UINavigationController,
        let viewController =
          navController.topViewController as?
    CreateQuestionGroupViewController {
        viewController.delegate = self
      }
    // 3
      // Whatevs... skip anything else
    }
    
  }

// MARK: - QuestionViewControllerDelegate
extension SelectQuestionGroupViewController:
QuestionViewControllerDelegate {
    
  public func questionViewController(
    _ viewController: QuestionViewController,
    didCancel questionGroup: QuestionStrategy) {
    navigationController?.popToViewController(self,
                                              animated: true)
}
  public func questionViewController(
    _ viewController: QuestionViewController,
    didComplete questionGroup: QuestionStrategy) {
    navigationController?.popToViewController(self,
                                              animated: true)
  }
}

// MARK: - CreateQuestionGroupViewControllerDelegate
extension SelectQuestionGroupViewController:
CreateQuestionGroupViewControllerDelegate {
  public func createQuestionGroupViewControllerDidCancel(
    _ viewController: CreateQuestionGroupViewController) {
    dismiss(animated: true, completion: nil)
  }
  public func createQuestionGroupViewController(
    _ viewController: CreateQuestionGroupViewController,
    created questionGroup: QuestionGroup) {
    questionGroupCaretaker.questionGroups.append(questionGroup)
    try? questionGroupCaretaker.save()
     dismiss(animated: true, completion: nil)
     tableView.reloadData()
   }
 }
