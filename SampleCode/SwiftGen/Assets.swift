// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#elseif os(tvOS) || os(watchOS)
import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
    internal static let icNavigationBack = ImageAsset(name: "ic_navigation_back")
    internal static let icVerticalLine = ImageAsset(name: "ic_vertical_line")
    
    internal static let ic_tab_chat = ImageAsset(name: "tab_chat")
    internal static let ic_tab_group = ImageAsset(name: "tab_group")
    internal static let ic_tab_sample = ImageAsset(name: "tab_sample")
    internal static let ic_tab_network = ImageAsset(name: "tab_network")
    internal static let ic_tab_setting = ImageAsset(name: "tab_setting")
    internal static let ic_chat_avatar_default = ImageAsset(name: "ic_avatar_default")
    
    //SignIn & SignUp
    internal static let login_ic_bg = ImageAsset(name: "login_bg")
    internal static let login_ic_logo = ImageAsset(name: "login_logo")
    internal static let login_un_hidden_pass = ImageAsset(name: "login_un_hidden_pass")
    internal static let login_hidden_pass = ImageAsset(name: "login_hidden_pass")
    internal static let login_more_action = ImageAsset(name: "login_more_action")
    internal static let login_next = ImageAsset(name: "login_next")
    
    internal static let signup_capcha = ImageAsset(name: "signup_capcha")
    internal static let signup_checked = ImageAsset(name: "signup_checked")
    internal static let signup_exit = ImageAsset(name: "signup_exit")
    internal static let signup_info = ImageAsset(name: "signup_info")
    
    //Forgot Password
    internal static let forgot_pass_logo = ImageAsset(name: "forgot_pass_logo")

    //Setting
    internal static let setting_avatar_default = ImageAsset(name: "setting_avatar_default")
    internal static let setting_contact = ImageAsset(name: "setting_contact")
    internal static let setting_dot_green = ImageAsset(name: "setting_dot_green")
    internal static let setting_edit = ImageAsset(name: "setting_edit")
    internal static let setting_folder = ImageAsset(name: "setting_folder")
    internal static let setting_genaral = ImageAsset(name: "setting_genaral")
    internal static let setting_lable = ImageAsset(name: "setting_lable")
    internal static let setting_next = ImageAsset(name: "setting_next")
    internal static let setting_notification = ImageAsset(name: "setting_notification")
    internal static let setting_private = ImageAsset(name: "setting_private")
    internal static let setting_project = ImageAsset(name: "setting_project")
    internal static let setting_themse = ImageAsset(name: "setting_themse")
    internal static let setting_user_sercu = ImageAsset(name: "setting_user_sercu")
    internal static let setting_verify = ImageAsset(name: "setting_verify")
    
    
    //Profile
    
    internal static let profile_line_dash = ImageAsset(name: "profile_line_dash")
    internal static let profile_cover_default = ImageAsset(name: "profile_cover_default")
    internal static let profile_active_leader = ImageAsset(name: "profile_active_leader")
    internal static let profile_align_qr_code = ImageAsset(name: "profile_align_qr_code")
    internal static let profile_bod_big = ImageAsset(name: "profile_bod_big")
    internal static let profile_bod = ImageAsset(name: "profile_bod")
    internal static let profile_camera_big = ImageAsset(name: "profile_camera_big")
    internal static let profile_camera = ImageAsset(name: "profile_camera")
    internal static let profile_edit = ImageAsset(name: "profile_edit")
    internal static let profile_fullname = ImageAsset(name: "profile_fullname")
    internal static let profile_infor_verify = ImageAsset(name: "profile_infor_verify")
    internal static let profile_male = ImageAsset(name: "profile_male")
    internal static let profile_national = ImageAsset(name: "profile_national")
    internal static let profile_point = ImageAsset(name: "profile_point")
    internal static let profile_qr = ImageAsset(name: "profile_qr")
    internal static let profile_reject = ImageAsset(name: "profile_qr")
    internal static let profile_scan_qr = ImageAsset(name: "profile_scan_qr")
    internal static let profile_verify = ImageAsset(name: "profile_verify")
    internal static let profile_selected = ImageAsset(name: "profile_selected")
    internal static let profile_un_select = ImageAsset(name: "profile_un_select")

    
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
    internal fileprivate(set) var name: String
    
#if os(macOS)
    internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
    internal typealias Color = UIColor
#endif
    
    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
    internal private(set) lazy var color: Color = {
        guard let color = Color(asset: self) else {
            fatalError("Unable to load color asset named \(name).")
        }
        return color
    }()
    
    fileprivate init(name: String) {
        self.name = name
    }
}

internal extension ColorAsset.Color {
    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
    convenience init?(asset: ColorAsset) {
        let bundle = BundleToken.bundle
#if os(iOS) || os(tvOS)
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
#elseif os(macOS)
        self.init(named: NSColor.Name(asset.name), bundle: bundle)
#elseif os(watchOS)
        self.init(named: asset.name)
#endif
    }
}

internal struct ImageAsset {
    internal fileprivate(set) var name: String
    
#if os(macOS)
    internal typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
    internal typealias Image = UIImage
#endif
    
    internal var image: Image {
        let bundle = BundleToken.bundle
#if os(iOS) || os(tvOS)
        let image = Image(named: name, in: bundle, compatibleWith: nil)
#elseif os(macOS)
        let name = NSImage.Name(self.name)
        let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
#elseif os(watchOS)
        let image = Image(named: name)
#endif
        guard let result = image else {
            fatalError("Unable to load image asset named \(name).")
        }
        return result
    }
}

internal extension ImageAsset.Image {
    @available(macOS, deprecated,
               message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
    convenience init?(asset: ImageAsset) {
#if os(iOS) || os(tvOS)
        let bundle = BundleToken.bundle
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
#elseif os(macOS)
        self.init(named: NSImage.Name(asset.name))
#elseif os(watchOS)
        self.init(named: asset.name)
#endif
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        return Bundle(for: BundleToken.self)
#endif
    }()
}
// swiftlint:enable convenience_type
