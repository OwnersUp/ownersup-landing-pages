.PHONY: clean build stage prod

clean:
	rm -rf build

build:
	middleman build --clean

stage: build
	divshot push staging

prod: build
	divshot push production
