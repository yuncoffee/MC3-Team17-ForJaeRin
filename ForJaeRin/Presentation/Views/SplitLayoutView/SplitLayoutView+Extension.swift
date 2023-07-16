//
//  SplitLayoutView+Extension.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/11.
//

import Foundation

extension SplitLayoutView {
    enum TabColumns {
        case single
        case double
        case triple
    }

    enum TabContents {
        case home
        case present
        case history
        case settings
        case plan
        
        var contentsName: String {
            switch self {
            case .home:
                return "Home"
            case .present:
                return "Present"
            case .history:
                return "연습 기록보기"
            case .settings:
                return "Settings"
            case .plan:
                return "연습하기"
            }
        }
        
        var iconName: String {
            switch self {
            case .home:
                return "house.fill"
            case .present:
                return "folder.fill"
            case .history:
                return "doc.richtext.fill"
            case .settings:
                return "gearshape.fill"
            case .plan:
                return "folder.fill"
            }
        }
        
        var column: TabColumns {
            switch self {
            case .home:
                return .single
            case .present:
                return .double
            case .history:
                return .single
            case .settings:
                return .single
            case .plan:
                return .single
            }
        }
    }
        
    enum MainTabs {
        case home
        case project
        case settings
        
        var tabName: String {
            switch self {
            case .home:
                return "Home"
            case .project:
                return "Project"
            case .settings:
                return "Settings"
            }
        }
        
        var iconName: String {
            switch self {
            case .home:
                return "house.fill"
            case .project:
                return "folder.fill"
            case .settings:
                return "gearshape.fill"
            }
        }
        
        var tabContents: [TabContents] {
            switch self {
            case .home:
                return [.home]
            case .project:
                return [.plan, .history, .present]
            case .settings:
                return [.settings]
            }
        }
    }
}
