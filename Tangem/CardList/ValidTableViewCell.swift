//
//  ValidTableViewCell.swift
//  Tangem
//
//  Created by Yulia Moskaleva on 01/02/2018.
//  Copyright © 2018 Yulia Moskaleva. All rights reserved.
//

import UIKit

class ValidTableViewCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var cardIDLabel: UILabel!
    @IBOutlet weak var blockchainLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var walletValue: UILabel!
    @IBOutlet weak var usdWallet: UILabel!
    
    @IBOutlet weak var logoIcon: UIImageView!
    var link = ""
    
    @IBAction func linkButton(_ sender: Any) {
        if let url = URL(string: self.link){
            UIApplication.shared.open(url,options: [:])
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.shadowColor = UIColor.darkGray.cgColor
        backView.layer.shadowOpacity = 0.9
        backView.layer.shadowOffset = CGSize.zero
        backView.layer.shadowRadius = 5
        //backView.layer.shouldRasterize = true
        backView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
