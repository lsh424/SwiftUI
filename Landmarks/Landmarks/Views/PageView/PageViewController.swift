//
//  PageViewController.swift
//  Landmarks
//
//  Created by seunghwan Lee on 2021/04/21.
//

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPage: Int
    
    // SwiftUI는 makeUIViewController(context :) 전에 이 makeCoordinator() 메서드를 호출하므로 뷰 컨트롤러를 구성 할 때 코디네이터 객체에 액세스 할 수 있습니다., 이 코디네이터를 사용하여 델리게이트, 데이터 소스 및 target-action을 통한 사용자 이벤트 응답과 같은 일반적인 Cocoa 패턴을 구현할 수 있습니다.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // SwiftUI는 뷰를 표시 할 준비가되었을 때, 이 메서드를 한 번 호출 한 다음 뷰컨트롤러의 수명주기 관리
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }
    
    // SwiftUI는 UIViewControllerRepresentable 타입의 코디네이터를 관리하고 위에서 만든 메서드를 호출 할 때 컨텍스트의 일부로 제공합니다.
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController]()
        
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
}
