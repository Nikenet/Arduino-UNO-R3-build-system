SERIAL_TARGET=/dev/ttyUSB0
FQBN=esp8266:esp8266:nodemcu:CpuFrequency=80,VTable=flash,FlashSize=4M1M,LwIPVariant=v2mss536,Debug=Disabled,DebugLevel=None____,FlashErase=none,UploadSpeed=115200

builder/arduino-builder:
	./builder/build.sh
	mv arduino-builder ./builder/arduino-builder

build: builder/arduino-builder

	./builder/arduino-builder                     \
	-dump-prefs                                   \
	-logger=machine                               \
	-hardware `pwd`/builder/hardware              \
	-hardware `pwd`/builder/packages/packages     \
	-tools `pwd`/builder/tools-builder            \
	-tools `pwd`/builder/hardware/tools/avr       \
	-tools `pwd`/builder/packages/packages        \
	-libraries `pwd`/builder/libraries            \
	-fqbn=$(FQBN)                                 \
	-build-path `pwd`/build_dir                   \
	-warnings=all                                 \
	-verbose                                      \
	`pwd`/src/main.ino

	./builder/arduino-builder                     \
	-compile                                      \
	-logger=machine                               \
	-hardware `pwd`/builder/hardware              \
	-hardware `pwd`/builder/packages/packages     \
	-tools `pwd`/builder/tools-builder            \
	-tools `pwd`/builder/hardware/tools/avr       \
	-tools `pwd`/builder/packages/packages        \
	-libraries `pwd`/builder/libraries            \
	-fqbn=$(FQBN)                                 \
	-build-path `pwd`/build_dir                   \
	-warnings=all                                 \
	-verbose                                      \
	`pwd`/src/main.ino

upload:
	sudo /home/nikenet/osu_keyboard/esptool/esptool.py \
	--port $(SERIAL_TARGET)                            \
	write_flash 0x1000                                 \
	`pwd`/build_dir/main.ino.bin                       \

clean:
	rm -rf ./build_dir/*

distclean:
	rm -f  ./builder/arduino-builder
	rm -rf ./build_dir/*
