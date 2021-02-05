//: A UIKit based Playground for presenting user interface

import Combine
import PlaygroundSupport
import UIKit

extension Notification.Name {
    static let newMessage = Notification.Name("newMessage")
}

struct Message {
    let content: String
    let author: String
}

class MyViewController: UIViewController {
    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let allowMessagesSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.addTarget(self, action: #selector(didSwitch), for: .valueChanged)
        return mySwitch
    }()

    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        button.setTitle("Send Message", for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Message content"
        label.textAlignment = .center
        return label
    }()

    @Published var canSendMessage: Bool = false

    private var switchSubscriber: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(vStack)
        vStack.addArrangedSubview(allowMessagesSwitch)
        vStack.addArrangedSubview(sendButton)
        vStack.addArrangedSubview(messageLabel)

        vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        vStack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        setupProcessingChain()
    }

    func setupProcessingChain() {
        switchSubscriber = $canSendMessage.receive(on: DispatchQueue.main).assign(to: \.isEnabled, on: sendButton)

        let messagePublisher = NotificationCenter.Publisher(center: .default, name: .newMessage)
            .map { notification -> String? in
                (notification.object as? Message)?.content
            }

        let messageSubscriber = Subscribers.Assign(object: messageLabel, keyPath: \.text)

        messagePublisher.subscribe(messageSubscriber)
    }

    @objc func didSwitch(_ sender: UISwitch) {
        canSendMessage = sender.isOn
    }

    @objc func sendMessage(_: Any) {
        let message = Message(content: "The current time is \(Date())", author: "Khawar Ali")
        NotificationCenter.default.post(name: .newMessage, object: message)
    }
}

let viewController = MyViewController()
PlaygroundPage.current.liveView = viewController
