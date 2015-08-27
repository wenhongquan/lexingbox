//
//  UIWebViewExtController.swift
//  LIC
//
//  Created by 温红权 on 15/5/12.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class UIWebViewExtController: BaseController,UIGestureRecognizerDelegate,BackButtonHandlerProtocol,UIWebViewDelegate,NJKWebViewProgressDelegate {
    
    @IBOutlet weak var webview: UIWebView!
    
    var _progressView:WebViewProgressView!
    var _progressProxy:NJKWebViewProgress!
    
    
    var titles:String! = ""
    
    var url:String!=""
    
    
    func navigationShouldPopOnBackButton() -> Bool {
        
        if webview.canGoBack {
            
            var item1 = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close:")
            item1.tintColor = UIColor.whiteColor()
            self.navigationItem.setLeftBarButtonItems([item1], animated: true)
            
            webview.goBack()
            return false
        }
        
        return true
    }

    override func viewDidDisappear(animated: Bool){
        super.viewDidDisappear(animated)
        _progressView.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        initUI();
        
        _progressProxy = NJKWebViewProgress.alloc()
        webview.delegate = _progressProxy;
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
        
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeRightAction")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right;
        swipeRight.delegate = self;
        webview.addGestureRecognizer(swipeRight)

        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipeLeftAction")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left;
        swipeLeft.delegate = self;
        webview.addGestureRecognizer(swipeLeft)
        
        
        let navigationBarBounds = self.navigationController?.navigationBar.bounds
         _progressView = WebViewProgressView(frame: CGRectMake(0, navigationBarBounds!.size.height + 0, navigationBarBounds!.size.width, 3))
        
        _progressView.autoresizingMask = .FlexibleWidth | .FlexibleTopMargin
        
        
        self.navigationController?.navigationBar.addSubview(_progressView)
    
        self._progressView?.setProgress(0, animated: false)

         NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("loadUrl"), userInfo: nil, repeats: false)
    }
    
    
    
    
    
    func webViewProgress(webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
         self._progressView?.setProgress(progress, animated: true)
        
    }
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
    func swipeRightAction()
    {
    
        if webview.canGoBack {
            
            var item1 = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close:")
            item1.tintColor = UIColor.whiteColor()
            self.navigationItem.setLeftBarButtonItems([item1], animated: true)
            
            webview.goBack()

        }
        
  

    }
    
    func swipeLeftAction()
    {
        if webview.canGoForward {
            
          webview.goForward()
      
        }
        
   
        
    }
    
    func close(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    
    func webViewDidFinishLoad(webView: UIWebView) {
    
            
            var string = webview.stringByEvaluatingJavaScriptFromString("document.title")
            if(string != nil){
                var title = string! as NSString
                
                if title.length > 10 {
                    
                    title = title.substringToIndex(10) + "..."
                }
                self.navigationItem.title = title as String
                
            }else{
                self.navigationItem.title = titles
            }
            
        

    }
    
    func loadUrl(){
        
        webview.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        
    }
    
 
    func initUI(){
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationController?.interactivePopGestureRecognizer.delegate = nil
    }
    



}