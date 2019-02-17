.PHONY: all $(MAKECMDGOALS)

all: build

build:
	@swift build

release:
	@swift build -c release -Xswiftc -static-stdlib

proj: build
	@rm -rf Periphery.xcodeproj
	@swift package generate-xcodeproj
	@cp Tests/Configs/RetentionFixtures.xcscheme Periphery.xcodeproj/xcshareddata/xcschemes/
	@open Periphery.xcodeproj

lint:
	@swiftlint lint --quiet

test:
	@set -o pipefail && swift test 2>&1 | bundle exec xcpretty -tc
