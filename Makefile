PYTHON=`which python`
DESTDIR=/
PROJECT=python-guild

all:
	@echo "make source - Create source package"
	@echo "make install - Install on local system"
	@echo "make buildrpm - Generate a rpm package"
	@echo "make builddeb - Generate a deb package"
	@echo "make clean - Get rid of scratch and byte files"

source:
	$(PYTHON) setup.py sdist $(COMPILE)

install:
	$(PYTHON) setup.py install --root $(DESTDIR) $(COMPILE)

buildrpm:
	$(PYTHON) setup.py bdist_rpm --post-install=rpm/postinstall --pre-uninstall=rpm/preuninstall

purge:
	sudo apt-get purge $(PROJECT)

deb:
	debuild -uc -us

use:
	sudo dpkg -i ../$(PROJECT)*deb

clean:
	$(PYTHON) setup.py clean
	dh_clean
	rm -rf build/ MANIFEST
	find . -name '*.pyc' -delete

devloop: purge clean deb use 