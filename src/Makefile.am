## Process this file with automake to produce Makefile.in

vicare_flite_CURRENT	= @vicare_flite_VERSION_INTERFACE_CURRENT@
vicare_flite_REVISION	= @vicare_flite_VERSION_INTERFACE_REVISION@
vicare_flite_AGE	= @vicare_flite_VERSION_INTERFACE_AGE@
vicare_flite_VERSION	= $(vicare_flite_CURRENT):$(vicare_flite_REVISION):$(vicare_flite_AGE)

lib_LTLIBRARIES			= libvicare-flite.la
libvicare_flite_la_LDFLAGS	= -version-info $(vicare_flite_VERSION)
libvicare_flite_la_SOURCES	= \
	vicare-flite-core.c			\
	vicare-flite-version.c			\
	vicare-flite-internals.h

### end of file
