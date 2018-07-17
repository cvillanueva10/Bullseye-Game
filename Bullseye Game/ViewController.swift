
import UIKit
import QuartzCore

class ViewController: UIViewController {

    lazy var numberSlider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(sliderMoved), for: .touchDragInside)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Normal"), for: .normal)
        slider.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Highlighted"), for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftResizableImage = #imageLiteral(resourceName: "SliderTrackLeft").resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizableImage, for: .normal)
        let trackRightResizableImage = #imageLiteral(resourceName: "SliderTrackRight").resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizableImage, for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    var currentNumber: Int = 0
    var targetNumber: Int = 0
    var totalScoreNumber: Int = 0
    var roundNumber: Int = 0
    var targetNumberLabel = UILabel()
    var totalScoreNumberLabel = UILabel()
    var roundNumberLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startNewRound()
    }

    func startNewRound(){
        numberSlider.value = 50
        currentNumber = lroundf(numberSlider.value)
        targetNumber = 1 + Int(arc4random_uniform(100))
        updateLabels()
    }

    func updateLabels(){
        targetNumberLabel.text = "\(targetNumber)"
        roundNumber += 1
        roundNumberLabel.text = "\(roundNumber)"
        totalScoreNumberLabel.text = "\(totalScoreNumber)"
    }

    func calculateScoreAndTitleFeedback() -> (Int, String) {
        var title: String
        var score: Int
        let difference = abs(targetNumber - currentNumber)
        score = 100 - difference
        if difference == 0 {
            title = "Perfect!"
            score += 100
        } else if difference < 5 {
            if difference == 1 {
                score += 50
            }
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        totalScoreNumber += score
        return (score, title)
    }

    @objc func showScoreAlert() {
        let feedbackTitle: String
        let pointsFromThisRound: Int
        let response = calculateScoreAndTitleFeedback()
        pointsFromThisRound = response.0
        feedbackTitle = response.1
        let message = "You scored \(pointsFromThisRound) points"
        let alertController = UIAlertController(title: feedbackTitle, message: message, preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "OK", style: .cancel) { (_) in
            self.startNewRound()
        }
        alertController.addAction(actionAlert)
        present(alertController, animated: true, completion: nil)
    }

    @objc func showStartNewGameAlert() {
        let alertController = UIAlertController(title: "Are you sure?", message: "Would you like to start a new game?", preferredStyle: .alert)
        let yesActionAlert = UIAlertAction(title: "Yes", style: .default) { (_) in
            self.totalScoreNumber = 0
            self.roundNumber = 0
            self.startNewRound()
            let transition = CATransition()
            transition.type = kCATransition
            transition.duration = 1
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            self.view.layer.add(transition, forKey: nil)
            
        }
        let cancelActionAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelActionAlert)
        alertController.addAction(yesActionAlert)
        present(alertController, animated: true, completion: nil)

    }

    @objc func showInfo() {
        let aboutViewController = AboutViewController()
        present(aboutViewController, animated: true, completion: nil)
    }

    @objc func sliderMoved() {
        //print("Value is: \(Int(round(numberSlider.value)))")
        currentNumber = lroundf(numberSlider.value)
    }

    func setupUI() {
        // MARK : - Background Image View

        let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "Background"))
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.frame

        // MARK : - Hit Me Button

        let hitMeButton = createButtonWithTitleAndBackground(title: "Hit Me!", background: #imageLiteral(resourceName: "Button-Normal"), action: #selector(showScoreAlert))
        view.addSubview(hitMeButton)
        hitMeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hitMeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        hitMeButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        hitMeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        // MARK : - Number Slider and Min/Max Labels

        let sliderStackView = createStackView(axis: .horizontal, distribution: .fill, spacing: 10)
        let minNumberSliderLabel = createLabel(titleText: "0", isBolded: true)
        let maxNumberSliderLabel = createLabel(titleText: "100", isBolded: true)
        view.addSubview(sliderStackView)
        sliderStackView.addArrangedSubview(minNumberSliderLabel)
        sliderStackView.addArrangedSubview(numberSlider)
        sliderStackView.addArrangedSubview(maxNumberSliderLabel)
        sliderStackView.anchor(top: nil, paddingTop: 0, left: view.leftAnchor, paddingLeft: 120, bottom: hitMeButton.topAnchor, paddingBotton: 40, right: view.rightAnchor, paddingRight: 120, width: 0, height: 40)

        // MARK : - Header Objective Label
        
        let headerStackView = createStackView(axis: .horizontal, distribution: .fill, spacing: 0)

        let instructionLabel = createLabel(titleText: "Put the Bull's Eye as close as you can to:   ", isBolded: false)
        instructionLabel.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        targetNumberLabel = createLabel(titleText: "  \(targetNumber)", isBolded: true)
        targetNumberLabel.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        targetNumberLabel.textAlignment = .left
        view.addSubview(headerStackView)
         headerStackView.alignment = .center
        headerStackView.addArrangedSubview(instructionLabel)
        headerStackView.addArrangedSubview(targetNumberLabel)
        headerStackView.anchor(top: nil, paddingTop: 0, left: nil, paddingLeft: 200, bottom: sliderStackView.topAnchor, paddingBotton: 20, right: nil, paddingRight: 200, width: 0, height: 40)
        headerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // MARK : - Footer Buttons and Labels

        let footerStackView = createStackView(axis: .horizontal, distribution: .equalSpacing, spacing: 0)
        let scoreStackView = createStackView(axis: .horizontal, distribution: .fillProportionally, spacing: 5)
        let scoreTextLabel = createLabel(titleText: "Score: ", isBolded: false)
        totalScoreNumberLabel = createLabel(titleText: "\(totalScoreNumber)", isBolded: true)
        let roundStackView = createStackView(axis: .horizontal, distribution: .fillProportionally, spacing: 5)
        let roundTextLabel = createLabel(titleText: "Round: ", isBolded: false)
        //let startOverButton = createButtonWithTitle(title: "Start Over", action: #selector(showStartNewGameAlert))
        //let infoButton = createButtonWithTitle(title: "Info", action: #selector(showInfo))
        let startOverButton = createButtonWithImageAndBackground(image: #imageLiteral(resourceName: "StartOverIcon"), background: #imageLiteral(resourceName: "SmallButton"), action: #selector(showStartNewGameAlert))
        let infoButton = createButtonWithImageAndBackground(image: #imageLiteral(resourceName: "InfoButton"), background: #imageLiteral(resourceName: "SmallButton"), action: #selector(showInfo))
        roundNumberLabel = createLabel(titleText: "\(roundNumber)", isBolded: true)
        view.addSubview(scoreStackView)
        scoreStackView.addArrangedSubview(scoreTextLabel)
        scoreStackView.addArrangedSubview(totalScoreNumberLabel)
        view.addSubview(roundStackView)
        roundStackView.addArrangedSubview(roundTextLabel)
        roundStackView.addArrangedSubview(roundNumberLabel)
        view.addSubview(footerStackView)
        footerStackView.addArrangedSubview(startOverButton)
        footerStackView.addArrangedSubview(scoreStackView)
        footerStackView.addArrangedSubview(roundStackView)
        footerStackView.addArrangedSubview(infoButton)
        footerStackView.anchor(top: nil, paddingTop: 0, left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 30, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBotton: 30, right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 30, width: 0, height: 35)



        // TODO : See if everything can go into entire stack view (comment other stack view constraints first)
    }
}



