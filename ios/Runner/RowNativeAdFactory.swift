import Flutter
import Foundation
import GoogleMobileAds
import UIKit
import google_mobile_ads

/// Renders a native ad as one 64 pt row: [icon] Headline / body · [Ad] · [Install]
///
/// Everything AdMob requires is present — headline, ad attribution,
/// AdChoices (added by the SDK), and a media view — but the media view is a
/// single point so the row stays a row. Video creatives will not serve to
/// it; image and text ones do.
///
/// Registered from AppDelegate under the id "row"; the Dart side asks for it
/// with `NativeAd(factoryId: 'row')`.
class RowNativeAdFactory: NSObject, FLTNativeAdFactory {
  private static let accent = UIColor(red: 0.314, green: 0.624, blue: 0.459, alpha: 1)  // #509F75
  private static let ink = UIColor(red: 0.227, green: 0.227, blue: 0.227, alpha: 1)  // #3A3A3A
  private static let muted = UIColor(red: 0.533, green: 0.580, blue: 0.612, alpha: 1)  // #88949C
  private static let font = "FiraSans-Regular"
  private static let fontLight = "FiraSans-Light"

  func createNativeAd(
    _ nativeAd: NativeAd,
    customOptions: [AnyHashable: Any]? = nil
  ) -> NativeAdView? {
    Self.registerFontsOnce
    let view = NativeAdView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 24
    view.clipsToBounds = true

    let icon = UIImageView()
    icon.contentMode = .scaleAspectFill
    icon.clipsToBounds = true
    icon.layer.cornerRadius = 10
    icon.backgroundColor = UIColor(red: 0.89, green: 0.945, blue: 0.914, alpha: 1)  // #E3F1E9
    icon.image = nativeAd.icon?.image
    icon.isHidden = nativeAd.icon?.image == nil

    let headline = UILabel()
    headline.text = nativeAd.headline
    headline.font = Self.uiFont(Self.font, size: 15, weight: .semibold)
    headline.textColor = Self.ink
    headline.numberOfLines = 1
    headline.lineBreakMode = .byTruncatingTail

    let body = UILabel()
    body.text = nativeAd.body ?? nativeAd.advertiser
    body.font = Self.uiFont(Self.fontLight, size: 12.5, weight: .regular)
    body.textColor = Self.muted
    body.numberOfLines = 1
    body.lineBreakMode = .byTruncatingTail
    body.isHidden = body.text?.isEmpty ?? true

    // Required ad attribution.
    let badge = UILabel()
    badge.text = "Ad"
    badge.font = Self.uiFont(Self.font, size: 10, weight: .semibold)
    badge.textColor = Self.muted
    badge.textAlignment = .center
    badge.layer.borderColor = Self.muted.withAlphaComponent(0.6).cgColor
    badge.layer.borderWidth = 1
    badge.layer.cornerRadius = 4
    badge.setContentHuggingPriority(.required, for: .horizontal)
    badge.setContentCompressionResistancePriority(.required, for: .horizontal)

    let cta = UIButton(type: .system)
    cta.setTitle(nativeAd.callToAction ?? "Install", for: .normal)
    cta.titleLabel?.font = Self.uiFont(Self.font, size: 13, weight: .semibold)
    cta.setTitleColor(.white, for: .normal)
    cta.backgroundColor = Self.accent
    cta.layer.cornerRadius = 16
    cta.contentEdgeInsets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    // The SDK handles taps on the registered call-to-action view.
    cta.isUserInteractionEnabled = false
    cta.setContentHuggingPriority(.required, for: .horizontal)
    cta.setContentCompressionResistancePriority(.required, for: .horizontal)

    // Mandatory, but not part of the layout: a point in the corner.
    let media = MediaView()
    media.mediaContent = nativeAd.mediaContent
    media.isHidden = true

    let text = UIStackView(arrangedSubviews: [headline, body])
    text.axis = .vertical
    text.spacing = 2

    let row = UIStackView(arrangedSubviews: [icon, text, badge, cta])
    row.axis = .horizontal
    row.alignment = .center
    row.spacing = 8
    row.setCustomSpacing(12, after: icon)

    [row, media].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    NSLayoutConstraint.activate([
      view.heightAnchor.constraint(equalToConstant: 64),
      row.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      row.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
      row.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      icon.widthAnchor.constraint(equalToConstant: 40),
      icon.heightAnchor.constraint(equalToConstant: 40),
      badge.widthAnchor.constraint(equalToConstant: 24),
      badge.heightAnchor.constraint(equalToConstant: 16),
      cta.heightAnchor.constraint(equalToConstant: 32),
      media.widthAnchor.constraint(equalToConstant: 1),
      media.heightAnchor.constraint(equalToConstant: 1),
      media.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      media.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    view.headlineView = headline
    view.bodyView = body
    view.iconView = icon
    view.callToActionView = cta
    view.mediaView = media
    view.nativeAd = nativeAd
    return view
  }

  /// Fira Sans is shipped as a Flutter asset, which UIKit knows nothing
  /// about; register the files with CoreText so UIFont can find them.
  private static let registerFontsOnce: Void = {
    for asset in ["assets/fira_sans_regular.ttf", "assets/fira_sans_light.ttf"] {
      let key = FlutterDartProject.lookupKey(forAsset: asset)
      guard let path = Bundle.main.path(forResource: key, ofType: nil) else { continue }
      CTFontManagerRegisterFontsForURL(URL(fileURLWithPath: path) as CFURL, .process, nil)
    }
  }()

  /// The app's Fira Sans when registered, the system font otherwise.
  private static func uiFont(_ name: String, size: CGFloat, weight: UIFont.Weight) -> UIFont {
    UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
  }
}
