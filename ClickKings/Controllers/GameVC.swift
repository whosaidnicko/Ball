import UIKit
import SnapKit

class GameVC: UIViewController {
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var initialBallEmbededView: UIView!
    @IBOutlet weak var ballImage: UIImageView!
    @IBOutlet weak var levelNumberLabel: UILabel!
    @IBOutlet weak var cupImage: UIImageView!
    @IBOutlet weak var cupBaseImage: UIImageView!
    
    var trajectoryLayer = CAShapeLayer()
    var panGesture: UIPanGestureRecognizer!
    
    var panStartPoint: CGPoint = .zero
    var panEndPoint: CGPoint = .zero
    var ballVelocity: CGPoint = .zero
    let gravity: CGFloat = 1000
    var displayLink: CADisplayLink?
    var ballPosition: CGPoint = .zero
    var timeElapsed: CGFloat = 0
    
    var starImages: [UIImageView] = []
    var barierImages: [UIImageView] = []
    
    var collectedStars = 0
    
    var lvlNumber: Int?
    let ballImageIndex = UserData.shared.getValue(forKey: Keys.selectedBall) as! Int
    let cupImageIndex = UserData.shared.getValue(forKey: Keys.selectedCup) as! Int

    override func viewDidLoad() {
        super.viewDidLoad()
        ballImage.image = UIImage(named: "ball\(ballImageIndex)")
        cupImage.image = UIImage(named: "cup\(cupImageIndex)")
        guard let lvlNumber = lvlNumber else { return }
        levelNumberLabel.text = "\(lvlNumber + 1)级"
        if lvlNumber == 0 {
            setupLevelOneBottomLabel()
        }
        setupBariersBasedOnLevel()
        setupGesture()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTrajectoryLayer()
    }

    @IBAction func returnMenuButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func levelsButtonTapped(_ sender: UIButton) {
        if let levelSelectionVC = navigationController?.viewControllers.first(where: { $0 is LevelSelectionVC }) {
            navigationController?.popToViewController(levelSelectionVC, animated: true)
        } else {
            let levelVC = storyboard?.instantiateViewController(withIdentifier: "LevelSelectionVC") as! LevelSelectionVC
            navigationController?.pushViewController(levelVC, animated: true)
        }
    }

    @IBAction func replayButton(_ sender: UIButton) {
        stopBallMovement()
        if let pushToGame = storyboard?.instantiateViewController(withIdentifier: "GameVC") as? GameVC {
            pushToGame.lvlNumber = lvlNumber
            navigationController?.pushViewController(pushToGame, animated: true)
        }
    }
}

// MARK: - Gesture Handling
extension GameVC {
    private func setupGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gameView.addGestureRecognizer(panGesture)
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: gameView)

        switch gesture.state {
        case .began:
            panStartPoint = ballImage.superview?.convert(ballImage.center, to: gameView) ?? ballImage.center
        case .changed:
            panEndPoint = touchPoint
            drawTrajectory(panStartPoint: panStartPoint, panEndPoint: panEndPoint, trajectoryLayer: trajectoryLayer)

        case .ended:
            gameView.removeGestureRecognizer(panGesture)

            let dx = panEndPoint.x - panStartPoint.x
            let dy = panEndPoint.y - panStartPoint.y
            let magnitude = sqrt(dx * dx + dy * dy)
            guard magnitude > 0 else { return }

            let direction = CGPoint(x: dx / magnitude, y: dy / magnitude)
            let velocityMultiplier: CGFloat = 4.0
            let launchSpeed = magnitude * velocityMultiplier

            ballVelocity = CGPoint(x: direction.x * launchSpeed, y: -direction.y * launchSpeed)
            
            removeBallConstraints() // Remove constraints before launching
            launchBall()
            clearTrajectory()

        default:
            break
        }
    }
}

