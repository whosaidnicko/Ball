import Foundation

class InitializeUserValues {
    static let shared = InitializeUserValues()
    let defaults = UserDefaults.standard
    
    func giveInitialValuesForUser() {
        if defaults.value(forKey: Keys.level) == nil {
            defaults.setValue(0, forKey: Keys.level)
        }
        if defaults.value(forKey: Keys.selectedCup) == nil {
            defaults.setValue(0, forKey: Keys.selectedCup)
        }
        if defaults.value(forKey: Keys.selectedBall) == nil {
            defaults.setValue(0, forKey: Keys.selectedBall)
        }
        if defaults.value(forKey: Keys.stars) == nil {
            defaults.setValue([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], forKey: Keys.stars)
        }
    }
}
