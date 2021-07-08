//
//  HomeViewController.swift
//  IBMAssignment
//
//  Created by Ritu pal on 07/07/21.
//

import UIKit
import MapKit
import GoogleMaps

class VehicleViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var viewMapContainer: UIView!
    @IBOutlet weak var mapView: GMSMapView!
//    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buttonToggle: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let viewModel = VehicleViewModel()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getVehicleList()
        // Do any additional setup after loading the view.
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
            let initalLocation = CLLocation(latitude: vehicles[0].location.latitude, longitude: vehicles[0].location.longitude)
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
//    private func setUpMapView() {
//        if let vehicles = viewModel.vehicles, vehicles.count > 0 {
//            let initalLocation = CLLocation(latitude: vehicles[0].location.latitude, longitude: vehicles[0].location.longitude)
//            mapView.centerToLocation(initalLocation)
//            let region = MKCoordinateRegion(
//                center: initalLocation.coordinate,
//                latitudinalMeters: 500,
//                longitudinalMeters: 600)
//            mapView.setCameraBoundary(
//                MKMapView.CameraBoundary(coordinateRegion: region),
//                animated: true)
//
//            let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 20000)
//            mapView.setCameraZoomRange(zoomRange, animated: true)
//            self.setupAnnotations(vehicles: vehicles)
//        }
//    }
//
//    private func setupAnnotations(vehicles: [Vehicle]) {
//
//        for vehicle in vehicles {
//
//            let coordinates = CLLocationCoordinate2D(latitude: vehicle.location.latitude, longitude: vehicle.location.longitude)
//            let annotation = VehicleAnnotation(title: vehicle.details.fullName, name: vehicle.modelName, imageURL: vehicle.image, coordinate: coordinates)
//            mapView.addAnnotation(annotation)
//        }
//        mapView.showAnnotations(mapView.annotations, animated: false)
//    }
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

//extension MKMapView: MKMapViewDelegate {
//    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
//        let coordinateRegion = MKCoordinateRegion(
//            center: location.coordinate,
//            latitudinalMeters: regionRadius,
//            longitudinalMeters: regionRadius)
//        setRegion(coordinateRegion, animated: true)
//    }
//
//
//    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard let annotation = annotation as? VehicleAnnotation else {
//            return nil
//        }
//
//        let reuseId = "Pin"
//        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
//        if pinView == nil {
//            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            pinView?.canShowCallout = true
//            let data = NSData(contentsOf: URL(string: annotation.imageUrl!)!)
//            pinView?.image = UIImage(data: data! as Data)
//        }
//        else {
//            pinView?.annotation = annotation
//        }
//
//        return pinView
//    }
//}