// MARK: - Ball Movement & Collision
extension GameVC {
    private func removeBallConstraints() {
        // Convert ball's center to gameView's coordinate space
        let convertedCenter = ballImage.superview?.convert(ballImage.center, to: gameView) ?? ballImage.center
        initialBallEmbededView.isHidden = true
        // Remove from its previous superview and add to gameView
        ballImage.removeFromSuperview()
        gameView.addSubview(ballImage)

        // Restore the ball's original position
        ballImage.center = convertedCenter

        ballImage.snp.makeConstraints { make in
            make.width.height.equalTo(25)
        }
    }
    
    private func launchBall() {
        ballPosition = ballImage.center
        timeElapsed = 0
        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self, selector: #selector(updateBallPosition))
        displayLink?.add(to: .main, forMode: .common)
    }
    
    @objc private func updateBallPosition() {
        timeElapsed += displayLink?.duration ?? 0

        // Apply gravity
        ballVelocity.y += gravity * CGFloat(displayLink?.duration ?? 0)

        // Update ball position
        ballPosition.x += ballVelocity.x * CGFloat(displayLink?.duration ?? 0)
        ballPosition.y += ballVelocity.y * CGFloat(displayLink?.duration ?? 0)

        let ballFrame = ballImage.frame
        let cupFrame = cupImage.frame

        let ballBottom = ballFrame.maxY
        let ballTop = ballFrame.minY
        let ballLeft = ballFrame.minX
        let ballRight = ballFrame.maxX

        let cupTop = cupFrame.minY
        let cupLeft = cupFrame.minX
        let cupRight = cupFrame.maxX

        // 🎯 **Check if ball fully enters the cup**
        if ballImage.frame.intersects(cupFrame) {
            if ballBottom >= cupTop && ballTop < cupTop {
                // ✅ Ball has entered the cup
                userCompletionStatus(isWon: true, starAmount: collectedStars)
                return
            }
        }

        // 🛑 **Wall Collisions**
        if ballPosition.x <= 0 || ballPosition.x >= gameView.bounds.width - ballImage.frame.width {
            ballVelocity.x *= -0.85  // Reverse X direction (bounce off walls)
        }
        if ballPosition.y <= 0 {
            ballVelocity.y *= -0.85  // Bounce off top wall
        }

        // 🚧 **Cup Side Collision (Ball bounces off the cup's left or right walls)**
        if ballImage.frame.intersects(cupFrame) {
            if ballRight > cupLeft && ballLeft < cupRight {
                if ballBottom > cupTop { // Ball is near the cup sides
                    if ballRight > cupLeft && ballVelocity.x > 0 {
                        // Ball hits the LEFT wall of the cup
                        ballPosition.x = cupLeft - ballFrame.width / 2
                        ballVelocity.x *= -0.85
                    } else if ballLeft < cupRight && ballVelocity.x < 0 {
                        // Ball hits the RIGHT wall of the cup
                        ballPosition.x = cupRight + ballFrame.width / 2
                        ballVelocity.x *= -0.85
                    }
                }
            }
        }
        // 🚧 **Barrier Collision Logic**
        for barrier in barierImages {
            if ballImage.frame.intersects(barrier.frame) {
                let ballFrame = ballImage.frame
                let barrierFrame = barrier.frame

                let ballBottom = ballFrame.maxY
                let ballTop = ballFrame.minY
                let ballLeft = ballFrame.minX
                let ballRight = ballFrame.maxX

                let barrierTop = barrierFrame.minY
                let barrierBottom = barrierFrame.maxY
                let barrierLeft = barrierFrame.minX
                let barrierRight = barrierFrame.maxX

                let overlapX = min(ballRight - barrierLeft, barrierRight - ballLeft)
                let overlapY = min(ballBottom - barrierTop, barrierBottom - ballTop)

                if overlapY < overlapX {
                    if ballBottom > barrierTop && ballVelocity.y > 0 {
                        // Ball hits the TOP of the barrier
                        ballPosition.y = barrierTop - ballFrame.height / 2
                        ballVelocity.y *= -0.85
                    } else if ballTop < barrierBottom && ballVelocity.y < 0 {
                        // Ball hits the BOTTOM of the barrier
                        ballPosition.y = barrierBottom + ballFrame.height / 2
                        ballVelocity.y *= -0.85
                    }
                } else {
                    if ballRight > barrierLeft && ballVelocity.x > 0 {
                        // Ball hits the LEFT of the barrier
                        ballPosition.x = barrierLeft - ballFrame.width / 2
                        ballVelocity.x *= -0.85
                    } else if ballLeft < barrierRight && ballVelocity.x < 0 {
                        // Ball hits the RIGHT of the barrier
                        ballPosition.x = barrierRight + ballFrame.width / 2
                        ballVelocity.x *= -0.85
                    }
                }
            }
        }

        for star in starImages {
            if ballImage.frame.intersects(star.frame) {
                star.removeFromSuperview()
                collectedStars += 1
                starImages.removeAll { $0 == star }
            }
        }

        if ballPosition.y > gameView.bounds.height {
            userCompletionStatus(isWon: false, starAmount: 0)
//            resetGame()
            return
        }
        
        let velocityThreshold: CGFloat = 2.0 // Small threshold for stopping
        if abs(ballVelocity.x) < velocityThreshold && abs(ballVelocity.y) < velocityThreshold {
            userCompletionStatus(isWon: false, starAmount: 0)
            return
        }

        ballImage.center = ballPosition
    }
}

