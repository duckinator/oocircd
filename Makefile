OC := rock

all: ircd

ircd:
	${OC} ircd

clean:
	rm -rf ircd ${OC}_tmp .libs

.PHONY: all clean