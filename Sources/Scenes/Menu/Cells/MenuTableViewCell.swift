//
//  MenuTableViewCell.swift
//  MyApp
//
//  Created by Manh Pham on 3/16/20.
//

import UIKit

final class MenuTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var subDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(title: String?, subtitle: String?, subDescription: String?) {
        self.titleLabel.text = title
        self.subTitle.text = subtitle
        self.subDescription.text = subDescription
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
