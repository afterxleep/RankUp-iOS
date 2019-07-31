//
//  SignupViewController.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import UIKit

final class SignupViewController: UIViewController {
    
    @IBOutlet weak private var header: UIView!
    @IBOutlet weak private var formContainer: UIView!
    @IBOutlet weak private var headerTitle: UILabel!
    @IBOutlet weak private var signupImageView: UIImageView!
    @IBOutlet weak private var userLabel: UILabel!
    @IBOutlet weak private var jobLabel: UILabel!
    @IBOutlet weak private var locationTextField: UITextField!
    @IBOutlet weak private var disciplineTextField: UITextField!
    @IBOutlet weak private var startButton: UIButton!
    
    var viewModel = SignupViewModel(disciplineRepository: AreaRepository(), locationRepository: LocationRepository(), profileRepository: LoggedInUserRepository())
    
    // MARK: - Computed Properties
    
    lazy var locationPicker: UIPickerView = {
        pickerView
    }()
    
    lazy var disciplinePicker: UIPickerView = {
        pickerView
    }()
    
    var pickerView: UIPickerView {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        
        return picker
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchLocationAreaData { [weak self] error in
            if error == nil {
                self?.configurePickers()
            }
        }
    }
    
    // MARK: - Configuration
    
    private func configurePickers() {
        locationTextField.inputView = locationPicker
        disciplineTextField.inputView = disciplinePicker
    }
    
    private func setupUI() {
        header.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 52)
        
        let attributedTitle = NSMutableAttributedString(string: "Welcome to ", attributes: [.foregroundColor : UIColor.white,
                                                                                            .font: UIFont.systemFont(ofSize: 39)])
        let appNameString = NSAttributedString(string: "Rankme", attributes: [.foregroundColor : UIColor.aquaBlue,
                                                                              .font: UIFont.systemFont(ofSize: 39)])
        attributedTitle.append(appNameString)
        headerTitle.attributedText = attributedTitle
        
        formContainer.roundCorners(corners: [.topLeft, .topRight], radius: 52, shadow: true)
    }
    
    // MARK: - Actions
    
    @IBAction func didTapStartButton(_ sender: UIButton) {
        //TODO: Consume registration service, get profile data.
        performSegue(withIdentifier: K.Segues.onboardingSegue, sender: nil)
    }
    
}

extension SignupViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == locationPicker ? viewModel.numberOfLocatonItems : viewModel.numberOfDisciplineItems
    }
    
}

extension SignupViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == locationPicker ? viewModel.location(at: row) : viewModel.discipline(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == locationPicker {
            locationTextField.text = viewModel.location(at: row)
        } else {
            disciplineTextField.text = viewModel.discipline(at: row)
        }
    }
    
}

extension SignupViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            if textField == locationTextField {
                textField.text = viewModel.location(at: 0)
            } else {
                textField.text = viewModel.discipline(at: 0)
            }
        }
    }
    
}