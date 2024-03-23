//
//  LocationService.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 23/3/24.
//

import UIKit
import CoreLocation
//import BeedaAlertBase

class LocationService: NSObject, ObservableObject {
    static let shared = LocationService()
    @Published var current: CLLocation?
    @Published var locationEnabled: Bool?
    
    private var alreadyPresented: Bool = false
    
    private override init() {}
    
    @MainActor
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        return manager
    }()
    
    func requestLocationWhenInUser() async {
        if CLLocationManager.locationServicesEnabled() {
            let status = await locationManager.authorizationStatus
            
            switch status {
                case .notDetermined:
                    await locationManager.requestWhenInUseAuthorization()
                case .restricted:
                    await locationRestrictedAlert()
                case .denied:
                    await locationDeniedAlert()
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Authorized")
                    await utility.resetAlert()
                    
                @unknown default:
#if DEBUG
                    fatalError("New location authorization status that needed implementation")
#else
                    break
#endif
            }
        } else {
            await locationSettingsAlert()
        }
    }
    
    @discardableResult func getCurrentLocation() async -> (latitude: Double, longitude: Double)? {
        await requestLocationWhenInUser()
//        await locationManager.startUpdatingLocation()
        current = await locationManager.location
        
        if let coordinate = current?.coordinate {
            return (coordinate.latitude, coordinate.longitude)
        } else {
            return nil
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        current = locations.last
        manager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
//            case .notDetermined:
//                manager.requestLocation()
            case .authorizedWhenInUse, .authorizedAlways:
                manager.startUpdatingLocation()
                current = manager.location
                locationEnabled = true
            default:
                print(manager.authorizationStatus.rawValue)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        debugPrint(error)
    }
}

extension LocationService {
    @MainActor func locationSettingsAlert() {
        if alreadyPresented {
            utility.resetAlert()
            
            alreadyPresented = false
        }
        
        let title: String =  NSLocalizedString("Location service disabled", comment: "AlertTitle: Location service disabled")
        let message: String = NSLocalizedString("Your location service is disabled, you need location service enabled to use \(Bundle.main.bundleDisplayName). Go to settings and enable location service?", comment: "AlertMessage: Your location service is disabled, you need location service enabled to use \(Bundle.main.bundleDisplayName). Go to settings and enable location service?")
        
//        let defaultAction: CustomAlertAction = .init(title: NSLocalizedString("Go to settings", comment: "Button: Go to settings"), style: .base) {
//            if let url = URL(string: UIApplication.openSettingsURLString) {
//                // Ask the system to open that URL.
//                UIApplication.shared.open(url)
//            }
//        }
        
//        utility.showAlert(title: title, message: message, type: .warning, defaultAction: defaultAction, outsideTapDismiss: false)
        
        alreadyPresented = true
    }
    
    @MainActor func locationDeniedAlert() {
        if alreadyPresented {
            utility.resetAlert()
            
            alreadyPresented = false
        }
        
        let title: String = NSLocalizedString("Location permission denied", comment: "AlertTitle: Location permission denied")
        let message: String = NSLocalizedString("Your have denied permission to location access, you need to give location access permission to use \(Bundle.main.bundleDisplayName). Go to settings and give permission?", comment: "AlertMessage: Your have denied permission to location access, you need to give location access permission to use \(Bundle.main.bundleDisplayName). Go to settings and give permission?")
        
        let defaultAction: UIAlertAction = .init(title: NSLocalizedString("Go to settings", comment: "Button: Go to settings"), style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                // Ask the system to open that URL.
                UIApplication.shared.open(url)
            }
        }
//
        utility.showAlert(title: title, message: message, defaultAction: defaultAction)
        
        alreadyPresented = true
    }
    
    @MainActor func locationRestrictedAlert() {
        if alreadyPresented {
            utility.resetAlert()
            
            alreadyPresented = false
        }
        
        let title: String = NSLocalizedString("Location access restricted", comment: "AlertTitle: Location access restricted")
        let message: String = NSLocalizedString("Your location access is restricted, you can't use \(Bundle.main.bundleDisplayName) until location restriction revoked by your device administrator.", comment: "AlertMessage: Your location access is restricted, you can't use \(Bundle.main.bundleDisplayName) until location restriction revoked by your device administrator.")
        
//        let defaultAction: CustomAlertAction = .init(title: NSLocalizedString("I understand", comment: "Button: I understand"), style: .cancel)
//        
//        utility.showAlert(title: title, message: message, type: .warning, defaultAction: defaultAction, outsideTapDismiss: false)
        
        alreadyPresented = true
    }
}
