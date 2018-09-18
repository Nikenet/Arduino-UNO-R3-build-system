builder/arduino-builder:
	./builder/build.sh
	mv arduino-builder ./builder/arduino-builder

build: builder/arduino-builder
	./builder/arduino-builder                \
	-compile                                 \
	-verbose                                 \
	-hardware   `pwd`/builder/hardware       \
	-tools      `pwd`/builder/tools          \
	-tools      `pwd`/builder/tools-builder  \
	-libraries  `pwd`/builder/lib            \
	-build-path `pwd`/build_dir              \
	-fqbn        arduino:avr:uno             \
	src/main.ino

upload:

flash:
	echo "flash"

clean:
	rm -rf ./build_dir/*

distclean:
	rm -rf ./builder/arduino-builder
	rm -rf ./build_dir/*
