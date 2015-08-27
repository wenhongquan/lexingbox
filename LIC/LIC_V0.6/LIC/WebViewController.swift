//
//  WebViewController.swift
//  LIC
//
//  Created by 温红权 on 15/3/30.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation
import WebKit


var myContext = 0

class WebViewController:BaseController,BackButtonHandlerProtocol,UIGestureRecognizerDelegate,WKNavigationDelegate,WKUIDelegate{
    
    var titles:String! = ""
    
    var url:String!=""
    weak var webView: WKWebView!
   

    weak var progressView: WebViewProgressView?
    
  
      deinit {
        self.webView?.removeObserver(self, forKeyPath: "loading")
        self.webView?.removeObserver(self, forKeyPath: "title")
        self.webView?.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webView?.removeObserver(self, forKeyPath: "canGoBack")
        self.webView?.removeObserver(self, forKeyPath: "canGoForward")

    }
    
    func navigationShouldPopOnBackButton() -> Bool {
        
        if webView.canGoBack {
            webView.goBack()
            return false
        }
        
         return true
     }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.    }

        initUI();
        
        
        self.navigationItem.leftItemsSupplementBackButton = true
       
        self.navigationController?.interactivePopGestureRecognizer.delegate = nil
 
       
        
    
            let webViewConfiguration = WKWebViewConfiguration()
            
            let webView = WKWebView(frame: self.view.bounds, configuration: webViewConfiguration)
            webView.navigationDelegate = self
            webView.UIDelegate = self
            webView.allowsBackForwardNavigationGestures = true
            webView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
            
            self.view.addSubview(webView)
            
            
            self.webView = webView
            
            
            self.webView.resignFirstResponder()
            self.webView.canBecomeFirstResponder()
            
            
            webView.addObserver(self, forKeyPath: "loading", options: .New, context: &myContext)
            webView.addObserver(self, forKeyPath: "title", options: .New, context: &myContext)
            webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: &myContext)
            webView.addObserver(self, forKeyPath: "canGoBack", options: .New, context: &myContext)
            webView.addObserver(self, forKeyPath: "canGoForward", options: .New, context: &myContext)
            
            
            
            //        self.navigationController?.hidesBarsOnSwipe = true
           

           
     
        
        
        let navigationBarBounds = self.navigationController?.navigationBar.bounds
        let progressView = WebViewProgressView(frame: CGRectMake(0, navigationBarBounds!.size.height + 0, navigationBarBounds!.size.width, 3))
        
        progressView.autoresizingMask = .FlexibleWidth | .FlexibleTopMargin
        
     
            webView.addSubview(progressView)
        
        self.navigationController?.navigationBar.addSubview(progressView)
        self.progressView = progressView
        self.progressView?.setProgress(0, animated: false)
        
        
           NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("loadUrl"), userInfo: nil, repeats: false)
      
        
        
       
        
    
        
    }
    
    
    
    

    
    
    func close(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func loadUrl(){
        
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        
    }
    



    
    override func viewWillDisappear(animated: Bool) {
        
        self.progressView?.frame.size.width = 0.0
    }
    
    func initUI(){
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
    }
    
    
    override func viewDidAppear(animated: Bool) {
     
    }
    
    
    
 
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: (AnyObject!), change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if context != &myContext {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            return
        }
        
        if keyPath == "loading" {
            if let loading = change[NSKeyValueChangeNewKey]?.boolValue {
         
            }
            return
        }
        
        if keyPath == "title" {
            var title = change[NSKeyValueChangeNewKey] as! NSString
            if title.length > 10 {
            
               title = title.substringToIndex(10) + "..."
            }
            self.navigationItem.title = title as String
          
         
            return
        }
        
        if keyPath == "estimatedProgress" {
            if let progress: Float = change[NSKeyValueChangeNewKey]?.floatValue {
                self.progressView?.setProgress(progress, animated: true)
            }
            return
        }
        
        if keyPath == "canGoBack" {
            
//            self.navigationItem.hidesBackButton = true
            return
        }
        
        if keyPath == "canGoForward" {
                        var item1 = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close:")
                        item1.tintColor = UIColor.whiteColor()
                        self.navigationItem.setLeftBarButtonItems([item1], animated: true)
            return
        }
    }

    
    
    
    
     // MARK: - WKNavigationDelegate methods
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        println("webView:\(webView) didStartProvisionalNavigation:\(navigation)")
    }
    
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
//        println("webView:\(webView) didCommitNavigation:\(navigation)")
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
//        println("webView:\(webView) decidePolicyForNavigationAction:\(navigationAction) decisionHandler:\(decisionHandler)")
        
        let url = navigationAction.request.URL
        
        switch navigationAction.navigationType {
        case .LinkActivated:
            if navigationAction.targetFrame == nil {
                self.webView?.loadRequest(navigationAction.request)
            }
        default:
            break
        }
        
        decisionHandler(.Allow)
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse, decisionHandler: ((WKNavigationResponsePolicy) -> Void)) {
        
        decisionHandler(.Allow)
    }
    
    func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge, completionHandler: ((NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void)) {
//        println("webView:\(webView) didReceiveAuthenticationChallenge:\(challenge) completionHandler:\(completionHandler)")
        
        let alertController = UIAlertController(title: "Authentication Required", message: webView.URL?.host, preferredStyle: .Alert)
        weak var usernameTextField: UITextField!
        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "Username"
            usernameTextField = textField
        }
        weak var passwordTextField: UITextField!
        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "Password"
            textField.secureTextEntry = true
            passwordTextField = textField
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            completionHandler(.CancelAuthenticationChallenge, nil)
        }))
        alertController.addAction(UIAlertAction(title: "Log In", style: .Default, handler: { action in
            let credential = NSURLCredential(user: usernameTextField.text, password: passwordTextField.text, persistence: NSURLCredentialPersistence.ForSession)
            completionHandler(.UseCredential, credential)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func webView(webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
//        println("webView:\(webView) didReceiveServerRedirectForProvisionalNavigation:\(navigation)")
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
//        println("webView:\(webView) didFinishNavigation:\(navigation)")
    }
    
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
//        println("webView:\(webView) didFailNavigation:\(navigation) withError:\(error)")
    }
    
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
//        println("webView:\(webView) didFailProvisionalNavigation:\(navigation) withError:\(error)")
    }
    
    // MARK: WKUIDelegate methods
    
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: (() -> Void)) {
//        println("webView:\(webView) runJavaScriptAlertPanelWithMessage:\(message) initiatedByFrame:\(frame) completionHandler:\(completionHandler)")
        
        let alertController = UIAlertController(title: frame.request.URL!.host, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            completionHandler()
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func webView(webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: ((Bool) -> Void)) {
//        println("webView:\(webView) runJavaScriptConfirmPanelWithMessage:\(message) initiatedByFrame:\(frame) completionHandler:\(completionHandler)")
        
        let alertController = UIAlertController(title: frame.request.URL!.host, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            completionHandler(false)
        }))
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            completionHandler(true)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func webView(webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: ((String!) -> Void)) {
//        println("webView:\(webView) runJavaScriptTextInputPanelWithPrompt:\(prompt) defaultText:\(defaultText) initiatedByFrame:\(frame) completionHandler:\(completionHandler)")
        
        let alertController = UIAlertController(title: frame.request.URL!.host, message: prompt, preferredStyle: .Alert)
        weak var alertTextField: UITextField!
        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.text = defaultText
            alertTextField = textField
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            completionHandler(nil)
        }))
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            completionHandler(alertTextField.text)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    
    
}
