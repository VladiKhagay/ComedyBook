import UIKit
import Kingfisher

class ComedianCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name_LBL: UILabel!
    @IBOutlet weak var comedian_IMG: UIImageView!
        
    func setUpView(with comedian: Comedian){
        let url = URL(string: comedian.imageUrl)
        comedian_IMG.kf.setImage(with: url)
        name_LBL.text = comedian.name
    }
    
}
