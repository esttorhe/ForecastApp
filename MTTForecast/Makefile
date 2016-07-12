EDITOR=vim

WORKSPACE = ForecastApp.xcworkspace
SCHEME = MTTForecast
CONFIGURATION = Debug
APP_NAME = MTTForecast
WORLD_WEATHER = WorldWeather

APP_PLIST = App/Info.plist
PLIST_BUDDY = /usr/libexec/PlistBuddy
BUNDLE_VERSION = $(shell $(PLIST_BUDDY) -c "Print CFBundleVersion" $(APP_PLIST))
GIT_COMMIT = $(shell git log -n1 --format='%h')
DEVICE_HOST = "platform=iOS Simulator,OS=9.3,name=iPhone 6s"

all: ci

HELP_FUNC = \
    %help; \
    while(<>) { \
        if(/^([a-z0-9_-]+):.*\#\#(?:@(\w+))?\s(.*)$$/) { \
            push(@{$$help{$$2}}, [$$1, $$3]); \
        } \
    }; \
    print "usage: make [target]\n\n"; \
    for ( sort keys %help ) { \
        print "$$_:\n"; \
        printf("  %-20s %s\n", $$_->[0], $$_->[1]) for @{$$help{$$_}}; \
        print "\n"; \
    }

help: ## This help dialog.
	@IFS=$$'\n' ; \
		help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##/:/'`); \
		printf '\033[33m'; \
		printf "%-30s %s\n" "Action" "Description" ; \
		printf "%-30s %s\n" "------" "------------" ; \
		for help_line in $${help_lines[@]}; do \
			IFS=$$':' ; \
			help_split=($$help_line) ; \
			help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
			help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
			printf '\033[36m'; \
			printf "%-30s %s" $$help_command ; \
			printf '\033[0m'; \
			printf "%s\n" $$help_info; \
		done

bundle: ## Retrieves all the GEMS listed on the Gemfile and installs the resulting bundle at \033[35m`./.vendor`
	bundle install --path="./.vendor"

synx: ## Executes the synx gem to make the Xcode files/groups architecture match in the file system
	bundle exec synx MTTForecast/MTTForecast.xcodeproj
	bundle exec synx WorldWeather/WorldWeatherCore/WorldWeatherCore.xcodeproj
	bundle exec synx WorldWeather/WorldWeatherMapping/WorldWeatherMapping.xcodeproj
	bundle exec synx WorldWeather/WorldWeatherAPI/WorldWeatherAPI.xcodeproj

pod: ## Executes the bundled gem \033[35m`cocoapods` \033[0mcommand \033[35m`pod install`. \033[0mInstalls missings pods to the Workspace
	bundle exec pod install

deintegrate: ## Runs \033[35m`bundle exec pod deintegrate`\033[0m on every project of the workspace (sans the Pods projects)
	bundle exec pod deintegrate MTTForecast/MTTForecast.xcodeproj
	bundle exec pod deintegrate WorldWeather/WorldWeatherCore/WorldWeatherCore.xcodeproj
	bundle exec pod deintegrate WorldWeather/WorldWeatherMapping/WorldWeatherMapping.xcodeproj
	bundle exec pod deintegrate WorldWeather/WorldWeatherAPI/WorldWeatherAPI.xcodeproj

clean_cache: ## Runs \033[35mbundle exec pod cache clean --all\033[0m to clean any pods cache.
	bundle exec pod cache clean --all

build: ## Builds the project.
	set -o pipefail && xcodebuild -workspace '$(WORKSPACE)' -scheme '$(SCHEME)' -configuration '$(CONFIGURATION)' -sdk iphonesimulator -destination $(DEVICE_HOST) build | bundle exec xcpretty -c

storyboards: ## Analyzes all the Storyboards under \033[35mMTTForecast\033[0m and generates «strong type» accessors to each ViewController and Segue at \033[35mMTTForecast/Extensions/Storyboard.swift
		swiftgen storyboards MTTForecast/ --output MTTForecast/MTTForecast/Extensions/Storyboard.swift

clean: ## Cleans the project (deletes derived data). Forces next build to be a «cold» build.
	xcodebuild -workspace '$(WORKSPACE)' -scheme '$(SCHEME)' -configuration '$(CONFIGURATION)' clean | xcpretty -c

test: ## Runs the test suite on the project.
	set -o pipefail && xcodebuild -verbose -workspace '$(WORKSPACE)' -scheme '$(WORLD_WEATHER)Core' -configuration '$(CONFIGURATION)' test -sdk iphonesimulator -destination $(DEVICE_HOST) | xcpretty -c
	set -o pipefail && xcodebuild -verbose -workspace '$(WORKSPACE)' -scheme '$(WORLD_WEATHER)Mapping' -configuration '$(CONFIGURATION)' test -sdk iphonesimulator -destination $(DEVICE_HOST) | xcpretty -c
	set -o pipefail && xcodebuild -verbose -workspace '$(WORKSPACE)' -scheme '$(WORLD_WEATHER)API' -configuration '$(CONFIGURATION)' test -sdk iphonesimulator -destination $(DEVICE_HOST) | xcpretty -c
	set -o pipefail && xcodebuild -verbose -workspace '$(WORKSPACE)' -scheme '$(SCHEME)' -configuration '$(CONFIGURATION)' test -sdk iphonesimulator -destination $(DEVICE_HOST) | xcpretty -c

prepare_ci: stub_keys

stub_keys: ## Stubs «-» for every key (useful for CI integrations)
	bundle exec pod keys set SoundCloudAPIClientID "-" WorldWeatherAPI
