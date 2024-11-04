import UIKit

class CityPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let mainVC = MainViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = self.pageViewController(for: 0){
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = ((viewController as? MainViewController)?.currentIndex ?? 0) - 1
        mainVC.currentIndex = index
        print(mainVC.cityList[index])
        return self.pageViewController(for: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = ((viewController as? MainViewController)?.currentIndex ?? 0) + 1
        mainVC.currentIndex = index
        print(mainVC.cityList[index])
        return self.pageViewController(for: index)
    }
    
    func pageViewController(for index: Int) -> MainViewController?{
        if index < 0 || index >= mainVC.cityList.count{
            return nil
        }
        
        let viewController = MainViewController()
        viewController.currentCity = mainVC.cityList[index]
        return viewController
    }
}
