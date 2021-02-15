.PHONY: install
install:
	mkdir -p ${HOME}/.local/bin
	cp src/docker-compose ${HOME}/.local/bin/docker-compose
	chmod +x ${HOME}/.local/bin/docker-compose
