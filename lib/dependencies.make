## dependencies.make --
#
# Automatically built.

EXTRA_DIST +=  \
	lib/vicare/speech-tools/flite/constants.vicare.sls.in

lib/vicare/speech-tools/flite.fasl: \
		lib/vicare/speech-tools/flite.vicare.sls \
		lib/vicare/speech-tools/flite/constants.fasl \
		lib/vicare/speech-tools/flite/unsafe-capi.fasl \
		$(FASL_PREREQUISITES)
	$(VICARE_COMPILE_RUN) --output $@ --compile-library $<

lib_vicare_speech_tools_flite_fasldir = $(bundledlibsdir)/vicare/speech-tools
lib_vicare_speech_tools_flite_vicare_slsdir  = $(bundledlibsdir)/vicare/speech-tools
nodist_lib_vicare_speech_tools_flite_fasl_DATA = lib/vicare/speech-tools/flite.fasl
if WANT_INSTALL_SOURCES
dist_lib_vicare_speech_tools_flite_vicare_sls_DATA = lib/vicare/speech-tools/flite.vicare.sls
endif
EXTRA_DIST += lib/vicare/speech-tools/flite.vicare.sls
CLEANFILES += lib/vicare/speech-tools/flite.fasl

lib/vicare/speech-tools/flite/constants.fasl: \
		lib/vicare/speech-tools/flite/constants.vicare.sls \
		$(FASL_PREREQUISITES)
	$(VICARE_COMPILE_RUN) --output $@ --compile-library $<

lib_vicare_speech_tools_flite_constants_fasldir = $(bundledlibsdir)/vicare/speech-tools/flite
lib_vicare_speech_tools_flite_constants_vicare_slsdir  = $(bundledlibsdir)/vicare/speech-tools/flite
nodist_lib_vicare_speech_tools_flite_constants_fasl_DATA = lib/vicare/speech-tools/flite/constants.fasl
if WANT_INSTALL_SOURCES
dist_lib_vicare_speech_tools_flite_constants_vicare_sls_DATA = lib/vicare/speech-tools/flite/constants.vicare.sls
endif
CLEANFILES += lib/vicare/speech-tools/flite/constants.fasl

lib/vicare/speech-tools/flite/unsafe-capi.fasl: \
		lib/vicare/speech-tools/flite/unsafe-capi.vicare.sls \
		$(FASL_PREREQUISITES)
	$(VICARE_COMPILE_RUN) --output $@ --compile-library $<

lib_vicare_speech_tools_flite_unsafe_capi_fasldir = $(bundledlibsdir)/vicare/speech-tools/flite
lib_vicare_speech_tools_flite_unsafe_capi_vicare_slsdir  = $(bundledlibsdir)/vicare/speech-tools/flite
nodist_lib_vicare_speech_tools_flite_unsafe_capi_fasl_DATA = lib/vicare/speech-tools/flite/unsafe-capi.fasl
if WANT_INSTALL_SOURCES
dist_lib_vicare_speech_tools_flite_unsafe_capi_vicare_sls_DATA = lib/vicare/speech-tools/flite/unsafe-capi.vicare.sls
endif
EXTRA_DIST += lib/vicare/speech-tools/flite/unsafe-capi.vicare.sls
CLEANFILES += lib/vicare/speech-tools/flite/unsafe-capi.fasl

lib/vicare/speech-tools/flite/features.fasl: \
		lib/vicare/speech-tools/flite/features.vicare.sls \
		$(FASL_PREREQUISITES)
	$(VICARE_COMPILE_RUN) --output $@ --compile-library $<

lib_vicare_speech_tools_flite_features_fasldir = $(bundledlibsdir)/vicare/speech-tools/flite
lib_vicare_speech_tools_flite_features_vicare_slsdir  = $(bundledlibsdir)/vicare/speech-tools/flite
nodist_lib_vicare_speech_tools_flite_features_fasl_DATA = lib/vicare/speech-tools/flite/features.fasl
if WANT_INSTALL_SOURCES
dist_lib_vicare_speech_tools_flite_features_vicare_sls_DATA = lib/vicare/speech-tools/flite/features.vicare.sls
endif
CLEANFILES += lib/vicare/speech-tools/flite/features.fasl


### end of file
# Local Variables:
# mode: makefile-automake
# End:
