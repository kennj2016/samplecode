//
//  EnumStatus.swift
//  sample
//
//  Created by KenNguyen 25/10/2021.
//

import Foundation
import UIKit

enum VerifyStatus:Int,CaseIterable {
    case Not_verify = 0
    case Waitting_for_review = 1
    case Reviewing = 2
    case Verifiled = 3
    
    var textValue: String {
        switch self {
        case .Not_verify:
            return "Rejected".localized()
        case .Waitting_for_review:
            return "Waitting for review".localized()
        case .Reviewing:
            return "Reviewing".localized()
        case .Verifiled:
            return "Verified".localized()
        }
    }
}

enum EkycStatus:Int,CaseIterable  {
    case  VERIFIED = 3
    case  REVIEWING = 1
    case  NOT_VERIFY = 0
    case  REJECTED = 2
    case  BLOCKED = 4
    case  BANNED = 5
    var textValue: String {
        switch self {
        case .VERIFIED:
            return "Verified".localized()
        case .REVIEWING:
            return "Reviewing".localized()
        case .REJECTED:
            return "Rejected".localized()
        case .BLOCKED:
            return "Blocked".localized()
        case .BANNED:
            return "Banned".localized()
        case .NOT_VERIFY:
            return "Not verify".localized()
        }
    }
}

enum VerifyStatusGroup:Int,CaseIterable {
    case UNVERIFY = 0
    case REVIEWING = 1
    case REJECTED = 2
    case VERIFIED = 3
    case BLOCKED = 4
    case BANNED = 5
}

enum TypeMessage: Int,CaseIterable {
    case TEXT = 0
    case AUDIO = 1
    case FILE = 2
    case STICKER = 3
    case GALLERY = 4
    case VIDEO = 5
    case LEAVE_JOIN = 6
}

enum TypeMessageAttachment: Int,CaseIterable {
    case VIDEO = 1
    case AUDIO = 2
    case IMAGE = 3
    case FILE = 4
    case OTHER = 5
}
enum ResultRequest: Int,CaseIterable {
    case  accepted = 1
    case rejected = 2
    case blocked = 3
    case pending = 0
}

enum UserGender: Int,CaseIterable {
    case MALE = 0
    case FEMALE = 1
    case OTHER = 2
    
    var textValue: String {
        switch self {
        case .MALE:
           return "Male"
        case .FEMALE:
           return "Female"
        case .OTHER:
           return "Other"
        }
    }
    
}


enum DateFormat: String, CaseIterable {
    case DATE_API_DEFAULT = "yyyy-MM-dd'T'HH:mm:ss"
    case DATE_API_DEFAULT2 = "yyyy-MM-dd'T'HH:mm:ssZ"
    case DATE_APP_FORMAT = "MM/DD/YYYY"
    case TIME_FORMAT = "HH:mm"
    case DATETIME_APP_FORMAT = "dd/MM/yyyy HH:mm"
    case DATE_APP_FORMAT2 = "YYYY-MM-DD"

    static var apiCases: [DateFormat] {
        return [.DATE_API_DEFAULT, .DATE_API_DEFAULT2]
    }
}

enum MaritalStatus: Int,CaseIterable {
    case MARRIED = 0
    case COHABITING = 1
    case SINGLE = 2
    case DIVORCED = 3
    case OTHER = 4
    
    var textValue: String {
        switch self {
        case .MARRIED:
            return "MARRIED".localized()
        case .COHABITING:
            return "COHABITING".localized()
        case .SINGLE:
            return "SINGLE".localized()
        case .DIVORCED:
            return "DIVORCED".localized()
        case .OTHER:
            return "OTHER".localized()
        }
    }
}


enum SettingSelection: String, CaseIterable {
    case edit_status = "Edit status"
    case project = "Project"
    case genaral_setting = "General Setting"
    case lable_setting = "Label Setting"
    case folder_setting = "Folder Setting"
    case theme = "Theme"
    case notification = "Notification"
    case contact = "Contact"
    case user_policy = "Tài khoản và bảo mật"
    case private_ = "Quyền riêng tư"
    
    var textValue : String {
        return self.rawValue.localized()
    }
    
    var image: UIImage? {
        switch self {
        case .edit_status:
            return Asset.setting_dot_green.image
        case .project:
            return Asset.setting_project.image
        case .genaral_setting:
            return Asset.setting_genaral.image
        case .lable_setting:
            return Asset.setting_lable.image
        case .folder_setting:
            return Asset.setting_folder.image
        case .theme:
            return Asset.setting_themse.image
        case .notification:
            return Asset.setting_notification.image
        case .contact:
            return Asset.setting_contact.image
        case .user_policy:
            return Asset.setting_user_sercu.image
        case .private_:
            return Asset.setting_private.image
        }
    }
}
