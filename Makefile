.PHONY: clean build deploy

clean:
	rm -rf build

build:
	middleman build --clean

deploy: build
	surge build/
