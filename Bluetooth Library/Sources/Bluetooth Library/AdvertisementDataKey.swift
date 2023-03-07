//
//  AdvertisementDataKey.swift
//  Squiddy
//

import CoreBluetooth

///https://developer.apple.com/documentation/corebluetooth/cbcentralmanagerdelegate/advertisement_data_retrieval_keys
struct AdvertisementDataKey {
    //Documented keys
    static let localName = CBAdvertisementDataLocalNameKey
    static let manufacturerData = CBAdvertisementDataManufacturerDataKey
    static let serviceData = CBAdvertisementDataServiceDataKey
    static let serviceUUIDs = CBAdvertisementDataServiceUUIDsKey
    static let overflowServiceUUIDs = CBAdvertisementDataOverflowServiceUUIDsKey
    static let txPowerLevel = CBAdvertisementDataTxPowerLevelKey
    static let isConnectable = CBAdvertisementDataIsConnectable
    static let solicitedServiceUUIDs = CBAdvertisementDataSolicitedServiceUUIDsKey
    
    //Undocumented keys - these keys are supported by Apple but are not documented any where
    static let timestamp = "kCBAdvDataTimestamp"
    static let rxPrimaryPHY = "kCBAdvDataRxPrimaryPHY"
    static let rxSecondaryPHY = "RxSecondaryPHY"
}

extension String {
    /// With this, you can turn a hexa string into an array of octet for easier manipulation
    /// - Returns: an array of octet ( 2 characters )
    func toArrayOf2Chars() -> [String] {
        var split: [String] = []
        for i in stride(from: 0, to: count, by: 2) {
            let start = index(startIndex, offsetBy: i)
            let end = index(startIndex, offsetBy: i + 2)
            let mySubstring = self[start..<end]
            split.append(String(mySubstring))
        }
        return split
    }
    /// reverse a hexa string
    /// - Returns: the reversed string
    func reverseData() -> String {
        return Array(self.toArrayOf2Chars().reversed()).joined()
    }
}

extension Data {
    /// Creates a hexadecimal string from the data
    /// - Parameter uppercase: Pass true to use uppercase letters to represent numerals greater than 9, or false to use lowercase letters. The default is false.
    func hexEncodedString(uppercase: Bool = true) -> String {
        return self.map {
            if $0 < 16 {
                return "0" + String($0, radix: 16, uppercase: uppercase)
            } else {
                return String($0, radix: 16, uppercase: uppercase)
            }
        }
        .joined()
    }
}


