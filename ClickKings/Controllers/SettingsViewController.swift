import UIKit
import StoreKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var ballImage: UIImageView!
    @IBOutlet weak var cupImage: UIImageView!
    
    var ballIndex = UserData.shared.getValue(forKey: Keys.selectedBall) as! Int
    var cupIndex = UserData.shared.getValue(forKey: Keys.selectedCup) as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ballImage.image = UIImage(named: "ball\(ballIndex)")
        cupImage.image = UIImage(named: "cup\(cupIndex)")
    }
    
    @IBAction func returnToRootGotTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func prevBallGotTapped(_ sender: UIButton) {
        if ballIndex > 0 {
            ballIndex -= 1
            UserData.shared.setValue(forKey: Keys.selectedBall, value: ballIndex)
            ballImage.image = UIImage(named: "ball\(ballIndex)")
        }
    }
    
    @IBAction func nextBallGotTapped(_ sender: UIButton) {
        if ballIndex < 6 {
            ballIndex += 1
            UserData.shared.setValue(forKey: Keys.selectedBall, value: ballIndex)
            ballImage.image = UIImage(named: "ball\(ballIndex)")
        }
    }
    
    @IBAction func preCupButton(_ sender: UIButton) {
        if cupIndex > 0 {
            cupIndex -= 1
            UserData.shared.setValue(forKey: Keys.selectedCup, value: cupIndex)
            cupImage.image = UIImage(named: "cup\(cupIndex)")
        }
    }
    
    @IBAction func nextCupButton(_ sender: UIButton) {
        if cupIndex < 7 {
            cupIndex += 1
            UserData.shared.setValue(forKey: Keys.selectedCup, value: cupIndex)
            cupImage.image = UIImage(named: "cup\(cupIndex)")
        }
    }
    
    @IBAction func firstSettingsButton(_ sender: UIButton) {
        if let scene = view.window?.windowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    @IBAction func secondSettingsButton(_ sender: UIButton) {
        ballIndex = 0
        cupIndex = 0
        UserData.shared.setValue(forKey: Keys.selectedBall, value: 0)
        ballImage.image = UIImage(named: "ball0")
        UserData.shared.setValue(forKey: Keys.selectedCup, value: 0)
        cupImage.image = UIImage(named: "cup0")
        UserData.shared.setLevel(to: 0)
        UserData.shared.setValue(forKey: Keys.stars, value: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    }
    
    @IBAction func thirdSettingsButton(_ sender: UIButton) {
        if let privacyVC = storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as? PrivacyPolicyVC {
            privacyVC.modalPresentationStyle = .overFullScreen
            present(privacyVC, animated: true)
        }
    }
}
