//
//  HomeTableViewCell.swift
//  IBMAssignment
//
//  Created by Ritu pal on 07/07/21.
//

import UIKit
import SDWebImage

class VehicleTableViewCell: UITableViewCell {
    //MARK:- IBOutlets
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imageVehicle: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLicencePlate: UILabel!
    @IBOutlet weak var labelModelName: UILabel!
    
    static var identifier: String = "VehicleTableViewCell"
    
    public var viewModel: VehicleTableViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            labelName.text = viewModel.name
            labelLicencePlate.text = viewModel.licencePlate
            labelModelName.text = viewModel.model + " / " + viewModel.type
            self.imageVehicle.sd_imageIndicator = SDWebImageActivityIndicator.white
            self.imageVehicle.sd_setImage(with: viewModel.image, completed: nil)
            
        }
    }
    
    //MARK:- View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewMain.layer.cornerRadius = Constants.defaultCornerRadius
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
}
