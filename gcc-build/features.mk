MAJOR_VERSION:=$(word 1, $(subst ., , $(VERSION)))

FEATURES=\
	--enable-languages=c,c++  \
	--enable-haifa            \
	--enable-sjlj-exceptions  \
	--disable-libstdcxx-pch \
	--disable-tls

# Check, if major version is greater than or equals to 8
ifeq ($(shell test $(MAJOR_VERSION) -ge 8; echo $$?), 0)
FEATURES+=--enable-lto
# Temporarily disable threads when building gcc 10.
ifeq ($(shell test $(MAJOR_VERSION) -eq 10; echo $$?), 0)
FEATURES+=--disable-threads
else
FEATURES+=--enable-threads=amigaos
endif
endif
