//
//  HomeViewController.swift
//  IBMAssignment
//
//  Created by Ritu pal on 07/07/21.
//

import UIKit
import GoogleMaps

class VehicleViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var viewMapContainer: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var buttonToggle: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let viewModel = VehicleViewModel()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getVehicleList()
    }
    
    //MARK: Setup
    private func setupTableView() {
        self.tableView.register(UINib(nibName: VehicleTableViewCell.identifier, bundle: .main), forCellReuseIdentifier: VehicleTableViewCell.identifier)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    //MARK: Vehicle List
    private func getVehicleList() {
        viewModel.getVehicleList { [weak self](error) in
            if let errorMessage = error {
                self?.showAlertView(message: errorMessage)
            } else {
                self?.reloadTableView()
            }
        }
    }
    
    @IBAction func actionToggle(_ sender: UIBarButtonItem) {
        if buttonToggle.title == "Map" {
            buttonToggle.title = "List"
            self.setTableViewVisibility(isHide: true)
            self.setUpMapView()
        } else {
            buttonToggle.title = "Map"
            self.setTableViewVisibility(isHide: false)
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func showAlertView(message: String) {
        let alertViewController = UIAlertController(title: ErrorKey.errorTitle.rawValue.localized(), message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alertViewController, animated: false, completion: nil)
        }
    }
    
    private func setTableViewVisibility(isHide: Bool) {
        self.tableView.isHidden = isHide
        self.viewMapContainer.isHidden = !isHide
    }
    
    private func setUpMapView() {
        if let vehicles = viewModel.vehicles, vehicles.count > 0 {
            self.mapView.camera = GMSCameraPosition(latitude: vehicles[0].location.latitude, longitude: vehicles[0].location.longitude, zoom: 14.0)
            self.addmarkers(vehicles: vehicles)
        }
    }
    
    private func addmarkers(vehicles: [Vehicle]) {
        for vehicle in vehicles {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: vehicle.location.latitude, longitude: vehicle.location.longitude)
            marker.title = vehicle.details.fullName
            let imageView = UIImageView(image: UIImage.init(named: "map_pin"))
            imageView.sd_setImage(with: vehicle.imageURL, completed: nil)
            marker.iconView = imageView
            marker.map = mapView
        }
    }
}

extension VehicleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleTableViewCell.identifier, for: indexPath) as? VehicleTableViewCell else {return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(at: indexPath.row)
        cell.viewModel = cellViewModel
        return cell
    }
}
