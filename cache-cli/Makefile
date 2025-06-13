.PHONY: test

SECURITY_TOOLBOX_BRANCH ?= master
SECURITY_TOOLBOX_TMP_DIR ?= /tmp/security-toolbox

check.prepare:
	rm -rf $(SECURITY_TOOLBOX_TMP_DIR)
	git clone git@github.com:renderedtext/security-toolbox.git $(SECURITY_TOOLBOX_TMP_DIR) && (cd $(SECURITY_TOOLBOX_TMP_DIR) && git checkout $(SECURITY_TOOLBOX_BRANCH) && cd -)

check.static: check.prepare
	docker run -it -v $$(pwd):/app \
		-v $(SECURITY_TOOLBOX_TMP_DIR):$(SECURITY_TOOLBOX_TMP_DIR) \
		registry.semaphoreci.com/ruby:2.7 \
		bash -c 'cd /app && $(SECURITY_TOOLBOX_TMP_DIR)/code --language go -d'

check.deps: check.prepare
	docker run -it -v $$(pwd):/app \
		-v $(SECURITY_TOOLBOX_TMP_DIR):$(SECURITY_TOOLBOX_TMP_DIR) \
		-e TRIVY_DB_REPOSITORY -e TRIVY_JAVA_DB_REPOSITORY \
		registry.semaphoreci.com/ruby:2.7 \
		bash -c 'cd /app && $(SECURITY_TOOLBOX_TMP_DIR)/dependencies --language go -d'

test.setup:
	docker-compose build
	docker-compose run cli go get ./...

test:
	docker-compose run --rm cli gotestsum --format short-verbose --junitfile junit-report.xml --packages="./..." -- -p 1

test.watch:
	docker-compose run --rm cli gotestsum --watch --format short-verbose --junitfile junit-report.xml --packages="./..." -- -p 1

build.darwin:
	CGO_ENABLED=0 GOOS=darwin GOARCH=$(ARCH) go build -o bin/darwin/$(ARCH)/cache main.go

build.linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=$(ARCH) go build -o bin/linux/$(ARCH)/cache main.go

build.windows:
	CGO_ENABLED=0 GOOS=windows go build -o bin/windows/cache.exe main.go

lint:
	revive -formatter friendly -config lint.toml ./...
