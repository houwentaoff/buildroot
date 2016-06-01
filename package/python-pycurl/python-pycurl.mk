################################################################################  
#
# python-pycurl    joy
#
################################################################################ 

PYTHON_PYCURL_VERSION = 7.43.0
PYTHON_PYCURL_SOURCE = pycurl-$(PYTHON_PYCURL_VERSION).tar.gz
PYTHON_PYCURL_SITE = https://pypi.python.org/packages/source/p/pycurl
PYTHON_PYCURL_LICENSE = Apache-2.0
PYTHON_PYCURL_LICENSE_FILES = LICENSE
PYTHON_PYCURL_DEPENDENCIES = libcurl
#setuptools
#PYTHON_PYCURL_SETUP_TYPE = distutils
PYTHON_PYCURL_SETUP_TYPE = setuptools
#PYCURL_SSL_LIBRARY=openssl
#OPENSSL=/work/32work/A9100/buildroot-2016.05-rc2/output/build/openssl-1.0.2h/
legacy_var='"/work/32work/A9100/buildroot-2016.05-rc2/output/host/bin:/work/32work/A9100/buildroot-2016.05-rc2/output/host/sbin:/work/32work/A9100/buildroot-2016.05-rc2/output/host/usr/bin:/work/32work/A9100/buildroot-2016.05-rc2/output/host/usr/sbin:/usr/local/arm_linux_4.3/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11:/usr/games:/sbin:/usr/sbin:/usr/local/sbin:/opt/arm_linux_4.2/bin" PYTHONPATH="/work/32work/A9100/buildroot-2016.05-rc2/output/target/usr/lib/python2.7/sysconfigdata/:/work/32work/A9100/buildroot-2016.05-rc2/output/target/usr/lib/python2.7/site-packages/" _python_sysroot=/work/32work/A9100/buildroot-2016.05-rc2/output/host/usr/arm-buildroot-linux-gnueabi/sysroot _python_prefix=/usr _python_exec_prefix=/usr  /work/32work/A9100/buildroot-2016.05-rc2/output/host/usr/bin/python setup.py install --prefix=/work/32work/A9100/buildroot-2016.05-rc2/output/target/usr)'

define PYTHON_PYCURL_BUILD_CMDS 
	(cd $(@D); \
	CC="$(TARGET_CC)" \
	LD="$(TARGET_LD)" \
	LDSHARED="$(TARGET_CROSS)gcc -shared" \
	$(HOST_DIR)/usr/bin/python setup.py build_ext \
	--with-openssl                                \
	--curl-config=$(STAGING_DIR)/usr/bin/curl-config)     
endef

define PYTHON_PYCURL_INSTALL_TARGET_CMDS
	(cd $(@D); \
	PATH=$(BR_PATH) \
	PYTHONPATH="$(if $(BR2_PACKAGE_PYTHON3),$(PYTHON3_PATH),$(PYTHON_PATH))" \
	_python_sysroot=$(STAGING_DIR) \
	_python_prefix=/usr \
	_python_exec_prefix=/usr  \
	$(HOST_DIR)/usr/bin/python setup.py install   \
	--prefix=$(TARGET_DIR)/usr)
endef

$(eval $(python-package))

