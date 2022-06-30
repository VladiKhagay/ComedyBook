import UIKit

class ShowsViewController: UIViewController {
    
    @IBOutlet weak var comedianImage_IMG: UIImageView!
    @IBOutlet weak var description_LBL: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var back_BTN: UIButton!
    
    
    private let viewModel = ShowsViewModel()
    var comedian : Comedian?


    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.description_LBL.text = self.comedian!.description
        let url = URL(string: self.comedian!.imageUrl)
        self.comedianImage_IMG.kf.setImage(with: url)
        
        viewModel.getShows(of: self.comedian!.name) { result in
            if result == false {
                print("error failed load shows")
            } else {
                self.collectionView.reloadData()
            }
        }
    }

    @IBAction func didTapBack(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "HomePageController") as? HomePageController else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension ShowsViewController: UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowCollectionViewCell", for: indexPath) as! ShowCollectionViewCell
        cell.setUpView(with: self.viewModel.shows[indexPath.row])
        cell.index = indexPath.row
        cell.delegate = self
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.masksToBounds = true
        return cell
    }
    
}

extension ShowsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 370, height: 92)
    }
}

extension ShowsViewController : ShowCollectionViewCellDelegate {
    func didTapButton(with index: Int) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SeatSelectionViewController") as? SeatSelectionViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.show = self.viewModel.shows[index]
        vc.comedian = self.comedian
        present(vc, animated: true, completion: nil)
    }
    
}
