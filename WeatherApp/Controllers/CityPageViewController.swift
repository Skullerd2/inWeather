import UIKit

class CityPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    let mainVC = MainViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(for index: Int) -> MainViewController?{
        if index < 0 || index >= mainVC.cityList.count{
            return nil
        }
        return nil
    }
}
