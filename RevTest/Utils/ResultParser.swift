//
//  ResultParser.swift
//  RevTest
//
//  Created by Андрей Ушаков on 20.05.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

final class ResultsParser {
    static func parseResults(_ dict: [String: Any]) -> [Rate]? {
        guard let rawRates = dict["rates"] as? [String: Double] else { return nil }
        return rawRates.map { (key: String, value: Double) -> Rate in
            return Rate(code: key, value: value)
        }
    }
}
