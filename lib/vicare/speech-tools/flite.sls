;;; -*- coding: utf-8-unix -*-
;;;
;;;Part of: Vicare/Flite
;;;Contents: Flite binding backend
;;;Date: Sat Sep 21, 2013
;;;
;;;Abstract
;;;
;;;
;;;
;;;Copyright (C) 2013 Marco Maggi <marco.maggi-ipsu@poste.it>
;;;
;;;This program is free software:  you can redistribute it and/or modify
;;;it under the terms of the  GNU General Public License as published by
;;;the Free Software Foundation, either version 3 of the License, or (at
;;;your option) any later version.
;;;
;;;This program is  distributed in the hope that it  will be useful, but
;;;WITHOUT  ANY   WARRANTY;  without   even  the  implied   warranty  of
;;;MERCHANTABILITY  or FITNESS FOR  A PARTICULAR  PURPOSE.  See  the GNU
;;;General Public License for more details.
;;;
;;;You should  have received  a copy of  the GNU General  Public License
;;;along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;;


#!vicare
#!(load-shared-library "vicare-flite")
(library (vicare speech-tools flite)
  (export

    ;; library initialisation
    flite-init

    ;; voice
    flite-voice?
    flite-voice?/alive			$flite-voice-alive?
    flite-voice-custom-destructor	set-flite-voice-custom-destructor!
    flite-voice-putprop			flite-voice-getprop
    flite-voice-remprop			flite-voice-property-list
    flite-voice-hash

    flite-voice.vicare-arguments-validation
    flite-voice/alive.vicare-arguments-validation
    false-or-flite-voice.vicare-arguments-validation
    false-or-flite-voice/alive.vicare-arguments-validation

    flite-voice-select
    flite-voice-finalise
    flite-voice-name
    flite-voice-add-lex-addenda

    ;; version numbers and strings
    vicare-flite-version-interface-current
    vicare-flite-version-interface-revision
    vicare-flite-version-interface-age
    vicare-flite-version

;;; --------------------------------------------------------------------
;;; still to be implemented

    flite-text-to-wave
    flite-file-to-speech
    flite-text-to-speech
    flite-synth-text
    flite-synth-phones
    )
  (import (vicare)
    (vicare speech-tools flite constants)
    (prefix (vicare speech-tools flite unsafe-capi) capi.)
    #;(prefix (vicare ffi) ffi.)
    (prefix (vicare ffi foreign-pointer-wrapper) ffi.)
    (vicare arguments validation)
    (vicare arguments general-c-buffers)
    #;(prefix (vicare platform words) words.))


;;;; arguments validation

#;(define-argument-validation (fixnum who obj)
  (fixnum? obj)
  (assertion-violation who "expected fixnum as argument" obj))


;;;; library initialisation

(define (flite-init)
  (capi.flite-init))


;;;; version functions

(define (vicare-flite-version-interface-current)
  (capi.vicare-flite-version-interface-current))

(define (vicare-flite-version-interface-revision)
  (capi.vicare-flite-version-interface-revision))

(define (vicare-flite-version-interface-age)
  (capi.vicare-flite-version-interface-age))

(define (vicare-flite-version)
  (ascii->string (capi.vicare-flite-version)))


;;;; voice handling

;;NOTE Flite  is really  underdocumented, so this  is just  guessing and
;;trying to cope with the current and future releases.
;;
;;As of Flite  version 1.4: the structure  "cst_voice" representing each
;;voice is built and initialised once  by Flite; every time we request a
;;specific voice struct: the same  "cst_voice" is returned.  There is no
;;finalisation for voice foreign structures.
;;
(ffi.define-foreign-pointer-wrapper flite-voice
  (ffi.foreign-destructor #f)
  ;;Commented  out  because there  is  no  finalisation for  FLITE-VOICE
  ;;structures; but kept here just in case, in future, there is the need
  ;;to introduce it.
  ;;
  #;(ffi.foreign-destructor capi.flite-voice-finalise)
  (ffi.collector-struct-type #f))

(module ()
  (define (%printer S port sub-printer)
    (define-inline (%display thing)
      (display thing port))
    (define-inline (%write thing)
      (write thing port))
    (%display "#[flite-voice")
    (%display " pointer=")	(%display ($flite-voice-pointer  S))
    (%display " name=")		(%write   (capi.flite-voice-name S))
    (%display "]"))

  (set-rtd-printer! (type-descriptor flite-voice) %printer))

;;; --------------------------------------------------------------------

(define flite-voice-select
  (case-lambda
   (()
    (flite-voice-select "rms"))
   ((voice-name)
    (define who 'flite-voice-select)
    (with-arguments-validation (who)
	((general-c-string	voice-name))
      (with-general-c-strings
	  ((voice-name^	voice-name))
	(let ((rv (capi.flite-voice-select voice-name^)))
	  (if rv
	      (make-flite-voice/not-owner rv)
	    (error who "unable to create voice object" voice-name))))))
   ))

(define (flite-voice-finalise voice)
  (define who 'flite-voice-finalise)
  (with-arguments-validation (who)
      ((flite-voice	voice))
    ($flite-voice-finalise voice)))

;;; --------------------------------------------------------------------

(define (flite-voice-name voice)
  (define who 'flite-voice-name)
  (with-arguments-validation (who)
      ((flite-voice	voice))
    (capi.flite-voice-name voice)))

(define (flite-voice-add-lex-addenda ctx)
  (define who 'flite-voice-add-lex-addenda)
  (with-arguments-validation (who)
      ()
    (capi.flite-voice-add-lex-addenda)))


;;;; wav files

(ffi.define-foreign-pointer-wrapper cst-wave
  (ffi.foreign-destructor #f)
  (ffi.collector-struct-type #f))


;;;; Still to be implemented

(define (flite-text-to-wave ctx)
  (define who 'flite-text-to-wave)
  (with-arguments-validation (who)
      ()
    (capi.flite-text-to-wave)))

(define (flite-file-to-speech ctx)
  (define who 'flite-file-to-speech)
  (with-arguments-validation (who)
      ()
    (capi.flite-file-to-speech)))

(define (flite-text-to-speech ctx)
  (define who 'flite-text-to-speech)
  (with-arguments-validation (who)
      ()
    (capi.flite-text-to-speech)))

(define (flite-synth-text ctx)
  (define who 'flite-synth-text)
  (with-arguments-validation (who)
      ()
    (capi.flite-synth-text)))

(define (flite-synth-phones ctx)
  (define who 'flite-synth-phones)
  (with-arguments-validation (who)
      ()
    (capi.flite-synth-phones)))


;;;; done

#;(set-rtd-printer! (type-descriptor XML_ParsingStatus) %struct-XML_ParsingStatus-printer)

#;(post-gc-hooks (cons %free-allocated-parser (post-gc-hooks)))

)

;;; end of file
;; Local Variables:
;; eval: (put 'ffi.define-foreign-pointer-wrapper 'scheme-indent-function 1)
;; End:
