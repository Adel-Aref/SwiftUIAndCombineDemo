//
//  UserDefaultsContract.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 29/11/2024.
//

import Foundation

protocol UserDefaultsContract {
    func set(_ value: Any?, forKey defaultName: String)
    func data(forKey defaultName: String) -> Data?
}

extension UserDefaults: UserDefaultsContract {}
