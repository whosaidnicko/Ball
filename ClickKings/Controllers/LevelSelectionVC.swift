import UIKit

class LevelSelectionVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    @IBAction func returnToRootTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
extension LevelSelectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "levelCell", for: indexPath) as! LevelCell
        let level = UserData.shared.getLevel()
        let stars = UserData.shared.getValue(forKey: Keys.stars) as! [Int]
        let isEnabled = (level >= indexPath.row)
        cell.setupUI(starsNumber: stars[indexPath.row], isEnabled: isEnabled, level: indexPath.row + 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let level = UserData.shared.getLevel()
        if level >= indexPath.row {
            if let pushToGame = storyboard?.instantiateViewController(withIdentifier: "GameVC") as? GameVC {
                pushToGame.lvlNumber = indexPath.row
                navigationController?.pushViewController(pushToGame, animated: true)
            }
        }
    }
}
