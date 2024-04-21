//
//  SCPasswordField.swift
//  PasswordChecker
//
//  Created by Sezgin Çiftci on 21.04.2024.
//

import SwiftUI

public struct SCTextField: View {
    //MARK: Property
    @Binding var text: String
    var checkText: String
    @State private var infoType: SCInfoType = .incorrect
    
    public init(text: Binding<String>, checkText: String) {
        self._text = text
        self.checkText = checkText
    }
    
    //MARK: Body
    public var body: some View {
        VStack {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.secondary)
                    
                SecureField("Password", text: $text)
                
            } //HStack
            .padding()
            .background(Capsule().fill(Color.white))
            .frame(width: UIScreen.main.bounds.width - 100,
                   height: 50)
            .shadow(radius: 8)
            
            if !text.isEmpty {
                SCInfoText(infoType: $infoType)
            }
        } //VStack
        .onChange(of: text) { oldValue, newValue in
            infoType = checkText(newValue)
        }
    }
    
    private func checkText(_ input: String) -> SCInfoType {
        if input == checkText {
            return .correct
        } else if checkText.contains(input)
                    && ((checkText.count - 1) == input.count) {
            return .close
        } else if input.contains(checkText)
                    && ((input.count - 1) == checkText.count) {
            return .close
        } else {
            return .incorrect
        }
    }
}

fileprivate struct SCInfoText: View {
    //MARK: Property
    @Binding var infoType: SCInfoType
    
    //MARK: Body
    fileprivate var body: some View {
        HStack {
            Image(systemName: infoType.infoImage)
                .foregroundColor(infoType.textColor)
            Text(infoType.infoText)
                .foregroundColor(infoType.textColor.opacity(0.8))
        } //HStack
        .padding(.top, 6)
        .padding(.bottom)
        .padding(.leading, 8)
        .frame(width: UIScreen.main.bounds.width - 100, alignment: .leading)
    }
}

fileprivate enum SCInfoType {
    case correct
    case incorrect
    case close
    
    var infoText: String {
        switch self {
        case .correct:
            "Valid Password"
        case .incorrect:
            "Invalid Password"
        case .close:
            "You came pretty close"
        }
    }
    
    var infoImage: String {
        switch self {
        case .correct:
            "checkmark.circle.fill"
        case .incorrect:
            "xmark.circle.fill"
        case .close:
            "exclamationmark.circle"
        }
    }
    
    var textColor: Color {
        switch self {
        case .correct:
            Color("correct", bundle: .module)
        case .incorrect:
            Color("incorrect", bundle: .module)
        case .close:
            Color("close", bundle: .module)
        }
    }
}
