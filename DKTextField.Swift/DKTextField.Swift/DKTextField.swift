//
//  DKTextField.swift
//  DKTextField.Swift
//
//  Created by feiin on 14/11/2.
//  Copyright (c) 2014 year swiftmi. All rights reserved.
//

import UIKit

class DKTextField: UITextField {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.awakeFromNib()

    }
    
  
    
    private var password:String = ""
    
    private var beginEditingObserver:AnyObject!
    
    private var endEditingObserver:AnyObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      //  unowned var that=self
        
        self.beginEditingObserver = NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidBeginEditingNotification, object: nil, queue: nil, usingBlock: {
            [unowned self](note:NSNotification!) in
            
            if self == note.object as DKTextField && self.secureTextEntry {
                self.text = ""
                self.insertText(self.password)
            }
            
            
        })
        
        self.endEditingObserver = NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidEndEditingNotification, object: nil, queue: nil, usingBlock: {
            [unowned self](note:NSNotification!) in
            
            if self == note.object as DKTextField {
            
                self.password = self.text
                
            }
            
            
        })

        
    }
    
    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self.beginEditingObserver)
        NSNotificationCenter.defaultCenter().removeObserver(self.endEditingObserver)
    }
  
    override var secureTextEntry: Bool{
        get {
            return super.secureTextEntry
        }
        set{
            self.resignFirstResponder()
            super.secureTextEntry = newValue
            self.becomeFirstResponder()
        }
    }

  
 

}
