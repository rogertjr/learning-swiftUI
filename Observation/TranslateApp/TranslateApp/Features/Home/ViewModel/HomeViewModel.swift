//
//  HomeViewModel.swift
//  TranslateApp
//
//  Created by Rogério Toledo on 09/08/23.
//

import SwiftUI
import Observation

@Observable class HomeViewModel {
    // MARK: - Properties
    var sourceLanguageIndex = 0
    var targetLanguageIndex = 1
    var inputText = ""
    var outputText = ""
    
    let languages = ["Portuguese", "English", "German", "Spanish", "Italian", "Arabic"]
    
    // MARK: - Helpers
    func translationText() {
        let sourceLanguageSelected = languages[sourceLanguageIndex]
        let targetLanguageSelected = languages[targetLanguageIndex]
    }
    
    func translationAPI(_ inputText: String, sourceLanguage: String, targetLanguage: String) {
        let translations = ["Olá": ["English": "Hello"], "Como esta?": ["English": "How are you?"]]
        
        guard let translation = translations[inputText]?[targetLanguage]  else {
            outputText = "Translation failed."
            return
        }
        outputText = translation
    }
}
