//
//  AATBankCard.swift
//  swiftProj
//
//  Created by DeLongYang on 2017/7/17.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

import UIKit

class AATBankCard: UIView {
    
    
    @IBOutlet weak var bankNameLable: UILabel!
    
    
    @IBOutlet weak var bankTypeLable: UILabel!
    
    @IBOutlet weak var bankNumberLable: UILabel!
    

    @IBOutlet weak var ClickBtn: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    var model = AATBankCardModel() {
        didSet {
            
            bankTypeLable.text = "储蓄卡"
            bankNameLable.text = model.BankName
//            bankNumberLable.text = model.BankNo.getHideBankNumber()
        }
    }


}