extension GameVC {
    func setupTrajectoryLayer() {
        trajectoryLayer.strokeColor = UIColor.white.cgColor
        trajectoryLayer.lineWidth = 4
        trajectoryLayer.fillColor = UIColor.clear.cgColor
        trajectoryLayer.lineDashPattern = [4, 8] // Dotted trajectory
        gameView.layer.addSublayer(trajectoryLayer)
    }

    func drawTrajectory(panStartPoint: CGPoint, panEndPoint: CGPoint, trajectoryLayer: CAShapeLayer) {
        let path = UIBezierPath()
        path.move(to: panStartPoint)

        let dx = panEndPoint.x - panStartPoint.x
        let dy = panEndPoint.y - panStartPoint.y
        let magnitude = sqrt(dx * dx + dy * dy)
        guard magnitude > 0 else { return }

        let direction = CGPoint(x: dx / magnitude, y: dy / magnitude)
        let launchSpeed: CGFloat = magnitude * 2.0
        let vx = direction.x * launchSpeed
        let vy = -direction.y * launchSpeed

        let adjustedGravity: CGFloat = 300
        for i in 1...20 {
            let t = CGFloat(i) * 0.1
            let x = panStartPoint.x + vx * t
            let y = panStartPoint.y + vy * t + (0.5 * adjustedGravity * t * t)
            path.addLine(to: CGPoint(x: x, y: y))
        }

        trajectoryLayer.path = path.cgPath
    }

    func clearTrajectory() {
        trajectoryLayer.path = nil
    }
    
    func setupBariersBasedOnLevel() {
        guard let level = lvlNumber else { return }
        barierImages.append(cupBaseImage)
        cupImage.snp.makeConstraints { make in
            make.centerX.equalTo(cupBaseImage.snp.centerX)
        }
        switch level {
        case 0:
            setupFirstLevelComponents()
        case 1:
            setupSecondLevelComponents()
        case 2:
            setupThirdLevelComponents()
        case 3:
            setupFourthLevelComponents()
        case 4:
            setupFifthLevelComponents()
        case 5:
            setupSixthLevelComponents()
        case 6:
            setupThirdLevelComponents()
        case 7:
            setupFifthLevelComponents()
        case 8:
            setupNinethLevelComponents()
        case 9:
            setupTenthLevelComponents()
        case 10:
            setupSixthLevelComponents()
        case 11:
            setupSecondLevelComponents()
        case 12:
            setupNinethLevelComponents()
        case 13:
            setupTenthLevelComponents()
        case 14:
            setupFourthLevelComponents()
        default:
            setupThirdLevelComponents()
        }
    }
    
    func stopBallMovement() {
        ballImage.alpha = 0
        displayLink?.invalidate()
        displayLink = nil
        ballVelocity = .zero
    }
    
