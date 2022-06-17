install_os:
	@./scripts/install_os.sh $(name)
	@echo "System has been installed"

workspace:
	@./scripts/setup_workspace.sh $(name)
	@echo "Workspace $(name) has been set up"
