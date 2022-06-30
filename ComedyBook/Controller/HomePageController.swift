
import UIKit

class HomePageController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel : ComediansViewModel = ComediansViewModel()
    private var comedianName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout =  UICollectionViewFlowLayout()
        
        viewModel.getComedians { result in
            if result == false {
                print("error")
            } else {
                self.collectionView.reloadData()
            }
            
        }
    }
}

extension HomePageController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.comedians.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComedianCollectionViewCell", for: indexPath) as! ComedianCollectionViewCell
        cell.setUpView(with: self.viewModel.comedians[indexPath.row])
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.masksToBounds = true
        return cell
    }
}

extension HomePageController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: 210)
    }
}

extension HomePageController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.comedianName = self.viewModel.comedians[indexPath.row].name
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ShowsViewController") as? ShowsViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.comedian = self.viewModel.comedians[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
}

