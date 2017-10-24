//
//  ViewController.swift
//  DLBankListDemo
//
//  Created by meitianhui2 on 2017/10/23.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,AATBanksCardViewDataSource,AATBanksCardViewDelegate {

    var cardListArray = [(AATBankCardModel)]()
    var cardsView:AATBanksCardView = AATBanksCardView()
    
    //  screen size
    let kScreenWidth = UIScreen.main.bounds.width
    let kScreenHeight = UIScreen.main.bounds.height
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initDataSourece()
        setUpStackCardView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initDataSourece(){
        for index in 1..<10{
            let cardModel:AATBankCardModel = AATBankCardModel()
            switch index{
            case 1: cardModel.BankName = "招商银行"
            case 2: cardModel.BankName = "建设银行"
            case 3: cardModel.BankName = "农业银行"
            case 4: cardModel.BankName = "工商银行"
            case 5: cardModel.BankName = "北京银行"
            case 6: cardModel.BankName = "渤海银行"
            case 7: cardModel.BankName = "浦发银行"
            case 8: cardModel.BankName = "兴业银行"
            case 9: cardModel.BankName = "深圳发展银行"
            default:cardModel.BankName = "人民银行"
            }
            cardListArray.append(cardModel)
        }
    }
    
    private func setUpStackCardView(){
        
        cardsView = AATBanksCardView.init(frame: CGRect(x: 15, y: 74, width: kScreenWidth-30, height: kScreenHeight-84));
        cardsView.dataSource = self
        cardsView.delegate = self
        cardsView.backgroundColor = UIColor.lightGray;
        cardsView.reloadData()
//        cardsView.isHidden = true
        //        cardsView.hideInController()  // 默认是隐藏 的
        view.addSubview(cardsView);
    }
    
    
    // MARK
    func banksCardView(view: AATBanksCardView, numberOfRows: Int) -> Int {
        return  cardListArray.count;
    }
    
    func banksCardView(view: AATBanksCardView, viewForRowAtIndex: Int) -> UIView {
        
        let cardView = UINib(nibName: "AATBankCard", bundle: Bundle.main).instantiate(withOwner: nil, options: nil).first as! AATBankCard
        cardView.frame = CGRect(x: 0, y: 0, width: 360, height: 120)
        //        cardView.backgroundColor = AATCommonBgColor;
        let mode:AATBankCardModel = cardListArray[viewForRowAtIndex]
        cardView.model = mode;
        
        //
        
        return cardView
        
    }
    
    func banksCardView(view: AATBanksCardView, heightForRowAtIndex: Int) -> Float {
        return 120
    }
    
    func banksCardView(view: AATBanksCardView, heightForHeadViewAtIndex: Int) -> Float {
        return 100
    }
    
    // MARK  --- banksCardView 代理  点击 某个 卡片
    func banksCardView(view: AATBanksCardView, didSelectViewAtIndex: Int) {
        print("\(didSelectViewAtIndex)  ===")
        
        
    }
}

