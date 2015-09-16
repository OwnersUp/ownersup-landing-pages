.PHONY: clean stage prod

clean:
	rm -rf build

build:
	middleman build

stage:
	divshot push staging

prod: build
	divshot push production
