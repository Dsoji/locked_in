import ManagedSettings
import ManagedSettingsUI
import UIKit

class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        return createShieldConfig(title: "LOCKED IN", subtitle: "Stay focused on your goals.")
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        return createShieldConfig(title: "SITE BLOCKED", subtitle: "Stay focused on your goals.")
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains in a category.
        return createShieldConfig(title: "CATEGORY BLOCKED", subtitle: "Stay focused on your goals.")
    }
    
    private func createShieldConfig(title: String, subtitle: String) -> ShieldConfiguration {
        return ShieldConfiguration(
            backgroundColor: UIColor.systemBackground,
            icon: UIImage(systemName: "lock.shield.fill"),
            title: ShieldConfiguration.Label(text: title, color: .label),
            subtitle: ShieldConfiguration.Label(text: subtitle, color: .secondaryLabel),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Close", color: .white),
            primaryButtonBackgroundColor: .label, // Uses system label color (black in light mode)
            secondaryButtonLabel: nil
        )
    }
}
