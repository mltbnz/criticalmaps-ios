all: bootstrap

bootstrap: dependencies hooks

dependencies:
	$(shell ./update_dependencies.sh run_swiftformat)
	$(shell ./update_dependencies.sh run_license_plist)

hooks:
	cp ./hooks/pre-push ./.git/hooks/pre-push