    func userCompletionStatus(isWon: Bool, starAmount: Int) {
        stopBallMovement()
        guard let level = lvlNumber else { return }
        if isWon && level <= 13 {
            var stars = UserData.shared.getValue(forKey: Keys.stars) as! [Int]
            stars[level] = starAmount
            UserData.shared.setLevel(to: level + 1)
            UserData.shared.setValue(forKey: Keys.stars, value: stars)
        }
        let backClearView = UIView()
        let centerView = UIView()
        
        let centerImage = UIImageView(image: UIImage(resource: isWon ? .winCenter : .loseCenter))
        let starsStackView = UIStackView()
        let firstStarImage = UIImageView(image: UIImage(resource: (starAmount >= 1) ? .enabledStar : .disabledStar))
        let secondStarImage = UIImageView(image: UIImage(resource: (starAmount >= 2) ? .enabledStar : .disabledStar))
        let thirdStarImage = UIImageView(image: UIImage(resource: (starAmount >= 3) ? .enabledStar : .disabledStar))
        let centerButton = UIButton()
        let leftButton = UIButton()
        let rightButton = UIButton()
        view.addSubview(backClearView)
        backClearView.backgroundColor = .clear
        backClearView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backClearView.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(centerView.snp.width).dividedBy(1.44)
        }
        centerView.addSubview(centerImage)
        centerImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        centerView.addSubview(starsStackView)
        starsStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(38)
        }
        starsStackView.addArrangedSubview(firstStarImage)
        starsStackView.addArrangedSubview(secondStarImage)
        starsStackView.addArrangedSubview(thirdStarImage)
        firstStarImage.snp.makeConstraints { make in
            make.width.equalTo(firstStarImage.snp.height)
        }
        secondStarImage.snp.makeConstraints { make in
            make.width.equalTo(secondStarImage.snp.height)
        }
        thirdStarImage.snp.makeConstraints { make in
            make.width.equalTo(thirdStarImage.snp.height)
        }
        
        centerView.addSubview(centerButton)
        centerView.addSubview(leftButton)
        centerView.addSubview(rightButton)
        centerButton.setBackgroundImage(isWon ? UIImage(resource: .startGameButton) : UIImage(resource: .retryButton) , for: .normal)
        leftButton.setBackgroundImage(UIImage(resource: .menuButton), for: .normal)
        rightButton.setBackgroundImage(UIImage(resource: .returnToMenuButton), for: .normal)
        
        centerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
            make.width.height.equalTo(60)
        }
        leftButton.snp.makeConstraints { make in
            make.trailing.equalTo(centerButton.snp.leading).offset(-20)
            make.bottom.equalToSuperview().inset(25)
            make.height.width.equalTo(50)
        }
        rightButton.snp.makeConstraints { make in
            make.leading.equalTo(centerButton.snp.trailing).offset(20)
            make.bottom.equalToSuperview().inset(25)
            make.height.width.equalTo(50)
        }
        
        centerButton.addCustomAction { [self] in
           if isWon && level <= 13 {
               if let pushToGame = storyboard?.instantiateViewController(withIdentifier: "GameVC") as? GameVC {
                   pushToGame.lvlNumber = level + 1
                   navigationController?.pushViewController(pushToGame, animated: true)
               }
           } else {
               if let pushToGame = storyboard?.instantiateViewController(withIdentifier: "GameVC") as? GameVC {
                   pushToGame.lvlNumber = level
                   navigationController?.pushViewController(pushToGame, animated: true)
               }
           }
        }
        
        rightButton.addCustomAction { [self] in
            if let levelSelectionVC = navigationController?.viewControllers.first(where: { $0 is LevelSelectionVC }) {
                navigationController?.popToViewController(levelSelectionVC, animated: true)
            } else {
                let levelVC = storyboard?.instantiateViewController(withIdentifier: "LevelSelectionVC") as! LevelSelectionVC
                navigationController?.pushViewController(levelVC, animated: true)
            }
        }
        leftButton.addCustomAction {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func setupLevelOneBottomLabel() {
        let label = UILabel()
        label.font = UIFont(name: "Karla-ExtraBold", size: 33)
        label.textColor = UIColor(white: 1, alpha: 0.5)
        label.text = "将 3 个球扔进桶里"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
    }
}
