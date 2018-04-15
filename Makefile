default:
	xcodebuild -workspace NEUPagingSegmentedControl.xcworkspace -scheme NEUPagingSegmentedControl-iOS -sdk iphonesimulator clean build analyze | xcpretty -c
	xcodebuild -workspace NEUPagingSegmentedControl.xcworkspace -scheme Example -sdk iphonesimulator clean build analyze | xcpretty -c

docs:
	bundle exec jazzy \
	--objc \
	--author bcylin \
	--author_url https://github.com/bcylin \
	--github_url https://github.com/bcylin/NEUPagingSegmentedControl \
	--github-file-prefix https://github.com/bcylin/NEUPagingSegmentedControl/blob/master \
	--sdk iphoneos \
	--module NEUPagingSegmentedControl \
	--module-version 0.3.0 \
	--umbrella-header Source/NEUPagingSegmentedControl.h \
	--framework-root . \
	--theme fullwidth

	for file in "html" "css" "js" "json"; do \
		echo "Trimming whitespace in *."$$file ; \
		find docs -name "*."$$file -exec sed -E -i "" -e "s/[[:blank:]]*$$//" {} \; ; \
	done
