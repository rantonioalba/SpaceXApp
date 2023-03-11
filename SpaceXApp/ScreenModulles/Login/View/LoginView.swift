//
//  LoginView.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 10/03/23.
//

import Foundation
import UIKit
import Combine

class LoginView: UIViewController {
    
    var cancellables = Set<AnyCancellable>()
    var viewModel:LoginViewModel!
    var scrollView : UIScrollView!
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textUserName : UITextField = {
        let view = UITextField()
        view.backgroundColor = .white
        view.placeholder = "Email"
        view.text = ""
        view.layer.cornerRadius = 5.0
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        view.leftViewMode = .always
        view.autocapitalizationType = .none
        view.returnKeyType = .next
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textPassword : UITextField = {
        let view = UITextField()
        view.backgroundColor = .white
        view.placeholder = "Password"
        view.text = ""
        view.layer.cornerRadius = 5.0
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        view.leftViewMode = .always
        view.autocorrectionType = .no
        view.textContentType = .none
        view.autocapitalizationType = .none
        view.returnKeyType = .done
        view.isSecureTextEntry = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let buttonLogin : UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Log In"
        configuration.baseBackgroundColor = .darkGray
        
        let view = UIButton()
        view.configuration = configuration
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let labelError : UILabel = {
        let view = UILabel()
        view.textColor = .red
        view.numberOfLines = 0
        view.isHidden = true
        view.adjustsFontSizeToFitWidth = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        createBindingWithViewModel()
        
        self.view.backgroundColor = UIColor.black
        
        setupView()
        
        stateController()
        viewModel.viewDidLoad()
                
        //Keyboard dismiss
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.navigationItem.title = ""
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if scrollView != nil {
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func dissmissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setupView()  {
        scrollView = UIScrollView()
        
        let containerImageView = UIView()
        containerImageView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerImageView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerImageView.centerYAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 130.0),
            imageView.heightAnchor.constraint(equalToConstant: 130.0)
        ])
        
        scrollView.addSubview(containerImageView)
        containerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80),
            containerImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            containerImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            containerImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
            containerImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        let containerTextUserName = UIView()
        containerTextUserName.addSubview(textUserName)
        textUserName.delegate  = self
        NSLayoutConstraint.activate([
            textUserName.topAnchor.constraint(equalTo: containerTextUserName.topAnchor),
            textUserName.leadingAnchor.constraint(equalTo: containerTextUserName.leadingAnchor, constant: 30.0),
            textUserName.trailingAnchor.constraint(equalTo: containerTextUserName.trailingAnchor, constant: -30.0),
            textUserName.bottomAnchor.constraint(equalTo: containerTextUserName.bottomAnchor, constant: 0)
        ])
        
        
        stackView.addArrangedSubview(containerTextUserName)
        containerTextUserName.translatesAutoresizingMaskIntoConstraints = false
        containerTextUserName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        let containerTextPassword = UIView()
        containerTextPassword.addSubview(textPassword)
        textPassword.delegate = self
        
        NSLayoutConstraint.activate([
            textPassword.topAnchor.constraint(equalTo: containerTextPassword.topAnchor),
            textPassword.leadingAnchor.constraint(equalTo: containerTextPassword.leadingAnchor, constant: 30.0),
            textPassword.trailingAnchor.constraint(equalTo: containerTextPassword.trailingAnchor, constant: -30.0),
            textPassword.bottomAnchor.constraint(equalTo: containerTextPassword.bottomAnchor, constant: 0)
        ])
        
        stackView.addArrangedSubview(containerTextPassword)
        containerTextPassword.translatesAutoresizingMaskIntoConstraints = false
        containerTextPassword.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let containerButtonLogin = UIView()
        containerButtonLogin.addSubview(buttonLogin)
        buttonLogin.addTarget(self, action: #selector(tapButtonLogin), for:.touchUpInside)
        
        NSLayoutConstraint.activate([
            buttonLogin.topAnchor.constraint(equalTo: containerButtonLogin.topAnchor),
            buttonLogin.leadingAnchor.constraint(equalTo: containerButtonLogin.leadingAnchor, constant: 30.0),
            buttonLogin.trailingAnchor.constraint(equalTo: containerButtonLogin.trailingAnchor, constant: -30.0),
            buttonLogin.bottomAnchor.constraint(equalTo: containerButtonLogin.bottomAnchor, constant: 0),
        ])
        
        
        stackView.addArrangedSubview(containerButtonLogin)
        containerButtonLogin.translatesAutoresizingMaskIntoConstraints = false
        containerButtonLogin.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        stackView.addArrangedSubview(labelError)
        labelError.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerImageView.bottomAnchor,constant: 0),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0, constant: -50),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0)
        ])
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func stateController()  {
        viewModel.state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.hideSpinner()
            switch state {
            case .success:
                self?.hideSpinner()
                break
            case .loading:
                self?.showSpinner()
                break
            case .fail(error: let error):
                self?.labelError.text = error
                self?.hideSpinner()
                break
            }
        }.store(in: &cancellables)
    }
    
    @objc func tapButtonLogin(_ sender: UIButton)    {
        self.labelError.isHidden = true
        
        viewModel.authenticate()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.view.frame = UIScreen.main.bounds
    }
    
    
    func createBindingWithViewModel() {
        textUserName.textPublisher
            .assign(to: \LoginViewModel.userName, on: viewModel)
            .store(in: &cancellables)
            
        textPassword.textPublisher
            .assign(to: \LoginViewModel.password, on: viewModel)
            .store(in: &cancellables)
        
        viewModel.$isEnabled
            .assign(to: \.isEnabled, on: buttonLogin)
            .store(in: &cancellables)
        
        viewModel.$isHiddenError
            .assign(to: \.isHidden, on: labelError)
            .store(in: &cancellables)
    }
    
    // MARK: Notifications
    @objc func handleKeyboardNotification(notification:NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            if isKeyboardShowing {
                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardFrame.size.height) + 50, right: 0)

                scrollView.contentInset = contentInsets
            } else {
                let contentInset:UIEdgeInsets = UIEdgeInsets.zero
                scrollView.contentInset = contentInset
            }
        }
    }
}

extension LoginView : UITextFieldDelegate {
    
}

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        return NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { notification in
                return (notification.object as? UITextField)?.text ?? ""
            }
            .eraseToAnyPublisher()
    }
}

extension LoginView : SpinnerDisplayable { }

