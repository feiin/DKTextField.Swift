//
//  DKTextField.swift
//  DKTextField.Swift
//
//  Created by feiin on 14/11/2.
//  Copyright (c) 2014 year swiftmi. All rights reserved.
//

import UIKit

class DKTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.awakeFromNib()

    }
    
  
    
    fileprivate var password:String = ""
    
    fileprivate var beginEditingObserver:AnyObject!
    
    fileprivate var endEditingObserver:AnyObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      //  unowned var that=self
        
        self.beginEditingObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil, queue: nil, using: {
            [unowned self](note:Notification!) in
            
            if self == note.object as! DKTextField && self.isSecureTextEntry {
                self.text = ""
                self.insertText(self.password)
            }
            
            
        })
        
        self.endEditingObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidEndEditing, object: nil, queue: nil, using: {
            [unowned self](note:Notification!) in
            
            if self == note.object as! DKTextField {
            
                self.password = self.text!
                
            }
            
            
        })

        
    }
    
    deinit{
        
        NotificationCenter.default.removeObserver(self.beginEditingObserver)
        NotificationCenter.default.removeObserver(self.endEditingObserver)
    }
  
    override var isSecureTextEntry: Bool{
        get {
            return super.isSecureTextEntry
        }
        set{
            self.resignFirstResponder()
            super.isSecureTextEntry = newValue
            self.becomeFirstResponder()
        }
    }

  
 

}
