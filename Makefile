PREFIX=arch-live
DESKTOP=xfce
LABEL=ARCHXFCE

all:
	sudo ./build.sh -v -N ${PREFIX} -V ${DESKTOP} -L ${LABEL}

clean:
	sudo rm -rf work out
