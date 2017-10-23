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
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        selfWidth = Float(frame.size.width);
        selfHeight = Float(frame.size.height);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
        fatalError("init(coder:) has not been implemented")
    }

    // 重新根据数据刷新列表
    public func reloadData(){
        
        let count = dataSource?.banksCardView(view: self, numberOfRows: 0);
        guard count!>0 else {
            return
        }
        
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
        
        scrollView = UIScrollView.init(frame: self.bounds)
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


