//
//  SupportEmail.swift
//  Orggi
//
//  Created by Augusto Simionato on 10/12/23.
//

import UIKit
import SwiftUI

struct SupportEmail {
    let toAddress: String
    
    func send(openURL: OpenURLAction) {
        let urlString = "mailto:\(toAddress)"
        
        guard let url = URL(string: urlString) else { return }
        openURL(url) { accepted in
            if !accepted {
                print("This device does not support email")
            }
        }
    }
}
