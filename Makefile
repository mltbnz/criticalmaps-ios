all: bootstrap

bootstrap: dependencies

dependencies:
	$(shell ./update_dependencies.sh run_swiftformat)
	$(shell ./update_dependencies.sh run_license_plist)

hooks:
	mv ./hooks/pre-push ./.git/hooks/pre-push