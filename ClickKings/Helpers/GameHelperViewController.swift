import UIKit
import SnapKit

extension GameVC {
    func setupFirstLevelComponents() {
        let firstStar = UIImageView(image: UIImage(resource: .enabledStar))
        let secondStar = UIImageView(image: UIImage(resource: .enabledStar))
        let thirdStar = UIImageView(image: UIImage(resource: .enabledStar))
        starImages.append(firstStar)
        starImages.append(secondStar)
        starImages.append(thirdStar)
        cupBaseImage.snp.makeConstraints { make in
            make.width.equalTo(114)
            make.height.equalTo(25)
        }
        initialBallEmbededView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
        
        cupBaseImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        gameView.addSubview(firstStar)
        firstStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.leading.equalTo(initialBallEmbededView.snp.trailing).offset(15)
            make.bottom.equalTo(initialBallEmbededView.snp.top).offset(-30)
        }
        
        gameView.addSubview(secondStar)
        secondStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.leading.equalTo(firstStar.snp.trailing).offset(30)
            make.bottom.equalTo(firstStar.snp.top).offset(-30)
        }
        gameView.addSubview(thirdStar)
        thirdStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(cupBaseImage.snp.centerX)
            make.bottom.equalTo(cupBaseImage.snp.top).offset(-80)
        }
    }
    
    func setupSecondLevelComponents() {
        let firstStar = UIImageView(image: UIImage(resource: .enabledStar))
        let secondStar = UIImageView(image: UIImage(resource: .enabledStar))
        let thirdStar = UIImageView(image: UIImage(resource: .enabledStar))
        
        let firstWallImage = UIImageView(image: UIImage(resource: .wall1))
        let secondWallImage = UIImageView(image: UIImage(resource: .wall1))

        starImages.append(firstStar)
        starImages.append(secondStar)
        starImages.append(thirdStar)
        
        barierImages.append(firstWallImage)
        barierImages.append(secondWallImage)
        
        cupBaseImage.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(78)
        }
        cupBaseImage.image = UIImage(resource: .wall1)
        
        gameView.addSubview(firstStar)
        gameView.addSubview(secondStar)
        gameView.addSubview(thirdStar)
        gameView.addSubview(firstWallImage)
        gameView.addSubview(secondWallImage)
        initialBallEmbededView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(40)
        }
        
        cupBaseImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        firstWallImage.snp.makeConstraints { make in
            make.height.equalTo(78)
            make.width.equalTo(70)
            make.leading.equalTo(initialBallEmbededView.snp.trailing).offset(5)
            make.top.equalTo(initialBallEmbededView.snp.bottom).offset(50)
        }
        firstStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(firstWallImage.snp.centerX)
            make.bottom.equalTo(firstWallImage.snp.top).offset(-10)
        }
        
        secondWallImage.snp.makeConstraints { make in
            make.height.equalTo(78)
            make.width.equalTo(70)
            make.leading.equalTo(firstWallImage.snp.trailing).offset(5)
            make.top.equalTo(firstWallImage.snp.bottom).offset(50)
        }
        secondStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(secondWallImage.snp.centerX)
            make.bottom.equalTo(secondWallImage.snp.top).offset(-10)
        }
        
        thirdStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(cupImage.snp.centerX)
            make.bottom.equalTo(cupImage.snp.top).offset(-10)
        }
    }
    
    func setupThirdLevelComponents() {
        let firstStar = UIImageView(image: UIImage(resource: .enabledStar))
        let secondStar = UIImageView(image: UIImage(resource: .enabledStar))
        let thirdStar = UIImageView(image: UIImage(resource: .enabledStar))
        
        let firstWallImage = UIImageView(image: UIImage(resource: .wall2))
        let secondWallImage = UIImageView(image: UIImage(resource: .wall3))

        starImages.append(firstStar)
        starImages.append(secondStar)
        starImages.append(thirdStar)
        
        barierImages.append(firstWallImage)
        barierImages.append(secondWallImage)
        
        cupBaseImage.snp.makeConstraints { make in
            make.width.equalTo(235)
            make.height.equalTo(28)
        }
        cupBaseImage.image = UIImage(resource: .cupBase1)
        gameView.addSubview(firstStar)
        gameView.addSubview(secondStar)
        gameView.addSubview(thirdStar)
        gameView.addSubview(firstWallImage)
        gameView.addSubview(secondWallImage)
        initialBallEmbededView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(60)
        }
        
        cupBaseImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        firstWallImage.snp.makeConstraints { make in
            make.height.equalTo(114)
            make.width.equalTo(25)
            make.leading.equalTo(initialBallEmbededView.snp.trailing).offset(5)
            make.top.equalTo(initialBallEmbededView.snp.bottom).offset(70)
        }
        firstStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerY.equalTo(firstWallImage.snp.centerY)
            make.leading.equalTo(firstWallImage.snp.trailing).offset(10)
        }
        
        secondWallImage.snp.makeConstraints { make in
            make.height.equalTo(114)
            make.width.equalTo(25)
            make.trailing.equalToSuperview().inset(50)
            make.top.equalTo(initialBallEmbededView.snp.top).offset(70)
        }
        secondStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerY.equalTo(secondWallImage.snp.centerY)
            make.trailing.equalTo(secondWallImage.snp.leading).offset(-10)
        }
        
        thirdStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(cupImage.snp.centerX)
            make.bottom.equalTo(cupImage.snp.top).offset(-10)
        }
    }
    
    func setupFourthLevelComponents() {
        let firstStar = UIImageView(image: UIImage(resource: .enabledStar))
        let secondStar = UIImageView(image: UIImage(resource: .enabledStar))
        let thirdStar = UIImageView(image: UIImage(resource: .enabledStar))
        
        let firstWallImage = UIImageView(image: UIImage(resource: .wall4))
        let secondWallImage = UIImageView(image: UIImage(resource: .wall5))
        let thirdWallImage = UIImageView(image: UIImage(resource: .wall4))

        starImages.append(firstStar)
        starImages.append(secondStar)
        starImages.append(thirdStar)
        
        barierImages.append(firstWallImage)
        barierImages.append(secondWallImage)
        barierImages.append(thirdWallImage)
        
        cupBaseImage.snp.makeConstraints { make in
            make.width.equalTo(114)
            make.height.equalTo(28)
        }
        cupBaseImage.image = UIImage(resource: .cupBase1)
        gameView.addSubview(firstStar)
        gameView.addSubview(secondStar)
        gameView.addSubview(thirdStar)
        gameView.addSubview(firstWallImage)
        gameView.addSubview(secondWallImage)
        gameView.addSubview(thirdWallImage)
        initialBallEmbededView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(70)
        }
        
        cupBaseImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        firstWallImage.snp.makeConstraints { make in
            make.height.equalTo(64)
            make.width.equalTo(71)
            make.leading.equalToSuperview().inset(50)
            make.top.equalTo(initialBallEmbededView.snp.bottom).offset(-40)
        }
        firstStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(firstWallImage.snp.centerX)
            make.bottom.equalTo(firstWallImage.snp.top).offset(10)
        }
        
        secondWallImage.snp.makeConstraints { make in
            make.height.equalTo(64)
            make.width.equalTo(71)
            make.trailing.equalToSuperview().inset(50)
            make.top.equalTo(initialBallEmbededView.snp.bottom).offset(50)
        }
        secondStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(secondWallImage.snp.centerX)
            make.bottom.equalTo(secondWallImage.snp.top).offset(10)
        }
        
        thirdWallImage.snp.makeConstraints { make in
            make.height.equalTo(64)
            make.width.equalTo(71)
            make.centerX.equalTo(firstWallImage.snp.centerX).inset(50)
            make.top.equalTo(firstWallImage.snp.bottom).offset(50)
        }
        
        thirdStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(thirdWallImage.snp.centerX)
            make.bottom.equalTo(thirdWallImage.snp.top).offset(10)
        }
    }
    
    func setupFifthLevelComponents() {
        let firstStar = UIImageView(image: UIImage(resource: .enabledStar))
        let secondStar = UIImageView(image: UIImage(resource: .enabledStar))
        let thirdStar = UIImageView(image: UIImage(resource: .enabledStar))
        
        let firstWallImage = UIImageView(image: UIImage(resource: .wall6))
        let secondWallImage = UIImageView(image: UIImage(resource: .wall7))

        starImages.append(firstStar)
        starImages.append(secondStar)
        starImages.append(thirdStar)
        
        barierImages.append(firstWallImage)
        barierImages.append(secondWallImage)
        
        cupBaseImage.snp.makeConstraints { make in
            make.width.equalTo(114)
            make.height.equalTo(25)
        }
        cupBaseImage.image = UIImage(resource: .cupBase1)
        gameView.addSubview(firstStar)
        gameView.addSubview(secondStar)
        gameView.addSubview(thirdStar)
        gameView.addSubview(firstWallImage)
        gameView.addSubview(secondWallImage)
        initialBallEmbededView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(70)
        }
        
        cupBaseImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        firstWallImage.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(235)
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(initialBallEmbededView.snp.bottom).offset(10)
        }
        firstStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.bottom.equalTo(firstWallImage.snp.top).offset(-20)
            make.trailing.equalTo(firstWallImage.snp.trailing).offset(-10)
        }
        
        secondWallImage.snp.makeConstraints { make in
            make.height.equalTo(235)
            make.width.equalTo(28)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        secondStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerY.equalTo(secondWallImage.snp.centerY)
            make.trailing.equalTo(secondWallImage.snp.leading).offset(-10)
        }
        
        thirdStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(cupImage.snp.centerX)
            make.bottom.equalTo(cupImage.snp.top).offset(-10)
        }
    }
    
    func setupSixthLevelComponents() {
        let firstStar = UIImageView(image: UIImage(resource: .enabledStar))
        let secondStar = UIImageView(image: UIImage(resource: .enabledStar))
        let thirdStar = UIImageView(image: UIImage(resource: .enabledStar))
        
        let firstWallImage = UIImageView(image: UIImage(resource: .wall8))
        let secondWallImage = UIImageView(image: UIImage(resource: .wall3))

        starImages.append(firstStar)
        starImages.append(secondStar)
        starImages.append(thirdStar)
        
        barierImages.append(firstWallImage)
        barierImages.append(secondWallImage)
        
        cupBaseImage.snp.makeConstraints { make in
            make.width.equalTo(114)
            make.height.equalTo(25)
        }
        cupBaseImage.image = UIImage(resource: .cupBase1)
        gameView.addSubview(firstStar)
        gameView.addSubview(secondStar)
        gameView.addSubview(thirdStar)
        gameView.addSubview(firstWallImage)
        gameView.addSubview(secondWallImage)
        initialBallEmbededView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(60)
        }
        
        cupBaseImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        firstWallImage.snp.makeConstraints { make in
            make.height.equalTo(235)
            make.width.equalTo(28)
            make.leading.equalTo(cupImage.snp.trailing).offset(45)
            make.bottom.equalTo(cupImage.snp.top).offset(-30)
        }
        firstStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.bottom.equalTo(firstWallImage.snp.top).offset(-20)
            make.trailing.equalTo(firstWallImage.snp.leading).offset(-10)
        }
        
        secondWallImage.snp.makeConstraints { make in
            make.height.equalTo(114)
            make.width.equalTo(25)
            make.bottom.equalTo(initialBallEmbededView.snp.top).offset(-30)
            make.trailing.equalToSuperview().inset(20)
        }
        secondStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerY.equalTo(secondWallImage.snp.centerY)
            make.trailing.equalTo(secondWallImage.snp.leading).offset(-10)
        }
        
        thirdStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(cupImage.snp.centerX)
            make.bottom.equalTo(cupImage.snp.top).offset(-10)
        }
    }
    
    func setupNinethLevelComponents() {
        let firstStar = UIImageView(image: UIImage(resource: .enabledStar))
        let secondStar = UIImageView(image: UIImage(resource: .enabledStar))
        let thirdStar = UIImageView(image: UIImage(resource: .enabledStar))
        
        let firstWallImage = UIImageView(image: UIImage(resource: .wall7))
        let secondWallImage = UIImageView(image: UIImage(resource: .wall7))
        let thirdWallImage = UIImageView(image: UIImage(resource: .wall8))
        let fourthWallImage = UIImageView(image: UIImage(resource: .wall8))

        starImages.append(firstStar)
        starImages.append(secondStar)
        starImages.append(thirdStar)
        
        barierImages.append(firstWallImage)
        barierImages.append(secondWallImage)
        barierImages.append(thirdWallImage)
        barierImages.append(fourthWallImage)
        
        cupBaseImage.snp.makeConstraints { make in
            make.width.equalTo(114)
            make.height.equalTo(25)
        }
        cupBaseImage.image = UIImage(resource: .cupBase1)
        gameView.addSubview(firstStar)
        gameView.addSubview(secondStar)
        gameView.addSubview(thirdStar)
        gameView.addSubview(firstWallImage)
        gameView.addSubview(secondWallImage)
        gameView.addSubview(thirdWallImage)
        gameView.addSubview(fourthWallImage)
        cupBaseImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        initialBallEmbededView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(120)
        }
        
        firstWallImage.snp.makeConstraints { make in
            make.height.equalTo(235)
            make.width.equalTo(28)
            make.centerX.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().inset(30)
        }
        
        secondWallImage.snp.makeConstraints { make in
            make.height.equalTo(235)
            make.width.equalTo(28)
            make.centerX.equalToSuperview().offset(-8)
            make.bottom.equalTo(firstWallImage.snp.top)
        }
        
        thirdWallImage.snp.makeConstraints { make in
            make.height.equalTo(235)
            make.width.equalTo(28)
            make.centerX.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(10)
        }
        
        fourthWallImage.snp.makeConstraints { make in
            make.height.equalTo(235)
            make.width.equalTo(28)
            make.centerX.equalToSuperview().offset(8)
            make.bottom.equalTo(thirdWallImage.snp.top)
        }
        
        firstStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalToSuperview().offset(8)
            make.bottom.equalTo(fourthWallImage.snp.top).offset(-20)
        }
        
        secondStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerY.equalTo(fourthWallImage.snp.centerY)
            make.leading.equalTo(fourthWallImage.snp.trailing).offset(20)
        }
        
        thirdStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(cupImage.snp.centerX)
            make.bottom.equalTo(cupImage.snp.top).offset(-10)
        }
    }
    
    func setupTenthLevelComponents() {
        let firstStar = UIImageView(image: UIImage(resource: .enabledStar))
        let secondStar = UIImageView(image: UIImage(resource: .enabledStar))
        let thirdStar = UIImageView(image: UIImage(resource: .enabledStar))
        
        let firstWallImage = UIImageView(image: UIImage(resource: .cupBase0))
        let secondWallImage = UIImageView(image: UIImage(resource: .wall1))
        let thirdWallImage = UIImageView(image: UIImage(resource: .cupBase0))

        starImages.append(firstStar)
        starImages.append(secondStar)
        starImages.append(thirdStar)
        
        barierImages.append(firstWallImage)
        barierImages.append(secondWallImage)
        barierImages.append(thirdWallImage)
        
        cupBaseImage.snp.makeConstraints { make in
            make.width.equalTo(235)
            make.height.equalTo(27)
        }
        cupBaseImage.image = UIImage(resource: .cupBase1)
        gameView.addSubview(firstStar)
        gameView.addSubview(secondStar)
        gameView.addSubview(thirdStar)
        gameView.addSubview(firstWallImage)
        gameView.addSubview(secondWallImage)
        gameView.addSubview(thirdWallImage)
        initialBallEmbededView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(30)
        }
        
        cupBaseImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        firstWallImage.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(114)
            make.centerX.equalTo(initialBallEmbededView.snp.centerX)
            make.top.equalTo(initialBallEmbededView.snp.bottom).offset(10)
        }

        secondWallImage.snp.makeConstraints { make in
            make.height.equalTo(78)
            make.width.equalTo(70)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        firstStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.bottom.equalTo(secondWallImage.snp.top).offset(-20)
            make.centerX.equalTo(secondWallImage.snp.centerX)
        }
        
        thirdWallImage.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(114)
            make.top.equalTo(secondWallImage.snp.bottom).offset(70)
            make.trailing.equalToSuperview().inset(60)
        }
        
        secondStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(thirdWallImage.snp.centerX)
            make.bottom.equalTo(thirdWallImage.snp.top).offset(-10)
        }
        
        thirdStar.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(cupImage.snp.centerX)
            make.bottom.equalTo(cupImage.snp.top).offset(-10)
        }
    }
}

