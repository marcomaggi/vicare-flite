;;; -*- coding: utf-8-unix -*-
;;;
;;;Part of: Vicare/Flite
;;;Contents: unsafe interface to the C language API
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
;;;MERCHANTABILITY or  FITNESS FOR  A PARTICULAR  PURPOSE.  See  the GNU
;;;General Public License for more details.
;;;
;;;You should  have received a  copy of  the GNU General  Public License
;;;along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;;


#!r6rs
(library (vicare speech-tools flite unsafe-capi)
  (export

    ;; Flite unsafe C API
    flite-init

    ;; voice handling
    flite-voice-select
    flite-voice-name
    flite-available-voice-names
    flite-voice-add-lex-addenda

    ;;Commented  out because  there is  no finalisation  for FLITE-VOICE
    ;;structures; but  kept here just in  case, in future, there  is the
    ;;need to introduce it.
    ;;
    #;flite-voice-finalise

    ;; version functions
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
  (import (vicare))


;;;; version functions

(define-inline (vicare-flite-version-interface-current)
  (foreign-call "ikrt_flite_version_interface_current"))

(define-inline (vicare-flite-version-interface-revision)
  (foreign-call "ikrt_flite_version_interface_revision"))

(define-inline (vicare-flite-version-interface-age)
  (foreign-call "ikrt_flite_version_interface_age"))

(define-inline (vicare-flite-version)
  (foreign-call "ikrt_flite_version"))


;;;; library initialisation

(define-inline (flite-init)
  (foreign-call "ikrt_flite_init"))


;;;; voice handling

(define-inline (flite-voice-select voice)
  (foreign-call "ikrt_flite_voice_select" voice))

;;Commented  out  because  there  is  no  finalisation  for  FLITE-VOICE
;;structures; but kept  here just in case, in future,  there is the need
;;to introduce it.
;;
;; (define-inline (flite-voice-finalise voice)
;;   (foreign-call "ikrt_flite_voice_finalise" voice))

;;; --------------------------------------------------------------------

(define-inline (flite-voice-name voice)
  (foreign-call "ikrt_flite_voice_name" voice))

(define-inline (flite-available-voice-names)
  (foreign-call "ikrt_flite_available_voice_names"))

(define-inline (flite-voice-add-lex-addenda)
  (foreign-call "ikrt_flite_voice_add_lex_addenda"))


;;;; strings to speech

(define-inline (flite-text-to-speech text voice outtype)
  (foreign-call "ikrt_flite_text_to_speech" text voice outtype))

(define-inline (flite-file-to-speech file voice outtype)
  (foreign-call "ikrt_flite_file_to_speech" file voice outtype))


;;;; still not implemented

(define-inline (flite-text-to-wave)
  (foreign-call "ikrt_flite_text_to_wave"))

(define-inline (flite-synth-text)
  (foreign-call "ikrt_flite_synth_text"))

(define-inline (flite-synth-phones)
  (foreign-call "ikrt_flite_synth_phones"))


;;;; done

)

;;; end of file
