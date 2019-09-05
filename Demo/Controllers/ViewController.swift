import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class ViewController: UIViewController , NVActivityIndicatorViewable {
    //Mark: - IBOutlet
    @IBOutlet weak var tableView : UITableView!
    
    //Mark: -Variable
    let displayCell = "DisplayCell"
    let viewModel = ViewModel()
    
    
    //Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "DisplayCell", bundle: nil), forCellReuseIdentifier: displayCell)
        
        let size = CGSize(width: 42, height: 42)
        startAnimating(size, message: "",
                       type: .ballTrianglePath, fadeInAnimation: nil)
       
        viewModel.getVenue(success: {
            self.stopAnimating()
            self.tableView.reloadData()
        }, fail: {
            self.stopAnimating()
            print("FAIL!!")
        })
    }


}
//Mark: - UITableViewDatasorce & Delegate
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: displayCell, for: indexPath) as! DisplayCell
        
        let data = viewModel.getVanue(index: indexPath.row)
        cell.configureCell(icon: data.icon, name: data.name, address: data.address)
        
        return cell
    }
    
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = Scene.datailPage.viewController() as! DetailViewController
        let data = viewModel.getVanue(index: indexPath.row)
        vc.icon = data.icon
        vc.name = data.name
        vc.address = data.address
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
}



