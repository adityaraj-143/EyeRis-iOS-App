//
//  ChatBotViewController.swift
//  EyeRis
//
//  Created by SDC-USER on 28/11/25.
//

import UIKit

class ChatbotViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var GreetText: UILabel!
    

    
    @IBOutlet weak var ChatBotIcon: UIImageView!
    
    
    @IBOutlet weak var InputBarBottom: NSLayoutConstraint!
        
    
    @IBOutlet weak var TextField: UITextField!
    
    
    
    var messages: [String] = []
    var isFAQSelection = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
               TextField.borderStyle = .none
               TextField.backgroundColor = .white
               TextField.layer.borderWidth = 1
               TextField.layer.borderColor = UIColor.systemGray4.cgColor
               TextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
               TextField.leftViewMode = .always

               // Text field delegate + keyboard return
               TextField.delegate = self
               TextField.returnKeyType = .send
      
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)

        
        
        
        TextField.delegate = self   // Imp
        TextField.returnKeyType = .send
        
        
        NotificationCenter.default.addObserver(
               self,
               selector: #selector(keyboardWillShow),
               name: UIResponder.keyboardWillShowNotification,
               object: nil
           )
           
           NotificationCenter.default.addObserver(
               self,
               selector: #selector(keyboardWillHide),
               name: UIResponder.keyboardWillHideNotification,
               object: nil
           )
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         TextField.layer.cornerRadius = TextField.frame.height / 2
         TextField.layer.masksToBounds = true
     }

     deinit {
         NotificationCenter.default.removeObserver(self)
     }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
    if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
        let height = frame.height
        
        InputBarBottom.constant = -height + view.safeAreaInsets.bottom
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}

    @objc func keyboardWillHide(_ notification: Notification) {
    InputBarBottom.constant = 0
    
    UIView.animate(withDuration: 0.25) {
        self.view.layoutIfNeeded()
    }
}
    @IBAction func FAQTapped(_ sender: UIButton) {
        view.endEditing(true)

            isFAQSelection = true
            TextField.backgroundColor = .systemYellow
            TextField.text = sender.title(for: .normal)
           // sendMessage()   // ✅ call ONCE, after text is set
        }

   
     @IBAction func MessageButton(_ sender: UIButton) {
         sendMessage()
     }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
        
    }
    
    func sendMessage() {
        print("we in here")
        guard let text = TextField.text, !text.isEmpty else { return }

        // ✅ STORE message first
        messages.append(text)
        print("📦 Stored message:", text)

        if isFAQSelection {
            isFAQSelection = false
            return   // ❌ do NOT clear text (your original logic)
        }

        // ✅ Clear AFTER storing
        TextField.text = ""
    }

    
    //we are fucking done with this.
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
