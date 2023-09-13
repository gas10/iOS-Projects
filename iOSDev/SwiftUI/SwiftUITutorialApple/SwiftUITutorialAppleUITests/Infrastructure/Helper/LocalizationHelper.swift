//
//  LocalizationHelper.swift
//  SwiftUITutorialAppleUITests
//
//  Created by Amar Gawade on 9/13/23.
//

public enum DeviceLanguage: String {
    case english = "(en)"
    case chinese = "(zh)"
    case german = "(de)"
    case spanish = "(es)"
    case french = "(fr)"
}
public enum DeviceLocale: String {
    case us = "en_US"
    case china = "zh-Hans"
    case germany = "de-DE"
    case spain = "es-ES"
    case france = "fr_FR"
}
public enum LprojLanguageCode: String {
    case english = "en"
    case chinese = "zh_CN"
    case german = "de"
    case spanish = "es"
    case french = "fr"
}

// [locale: langauge code] dictionary to get language code for localized string
public let languageCodeDictionary = ["en_US": "en", "zh-Hans": "zh_CN", "de-DE": "de", "es-ES": "es", "fr_FR": "fr"]

public enum DeviceLanguageSettings: CaseIterable {
    case chinese
    case german
    case spanish
    case french
    case english
    // return (language, locale)
    var arguments: (DeviceLanguage, DeviceLocale) {
        switch self {
        case .chinese:
            return (.chinese, .china)
        case .german:
            return (.german, .germany)
        case .spanish:
            return (.spanish, .spain)
        case .french:
            return (.french, .france)
        case .english:
            return (.english, .us)
        }
    }
}

let localeArguments = DeviceLanguageSettings.allCases.randomElement()?.arguments ?? DeviceLanguageSettings.chinese.arguments
