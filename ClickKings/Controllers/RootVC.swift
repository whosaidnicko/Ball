import UIKit

class RootVC: UIViewController {
    @IBOutlet weak var completedLevelsLabel: UILabel!
    var level = UserData.shared.getLevel()
    let main = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        level = UserData.shared.getLevel()
        completedLevelsLabel.text = "\(level) 级完成"
    }

    @IBAction func settingsClicked(_ sender: UIButton) {
        if let settingsVC = main.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController {
            navigationController?.pushViewController(settingsVC, animated: true)
        }
    }
    
    @IBAction func startGotClicked(_ sender: UIButton) {
        if let levelVC = main.instantiateViewController(withIdentifier: "LevelSelectionVC") as? LevelSelectionVC {
            navigationController?.pushViewController(levelVC, animated: true)
        }
    }
}

