PREFIX = /usr

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin/
	cp -f simulator.awk $(DESTDIR)$(PREFIX)/bin/flightsim
	chmod +x $(DESTDIR)$(PREFIX)/bin/flightsim

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/flightsim

.PHONY: install uninstall
