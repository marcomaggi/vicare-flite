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

    ;; Flite
    flite-init
    flite-text-to-wave
    flite-file-to-speech
    flite-text-to-speech
    flite-synth-text
    flite-synth-phones
    flite-voice-select
    flite-voice-add-lex-addenda

    ;; version numbers and strings
    vicare-flite-version-interface-current
    vicare-flite-version-interface-revision
    vicare-flite-version-interface-age
    vicare-flite-version

;;; --------------------------------------------------------------------
;;; still to be implemented

    )
  (import (vicare)
    (vicare speech-tools flite constants)
    (prefix (vicare speech-tools flite unsafe-capi)
	    capi.)
    (prefix (vicare ffi)
	    ffi.)
    (prefix (vicare ffi foreign-pointer-wrapper)
	    ffi.)
    (vicare arguments validation)
    #;(prefix (vicare platform words) words.))


;;;; arguments validation

#;(define-argument-validation (fixnum who obj)
  (fixnum? obj)
  (assertion-violation who "expected fixnum as argument" obj))


;;;; version functions

(define (vicare-flite-version-interface-current)
  (capi.vicare-flite-version-interface-current))

(define (vicare-flite-version-interface-revision)
  (capi.vicare-flite-version-interface-revision))

(define (vicare-flite-version-interface-age)
  (capi.vicare-flite-version-interface-age))

(define (vicare-flite-version)
  (ascii->string (capi.vicare-flite-version)))


;;;; data structures

(ffi.define-foreign-pointer-wrapper cst-voice
  (ffi.foreign-destructor #f)
  (ffi.collector-struct-type #f))

(ffi.define-foreign-pointer-wrapper cst-wave
  (ffi.foreign-destructor #f)
  (ffi.collector-struct-type #f))


;;;; Flite

(define (flite-init ctx)
  (define who 'flite-init)
  (with-arguments-validation (who)
      ()
    (capi.flite-init)))

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

(define (flite-voice-select ctx)
  (define who 'flite-voice-select)
  (with-arguments-validation (who)
      ()
    (capi.flite-voice-select)))

(define (flite-voice-add-lex-addenda ctx)
  (define who 'flite-voice-add-lex-addenda)
  (with-arguments-validation (who)
      ()
    (capi.flite-voice-add-lex-addenda)))


;;;; done

#;(set-rtd-printer! (type-descriptor XML_ParsingStatus) %struct-XML_ParsingStatus-printer)

#;(post-gc-hooks (cons %free-allocated-parser (post-gc-hooks)))

)

;;; end of file
;; Local Variables:
;; eval: (put 'ffi.define-foreign-pointer-wrapper 'scheme-indent-function 1)
;; End:
