ARCHS = armv7 arm64
include theos/makefiles/common.mk

TWEAK_NAME = TapTheAt
TapTheAt_FILES = Tweak.xm
TapTheAt_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += taptheat
include $(THEOS_MAKE_PATH)/aggregate.mk
