//
//  ViewController.swift
//  WeatherApp
//
//  Created by Aibek Rakhim on 9/22/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let backgroundView = UIImageView()
    let backgroundOverLay = UIView()
    let labelQuestion = UILabel()
    let enterTextField = UITextField()
    let submitButton = UIButton()
    let answerLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureConstraints()
        self.view.backgroundColor = .white
    }
    
    func getWeather() {
        
        if enterTextField.text != "" {
        if let url = URL(string: "http://www.weather-forecast.com/locations/\(enterTextField.text!.replacingOccurrences(of: " ", with: "-"))/forecasts/latest") {
            
            let request = NSMutableURLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                var message = ""
                
                if error != nil {
                    
                    print(error?.localizedDescription)
                    
                } else {
                    
                    if let unwrappedData = data {
                        
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        
                        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                            
                            if contentArray.count > 1 {
                                
                                stringSeparator = "</span>"
                                
                                let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                if newContentArray.count > 1 {
                                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    print(message)
                                }
                            } else {
                                
                            }
                        }
                    }
                }
                
                if message == "" {
                    
                    message = "The weather couldn`t be found. Please try to fill correct name of the city!"
                    
                }
                
                DispatchQueue.main.sync(execute: {
                    self.answerLabel.text = message
                })
            }
            
            task.resume()
            
        } else {
            
            answerLabel.text = "The weather couldn`t be found. Please try again"
        }
            
        } else {
            
            answerLabel.text = "Enter the name of city in text field"
        }
    }
    
    func setupView() {
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.image = UIImage(named: "backgroundImage")
        backgroundView.contentMode = .scaleAspectFill
        
        labelQuestion.textColor = .white
        labelQuestion.text = "What`s the Weather today?"
        labelQuestion.translatesAutoresizingMaskIntoConstraints = false
        labelQuestion.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        
        backgroundOverLay.translatesAutoresizingMaskIntoConstraints = false
        backgroundOverLay.backgroundColor = .black
        backgroundOverLay.alpha = 0.21
        
        enterTextField.translatesAutoresizingMaskIntoConstraints = false
        enterTextField.backgroundColor = .white
        enterTextField.placeholder = "E.g. Almaty, San Francisco"
        enterTextField.textColor = .black
        enterTextField.font = UIFont(name: "AvenirNext-Bold", size: 16.0)
        enterTextField.textAlignment = .center
        enterTextField.layer.cornerRadius = 10
        enterTextField.clipsToBounds = true
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Submit", for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        submitButton.addTarget(self, action: #selector(getWeather), for: .touchUpInside)
        
        answerLabel.text = ""
        answerLabel.textColor = .white
        answerLabel.adjustsFontSizeToFitWidth = true
        answerLabel.numberOfLines = 0
        answerLabel.font = UIFont(name: "AvenirNext-Regular", size: 18.0)
        answerLabel.translatesAutoresizingMaskIntoConstraints = false

        
        [backgroundView, backgroundOverLay, labelQuestion, enterTextField, submitButton, answerLabel].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        let topCons = NSLayoutConstraint(item: backgroundView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottomCons = NSLayoutConstraint(item: backgroundView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let leftCons = NSLayoutConstraint(item: backgroundView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let rightCons = NSLayoutConstraint(item: backgroundView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        
        let bgOverLayTop = NSLayoutConstraint(item: backgroundOverLay, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bgOverLayBottom = NSLayoutConstraint(item: backgroundOverLay, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let bgOverLayLeft = NSLayoutConstraint(item: backgroundOverLay, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let bgOverLayRight = NSLayoutConstraint(item: backgroundOverLay, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        
        
        let questionLabelCenterX = NSLayoutConstraint(item: labelQuestion, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let questionLabelTop = NSLayoutConstraint(item: labelQuestion, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50)
        
        let enteredTextFieldTop = NSLayoutConstraint(item: enterTextField, attribute: .top, relatedBy: .equal, toItem: labelQuestion, attribute: .bottom, multiplier: 1, constant: 50)
        let enteredTextFieldLeft = NSLayoutConstraint(item: enterTextField, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 25)
        let enteredTextFieldRight = NSLayoutConstraint(item: enterTextField, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -25)
        let enteredTextFieldHeight = NSLayoutConstraint(item: enterTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        
        let submitButtonTop = NSLayoutConstraint(item: submitButton, attribute: .top, relatedBy: .equal, toItem: enterTextField, attribute: .bottom, multiplier: 1, constant: 15)
        let submitButtonCenterX = NSLayoutConstraint(item: submitButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        
        let answerLabelTop = NSLayoutConstraint(item: answerLabel, attribute: .top, relatedBy: .equal, toItem: submitButton, attribute: .bottom, multiplier: 1, constant: 10)
        let answerLabelLeft = NSLayoutConstraint(item: answerLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 25)
        let answerLabelRight = NSLayoutConstraint(item: answerLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -25)
        let answerLabelHeight = NSLayoutConstraint(item: answerLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)

        
        self.view.addConstraints([topCons, bottomCons, leftCons, rightCons, questionLabelCenterX, questionLabelTop, bgOverLayTop, bgOverLayLeft, bgOverLayRight, bgOverLayBottom, enteredTextFieldTop, enteredTextFieldLeft, enteredTextFieldRight, enteredTextFieldHeight, submitButtonTop, submitButtonCenterX, answerLabelTop, answerLabelLeft, answerLabelRight, answerLabelHeight])
    }
    
}

