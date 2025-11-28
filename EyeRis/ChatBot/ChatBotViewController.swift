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
    
    @IBOutlet weak var TextField: UITextField!
    
    @IBOutlet weak var InputBarBottomConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
    if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
        let height = frame.height
        
        InputBarBottomConstraint.constant = -height + view.safeAreaInsets.bottom
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}

    @objc func keyboardWillHide(_ notification: Notification) {
    InputBarBottomConstraint.constant = 0
    
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
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
