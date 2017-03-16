IMAGE_NAME=codeclimate/codeclimate-rustfmt


img:build/rustfmt
	docker build -t "${IMAGE_NAME}" .


build/rustfmt:
	mkdir -p build
	docker build --tag ${IMAGE_NAME}-build --file Build.dockerfile .
	docker run --rm --volume "${PWD}/build:/build" ${IMAGE_NAME}-build cp target/debug/rustfmt /build/
