//
//  QuestionGroupCellTableViewCell.swift
//  RabbleWabble
//
//  Created by Lê Cảnh Phong on 24/05/2021.
//

import UIKit
import Combine

public class QuestionGroupCell: UITableViewCell {

    @IBOutlet public var titleLabel: UILabel!
    @IBOutlet public var percentageLabel: UILabel!
    public var percentageSubscriber: AnyCancellable?
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
