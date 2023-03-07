//
//  File.swift
//  
//
//  Created by Thanh Hai NGUYEN on 06/03/2023.
//

import CoreBluetooth

open class PeripheralWithData: NSObject {
    public var peripheral: CBPeripheral
    public var name: String
    var rawData: [String:Any]
    public var manufacturerData: String?
    public var serviceData: [String : String]?

    public init(peripheral: CBPeripheral, name: String, rawData: [String : Any]) {
        self.peripheral = peripheral
        self.name = name
        self.rawData = rawData
        let manufacturerData = rawData[AdvertisementDataKey.manufacturerData] as? Data
        self.manufacturerData = manufacturerData?.hexEncodedString()
        let serviceData = rawData[CBAdvertisementDataServiceDataKey] as? [CBUUID: Data]
        super.init()
        self.serviceData = getServiceDataString(serviceData)
    }

    /// Turn the peripheral service data into a dictionary of String
    /// - Parameter serviceData: the peripheral's service data
    /// - Returns: a `[UUID:Data]` String dict of service data
    func getServiceDataString(_ serviceData: [CBUUID: Data]?) -> [String: String]? {
        guard let serviceData = serviceData else {
            return nil
        }
        var serviceDataString: [String: String] = [:]
        for (uuid, rawdata) in serviceData {
            let serviceUUIDString = uuid.uuidString.reverseData()
            let data = rawdata.hexEncodedString()
            serviceDataString[serviceUUIDString] = data
        }
        return serviceDataString
    }
}
