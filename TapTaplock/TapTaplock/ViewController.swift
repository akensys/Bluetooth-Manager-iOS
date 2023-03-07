//
//  ViewController.swift
//  TapTaplock
//
//  Created by Thanh Hai NGUYEN on 06/03/2023.
//

import UIKit
import Bluetooth_Library
import CoreBluetooth

class ViewController: UIViewController {
    @IBOutlet var table: UITableView?{
        didSet {
            table?.delegate = self
            table?.dataSource = self
        }
    }

    private var centralManager = BluetoothManager.getInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager.delegate = self
    }
}

//MARK: Bluetooth function
extension ViewController: BluetoothDelegate {
    func didUpdateState(_ state: CBManagerState) {
        switch state {
        case .poweredOn:
            centralManager.startScan()
        default:
            centralManager.stopScan()
            print("Bluetooth State Off")
        }
    }

    func didDiscoverPeripheral(_ peripheral: PeripheralWithData) {
        table?.reloadData()
    }

    func didConnectPeripheral(_ peripheral: CBPeripheral) {
        <#code#>
    }

}

//MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return centralManager.peripherals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        let blePeripheral = centralManager.peripherals[indexPath.row]
        config.text = blePeripheral.name
        config.secondaryText = blePeripheral.manufacturerData
        cell.contentConfiguration = config
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: the library handles only 1 connected peripheral only, so you need to disconnect
        // the old one before connecting to a new one
        if centralManager.connectedPeripheral != nil {
            centralManager.disconnectPeripheral()
        }

        let connectingPeripheral = centralManager.peripherals[indexPath.row]
        centralManager.connectPeripheral(connectingPeripheral)
    }
}
