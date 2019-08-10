//
//  SignupViewController.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import UIKit

final class SignupViewController: UIViewController {
    
    private struct Constants {
        static let viewContainersRadius: CGFloat = 66
        static let profileViewRadius: CGFloat = 15
        static let formFieldsRadius: CGFloat = 9
        static let headerTitleFontSize: CGFloat = 39
        static let headerTitleLineHeight: CGFloat = 37
        static let locationPlaceholder = "Location"
        static let disciplinePlaceholder = "Discipline"
        static let textFieldRightViewAsset = "smallTriangleDown"
        static let placeholderTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor : UIColor.lightGreyBlue,
                                                                               .font: UIFont.systemFont(ofSize: 12, weight: .regular)]
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var header: UIView!
    @IBOutlet weak private var formContainer: UIView!
    @IBOutlet weak private var headerTitle: UILabel!
    @IBOutlet weak private var signupImageView: UIImageView!
    @IBOutlet weak private var userLabel: UILabel!
    @IBOutlet weak private var jobLabel: UILabel!
    @IBOutlet weak private var locationTextField: FieldText!
    @IBOutlet weak private var disciplineTextField: FieldText!
    @IBOutlet weak private var startButton: UIButton!
    
    var viewModel = SignupViewModel(apiClient: APIClient())
    
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
        configureUI()
        registerForKeyboardNotifications()
        
        viewModel.fetchLocationDisciplinesData { [weak self] error in
            if error == nil {
                self?.configureTextFieldsPickers()
            }
        }
    }
    
    // MARK: - Configuration
    
    private func configureTextFieldsPickers() {
        locationTextField.inputView = locationPicker
        disciplineTextField.inputView = disciplinePicker
    }
    
    private func configureUI() {
        let userData = viewModel.userModel?.data?.user
        
        userLabel.text = userData?.name
        jobLabel.text = userData?.jobTitle ?? "Senior Culebrerum"
    }
    
    private func setupUI() {
        roundCorners()
        styleTextFields()
        createAttributedStrings()
    }
    
    private func roundCorners() {
        header.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: Constants.viewContainersRadius)
        formContainer.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: Constants.viewContainersRadius)
        signupImageView.roundCorners(radius: Constants.profileViewRadius)
        locationTextField.roundCorners(radius: Constants.formFieldsRadius)
        disciplineTextField.roundCorners(radius: Constants.formFieldsRadius)
        startButton.roundCorners(radius: Constants.formFieldsRadius)
    }
    
    private func createAttributedStrings() {
        let attributedTitle = NSMutableAttributedString(string: "Welcome to ", attributes: [.foregroundColor: UIColor.white,
                                                                                            .font: UIFont.systemFont(ofSize: Constants.headerTitleFontSize,
                                                                                                                     weight: .black),
                                                                                            .kern: 0.5])
        
        let appNameString = NSAttributedString(string: "Rankme", attributes: [.foregroundColor: UIColor.aquaBlue,
                                                                              .font: UIFont.systemFont(ofSize: Constants.headerTitleFontSize,
                                                                                                       weight: .semibold)])
        
        attributedTitle.append(appNameString)
        attributedTitle.addAttribute(.paragraphStyle, value: UIHelper.lineHeightAttribute(size: Constants.headerTitleLineHeight),
                                     range: NSRange(location: 0, length: attributedTitle.length))
        
        headerTitle.attributedText = attributedTitle
        locationTextField.attributedPlaceholder = NSAttributedString(string: Constants.locationPlaceholder, attributes: Constants.placeholderTextAttributes)
        disciplineTextField.attributedPlaceholder = NSAttributedString(string: Constants.disciplinePlaceholder, attributes: Constants.placeholderTextAttributes)
    }
    
    private func styleTextFields() {
        let asset = UIImage(named: Constants.textFieldRightViewAsset)
        let rightImageView = UIImageView(image: asset)
        
        locationTextField.rightViewMode = .always
        locationTextField.rightView = rightImageView
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapStartButton(_ sender: UIButton) {
        viewModel.registerUser(location: locationTextField.text, discipline: disciplineTextField.text) { [weak self] in
            self?.performSegue(withIdentifier: K.Segues.onboardingSegue, sender: nil)
        }
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
