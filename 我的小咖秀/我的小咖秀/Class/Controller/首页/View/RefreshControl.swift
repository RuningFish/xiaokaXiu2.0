//
//  RefreshControl.swift
//
//
//  Created by admin on 16/3/18.
//  Copyright © 2016年 admin. All rights reserved.
//

import UIKit

// 刷新的状态
enum RefreshControlStyle : Int{
    
    case Normal       // 默认
    case Pulling      // 松手就可以刷新
    case Refreshing   // 正在刷新
    
}
class RefreshControl: UIControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var refreshState :RefreshControlStyle = .Normal{
        didSet{
            switch refreshState{
                
            case .Pulling: // 松开手进入刷新状态
                message.text = "释放刷新"
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    self.arrowImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                    
                })
                
            case .Normal:
                
                // 1.隐藏指示器
                indicatorView.hidden = true
                // 2. 显示箭头
                arrowImage.hidden = false
                // 3. 设置文字
                message.text = "下拉刷新"
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    self.arrowImage.transform = CGAffineTransformIdentity
                    
                })
                
                if oldValue == .Refreshing{
                    
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        self.scrollView?.contentInset.top -= 35
                    })
                }
                
            case.Refreshing:
                
                // 1.隐藏箭头
                arrowImage.hidden = true
                // 2.显示指示器
                indicatorView.startAnimating()
                // 3.更改文字
                message.text = "正在刷新"
                // 4. 更改位置
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.scrollView?.contentInset.top += 35
                })
                sendActionsForControlEvents(.ValueChanged)

            }
        }
    }
    
    // 结束刷新
    func endRefresh (){
        refreshState = .Normal
      
    }
    
    // 当前控件观察的对象 (一般来说都是父控件)
    weak var scrollView: UIScrollView?

    func setUpUI () {
        
        // 刷新控件的宽高
        // 宽度为父控件的宽度
        let width : CGFloat = UIScreen.mainScreen().bounds.width
        // 高度
        let height : CGFloat = 35
        
        backgroundColor = UIColor.clearColor()
        frame.size = CGSizeMake(width, height)
        frame.origin = CGPointMake(0, -35)
        
        addSubview(arrowImage)
        addSubview(message)
        addSubview(indicatorView)
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 1. 箭头约束
        arrowImage.center.x = self.center.x - 30
        arrowImage.center.y = self.frame.height * 0.5
        
        // 2. 文字约束
        message.center.x = self.center.x + 10
        message.center.y = self.frame.height * 0.5
        message.sizeToFit()
        
        // 3. 加载指示器
        indicatorView.center = arrowImage.center
        
    }
     // 将要移动到某个父控件上的时候,就会调用该方法
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        
        if let scrollView = newSuperview as? UIScrollView {
            // 监听滚动
            // 要监听谁,就用谁去调用 addObserver 的方法 --> 给要监听的对象添加一个观察者
            // 注册观察者
            scrollView.addObserver(self, forKeyPath: "contentOffset", options: [.Old,.New], context: nil)
            self.scrollView = scrollView
            self.frame.size.width = scrollView.frame.width
            
            }
    }
    
    // 监听的方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
       // print("\(change)----------\(scrollView?.contentInset.top)")
       
        let contentInsetTop = scrollView!.contentInset.top
        let contentOffsetY = scrollView!.contentOffset.y
        let contentValue = -contentInsetTop - 35
        
        // 判断状态
        if scrollView!.dragging{ // 一直拖拽
            // 如果 contentOffsetY <= contentValue 说明控件完全显示出来，
            if contentOffsetY <= contentValue && refreshState == .Normal{//
                // 将状态改为Pulling
                refreshState = .Pulling
               // print("松手进入刷新状态")
            }else if contentOffsetY > contentValue && refreshState == .Pulling{//
                
                refreshState = .Normal
                //print("默认状态")
            }
        }else{
                if refreshState == .Pulling {
                    refreshState = .Refreshing
                  //  print("正在刷新")
                    
                 }
    
             }
    }
    
    // 移除观察者,谁注册谁移除的原则
    deinit {
        scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }

    
    // 箭头
    private lazy var arrowImage = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
    // 加载指示器
    private lazy var indicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
    // 提示文字
    private lazy var message :UILabel = {
        
        let label = UILabel()
        label.text = "下拉刷新"
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(11)
        return label
    
    }()

}
