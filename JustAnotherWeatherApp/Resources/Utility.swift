//
//  Utility.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 23/3/24.
//

import SwiftUI

@MainActor
class Utility: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var loading: Bool = false
    
    @Published var icon: Image?
    @Published var title: Text = Text("")
    @Published var message: Text?
    @Published var type: UIAlertViewStyle?
    @Published var defaultAction: UIAlertAction?
    @Published var cancelAction: UIAlertAction?
    
    @MainActor
    func showLoading() {
        loading = true
    }
    
    @MainActor
    func hideLoading() {
        loading = false
    }
}

//MARK: - Alert
extension Utility {
    @MainActor
    func showAlert(title: String, message: String? = nil, defaultAction: UIAlertAction? = nil, cancelAction: UIAlertAction? = nil) {
        self.title = Text(title)
        if let message = message {
            self.message = Text(message)
        }
        
        self.defaultAction = defaultAction
        self.cancelAction = cancelAction
        
        self.showAlert = true
    }
    
    @MainActor
    func showAlert(icon: UIImage?, title: String, message: String? = nil, defaultAction: UIAlertAction? = nil, cancelAction: UIAlertAction? = nil) {
        self.title = Text(title)
        if let message = message {
            self.message = Text(message)
        }
        
        if let icon = icon {
            self.icon = Image(uiImage: icon)
        }
        
        self.defaultAction = defaultAction
        self.cancelAction = cancelAction
        
        self.showAlert = true
    }
    
    @MainActor
    func showAlert(icon: Image?, title: String, message: String? = nil, defaultAction: UIAlertAction? = nil, cancelAction: UIAlertAction? = nil) {
        self.title = Text(title)
        if let message = message {
            self.message = Text(message)
        }
        
        if let icon = icon {
            self.icon = icon
        }
        
        self.defaultAction = defaultAction
        self.cancelAction = cancelAction
        
        self.showAlert = true
    }
    
    func resetAlert(){
        showAlert = false
        icon = nil
        title = Text("")
        message = nil
        type = nil
        defaultAction = nil
        cancelAction = nil
    }
}
