import UIKit
import SnapKit

class LevelCell: UICollectionViewCell {
    @IBOutlet weak var levelImage: UIImageView!
    @IBOutlet var starButtons: [UIImageView]!
    @IBOutlet weak var levelLabel: UILabel!
    
    
    func setupUI(starsNumber: Int?, isEnabled: Bool, level: Int) {
        levelImage.snp.makeConstraints { make in
            make.width.height.equalTo((UIScreen.main.bounds.width - 105) / 3)
        }
        
        levelLabel.text = "\(level)"
        if isEnabled {
            levelImage.image = UIImage(resource: .enabledButton)
            if let starsNumber = starsNumber {
                setupStarsByStarNumber(starNumber: starsNumber)
            }
        } else {
            levelImage.image = UIImage(resource: .disabledButton)
            setupStarsByStarNumber(starNumber: 0)
        }
        
    }
    
    func setupStarsByStarNumber(starNumber: Int) {
        for starBtn in starButtons {
            if starBtn.tag < starNumber {
                starBtn.image = UIImage(resource: .enabledStar)
            } else {
                starBtn.image = UIImage(resource: .disabledStar)
            }
        }
    }
}
