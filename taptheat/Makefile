ARCHS = armv7 arm64
include theos/makefiles/common.mk

BUNDLE_NAME = TapTheAt
TapTheAt_FILES = TapTheAt.mm
TapTheAt_INSTALL_PATH = /Library/PreferenceBundles
TapTheAt_FRAMEWORKS = UIKit
TapTheAt_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/TapTheAt.plist$(ECHO_END)
