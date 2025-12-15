//
//  Chart1ViewController.swift
//  EyeRis
//
//  Created by SDC-USER on 15/12/25.
//
import Speech
import UIKit

class Chart1ViewController: UIViewController {
    
    
    @IBOutlet weak var RecordingStatus: UILabel!
    @IBOutlet weak var SnellenImg: UIImageView!
    @IBOutlet weak var Letter1: UILabel!
    @IBOutlet weak var TextField: UITextField!
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    var Recording = false
    
    override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         TextField.layer.cornerRadius = TextField.frame.height / 2
         TextField.layer.masksToBounds = true
     }
    
    override func viewDidLoad() {
        
        
     
        super.viewDidLoad()
        
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
        

        TextField.borderStyle = .none
        TextField.backgroundColor = .white
        TextField.layer.borderWidth = 1
        TextField.layer.borderColor = UIColor.systemGray4.cgColor
        TextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        TextField.leftViewMode = .always

        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                if status != .authorized {
                    print("Speech recognition not authorized")
                }
            }
        }
    }
    func startListening() {
        recognitionTask?.cancel()
        recognitionTask = nil
        
        Recording = true
        
        DispatchQueue.main.async {
            self.RecordingStatus.text = "Recording Audio"
            self.RecordingStatus.textColor = .systemGreen
        }
        
        print("recording started")
        
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else { return }
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                let spokenText = result.bestTranscription.formattedString
                let normalized = spokenText
                    .uppercased()
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                DispatchQueue.main.async {
                    
                    print("🎙️ Final text:", spokenText)
                    self.TextField.text = spokenText
                    if normalized == "NEXT" {
                        print("text detected")
//                        let sb = UIStoryboard(name: "Chart2", bundle: nil)
//                        if let vc = sb.instantiateViewController(
//                            withIdentifier: "Chart2ViewController"
//                        ) as? Chart2ViewController {
//
//                            self.navigationController?.pushViewController(vc, animated: true)
//                        }
                    }
                }
            }
        

            if error != nil || (result?.isFinal ?? false) {
                self.stopListening()
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            buffer, _ in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        try? audioEngine.start()
    }
    func stopListening() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        audioEngine.inputNode.removeTap(onBus: 0)

        Recording = false

        DispatchQueue.main.async {
            self.RecordingStatus.text = "Not Recording"
            self.RecordingStatus.textColor = .systemGray
        }
    }

    @objc func dismissKeyboard() {
    view.endEditing(true)
}

    @IBAction func NextBtn(_ sender: UIButton) {
        
        //i wanna store the text in the textfield somewhere and move to the nect screen
//        let sb = UIStoryboard(name: "Chart2", bundle: nil)
//        if let vc = sb.instantiateViewController(
//            withIdentifier: "Chart2ViewController"
//        ) as? Chart2ViewController {
//
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    @IBAction func MicBtn(_ sender: UIButton) {
        print("button Pressed")
        if audioEngine.isRunning {
                stopListening()
            } else {
                startListening()
            }
        }
    }
