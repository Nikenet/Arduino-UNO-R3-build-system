SERIAL_TARGET=/dev/ttyACM0

builder/arduino-builder:
	./builder/build.sh
	mv arduino-builder ./builder/arduino-builder

build: builder/arduino-builder
	./builder/arduino-builder                    \
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
	sudo uname -a
	sudo avrdude                             \
		-v                                   \
		-D                                   \
		-p atmega328p                        \
		-c arduino                           \
		-P $(SERIAL_TARGET)                  \
		-b 115200                            \
		-U ./build_dir/main.ino.hex

flash/serial:
	sudo uname -a
	sudo ./atmega16u2_programmer/program.sh            \
		./atmega16u2_programmer/Arduino-usbserial.hex

flash/keyboard:
	sudo uname -a
	sudo ./atmega16u2_programmer/program.sh            \
		./atmega16u2_programmer/Arduino-keyboard.hex


clean:
	rm -rf ./build_dir/*

distclean:
	rm -f ./builder/arduino-builder
	rm -rf ./build_dir/*
