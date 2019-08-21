//
//  ContactCellTableViewCell.swift
//  RankUp
//
//  Created by Daniel Bernal on 8/20/19.
//

import UIKit

final class ContactViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: ContactViewCell.self)
    
    @IBOutlet weak var contactNameLbl: UILabel!
    @IBOutlet weak var contactJobTitleLbl: UILabel!
    @IBOutlet weak var profileView: ProfileView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(withModel model: Contact?) {
        guard let model = model else { return }
        resetContent()
        contactNameLbl.text = model.name
        contactJobTitleLbl.text = model.jobTitle
        profileView.configure(withName: model.name, userMSID: model.msid)
    }
    
    func resetContent() {
        profileView.reset()
        contactNameLbl.text = nil
        contactJobTitleLbl.text = nil
    }

}
