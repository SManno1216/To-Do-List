//
//  ToDoCell.swift
//  ListProject_Manno
//
//  Created by Steven  Manno on 11/20/21.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: ToDoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization Code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //Configure the view for the selected state
    }
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.checkmarkTapped(sender: self)
    }
}
