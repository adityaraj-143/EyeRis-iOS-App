//
//  ChatBotViewController.swift
//  EyeRis
//
//  Created by SDC-USER on 28/11/25.
//

import UIKit

class ChatBotViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var GreetText: UILabel!
    
    @IBOutlet weak var ChatBotIcon: UIImageView!
    
    
    @IBOutlet weak var InputBarBottom: NSLayoutConstraint!
        
    
    @IBOutlet weak var TextField: UITextField!
    override func viewDidLoad() {
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
        view.addGestureRecognizer(tapGesture)

        
        super.viewDidLoad()
        
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

    @IBAction func FAQ1(_ sender: UIButton) {
        
    }
    
    @IBAction func FAQ2(_ sender: UIButton) {
    }
    
    @IBAction func FAQ3(_ sender: UIButton) {
    }
   
     @IBAction func MessageButton(_ sender: UIButton) {
         sendMessage()
     }
    
     @IBAction func FAQ4(_ sender: Any) {
     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
        
    }
    
    func sendMessage() {
        guard let text = TextField.text, !text.isEmpty else { return }
        
        print("User sent: \(text)")   // Later We need to send ts to our actual AI model
        TextField.text = ""           // Clear after sending
    }
    
    //we are fucking done with this.
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
