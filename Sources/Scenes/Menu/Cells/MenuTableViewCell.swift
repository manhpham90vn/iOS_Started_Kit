//
//  MenuTableViewCell.swift
//  MyApp
//
//  Created by Manh Pham on 3/16/20.
//

import UIKit

final class MenuTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(title: String?, price: Double?) {
        titleLabel.text = title
        priceLabel.text = String(price ?? 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
