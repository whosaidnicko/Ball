import Foundation

class UserData {
    static let shared = UserData()
    let defaults = UserDefaults.standard

    func getLevel() -> Int {
        return defaults.value(forKey: Keys.level) as! Int
    }
    func setLevel(to level: Int) {
        defaults.setValue(level, forKey: Keys.level)
    }
    func getValue(forKey: String) -> Any {
        return defaults.value(forKey: forKey) as Any
    }
    func setValue(forKey: String, value: Any) {
        defaults.setValue(value, forKey: forKey)
    }
}
