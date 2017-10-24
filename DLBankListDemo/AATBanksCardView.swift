//
//  AATBanksCardView.swift
//  swiftProj
//
//  Created by DeLongYang on 2017/7/17.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

import UIKit


open class AATBanksCardView: UIView {
    
    weak var dataSource:AATBanksCardViewDataSource?
    weak var delegate:AATBanksCardViewDelegate?
    
    var scrollView:UIScrollView?
    var selfWidth:Float = 0.00;
    var selfHeight:Float = 0.00;
    
    let animationTime:CGFloat = 0.5
    var buttonCount:Int = 0
    var arrHeight:NSMutableArray = NSMutableArray()
    var isSelectedButton:Bool = false   // is the button selected or not 选中状态下 不允许 scrollView 滚动
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        selfWidth = Float(frame.size.width);
        selfHeight = Float(frame.size.height);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
        fatalError("init(coder:) has not been implemented")
    }

    private func stringToFloat(str:String) ->(CGFloat){
        let string = str  // 注意这里为什么要用 let 来修饰 str
        var cgFloat:CGFloat = 0
        
        if let doubleValue = Double(string)
        {
            cgFloat = CGFloat (doubleValue)
        }
        
        return cgFloat
    }
    
    private func stringToInt(str:String) -> (Int){
        let string = str
        var int:Int?
        if let doubleValue = Double(string)
        {
            int = Int(doubleValue)
        }
        
        if  int == nil {
            return 0
        }
        return int!
    }
    
    // 重新根据数据刷新列表
    public func reloadData(){
        
        let count = dataSource?.banksCardView(view: self, numberOfRows: 0);
        guard count!>0 else {
            return
        }
        
        buttonCount = count!
        
        var contentHeight:CGFloat = 0.00;
        
        if (scrollView != nil) {
            
            scrollView!.removeFromSuperview()
            scrollView = nil
        }
        
        scrollView = UIScrollView.init(frame: self.bounds)
        scrollView?.backgroundColor = UIColor.clear;
        scrollView?.contentSize = CGSize(width: Double(selfWidth), height: Double(50*count!))
        self.addSubview(scrollView!)
        
        
        for index in 0 ..< count! {
            
            
            let card:AATBankCard = dataSource?.banksCardView(view: self, viewForRowAtIndex: index) as! AATBankCard;
            card.tag =  1000+index;
            card.ClickBtn.tag = 2000+index
            card.ClickBtn.addTarget(self, action:#selector(AATBanksCardView.touchCard(_:)) , for: UIControlEvents.touchUpInside)
            
            let rowHei:CGFloat = CGFloat((self.dataSource?.banksCardView(view: self, heightForRowAtIndex: index))!)
            
            let headHei:CGFloat = CGFloat((self.dataSource?.banksCardView(view: self, heightForHeadViewAtIndex: index))!);
            
            let ide = CGFloat (index)
            
            // add the row string
            let rowHeiString = String.init(format:"%.2f",rowHei)
            arrHeight.add(rowHeiString)
            
            card.frame = CGRect(x: CGFloat(0.00), y: headHei*ide, width: CGFloat(selfWidth), height: rowHei)
            scrollView?.addSubview(card)
            
        
            if index < count!-1 {
                contentHeight += headHei
                
            }else{
                 contentHeight += rowHei
            }
           
        
        }

        
        scrollView?.contentSize =  CGSize(width: Double(selfWidth), height: Double(contentHeight))


    }
    
    // 构建 子视图
    fileprivate func createCard(){
        
        
        let count = dataSource?.banksCardView(view: self, numberOfRows: 0);
        guard count!>0 else {
            return
        }
        
        buttonCount = count!  //
        
        scrollView = UIScrollView(frame: self.bounds)
        scrollView?.backgroundColor = UIColor.clear;
        scrollView?.contentSize = CGSize(width: Double(selfWidth), height: Double(50*count!))
        self.addSubview(scrollView!)
        
        
        for index in 0 ..< count! {
            
            let card:AATBankCard = dataSource?.banksCardView(view: self, viewForRowAtIndex: index) as! AATBankCard;
            card.tag =  1000+index;
            card.ClickBtn.tag = 2000+index
            card.ClickBtn.addTarget(self, action:#selector(AATBanksCardView.touchCard(_:)) , for: UIControlEvents.touchUpInside)
        }
    
    }
    
    @objc func touchCard(_ button:UIButton) {
        let btn:UIButton = button;
        
        delegate?.banksCardView(view: self, didSelectViewAtIndex: btn.tag-2000)
        scrollView?.contentOffset = CGPoint(x: 0, y: 0)
        isSelectedButton = !isSelectedButton
        
//      card.frame = CGRect(x: CGFloat(0.00), y: headHei*ide, width: CGFloat(selfWidth), height: rowHei)
        // 是否选中 某个选项
        if isSelectedButton == true {
            scrollView?.isScrollEnabled = false
            //
            for index in 0..<buttonCount{
                let cardView:AATBankCard = self.viewWithTag(index+1000) as! AATBankCard
                
                let animationRowHeight = stringToFloat(str: arrHeight[index] as! String)
                UIView.animate(withDuration: 0.5, animations: {
                    
                    cardView.frame = CGRect(x: CGFloat(0.00), y: 0, width: CGFloat(self.selfWidth), height: animationRowHeight)
                    
                    if (cardView.tag+1000) > btn.tag{
                        cardView.frame = CGRect(x: CGFloat(0.00), y: CGFloat(self.selfHeight - 20), width: CGFloat(self.selfWidth), height: animationRowHeight)
                    }else{
                        cardView.frame = CGRect(x: CGFloat(0.00), y: 0.0, width: CGFloat(self.selfWidth), height: animationRowHeight)
                    }
                    
                })
            }
            
        }else{
            scrollView?.isScrollEnabled = true
            
            UIView.animate(withDuration: 0.5, animations: {
                for index in 0..<self.buttonCount{
                    let cardView:AATBankCard = self.viewWithTag(index+1000) as! AATBankCard
                    let rowHei:CGFloat = CGFloat((self.dataSource?.banksCardView(view: self, heightForRowAtIndex: index))!)
                    let headHei:CGFloat = CGFloat((self.dataSource?.banksCardView(view: self, heightForHeadViewAtIndex: index))!);
                    let ide = CGFloat (index)
                    cardView.frame = CGRect(x: CGFloat(0.00), y: headHei*ide, width: CGFloat(self.selfWidth), height: rowHei)
                }
            })
           
        }
        
        
    }
}



/// 返回 数据源
public protocol AATBanksCardViewDataSource:NSObjectProtocol{
    
  func banksCardView(view:AATBanksCardView,numberOfRows:Int) -> Int;

  func banksCardView(view:AATBanksCardView,heightForRowAtIndex:Int) -> Float;
    
  func banksCardView(view:AATBanksCardView,heightForHeadViewAtIndex:Int) -> Float;
    
  func banksCardView(view:AATBanksCardView,viewForRowAtIndex:Int) -> UIView;
}


/// 点击 BanksCard 中某个card
public protocol AATBanksCardViewDelegate:NSObjectProtocol {
    
    func banksCardView(view:AATBanksCardView,didSelectViewAtIndex:Int)
}


