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
;;;Copyright (C) 2013, 2015 Marco Maggi <marco.maggi-ipsu@poste.it>
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

    ;; text to speech
    flite-file-to-speech
    flite-text-to-speech

    ;; utterance handline
    flite-synth-text
    flite-utterance-finalise
    flite-process-output

    ;; version functions
    vicare-flite-version-interface-current
    vicare-flite-version-interface-revision
    vicare-flite-version-interface-age
    vicare-flite-version

;;; --------------------------------------------------------------------
;;; still to be implemented

    flite-text-to-wave
    flite-synth-phones
    )
  (import (vicare))


;;;; version functions

(define-syntax-rule (vicare-flite-version-interface-current)
  (foreign-call "ikrt_flite_version_interface_current"))

(define-syntax-rule (vicare-flite-version-interface-revision)
  (foreign-call "ikrt_flite_version_interface_revision"))

(define-syntax-rule (vicare-flite-version-interface-age)
  (foreign-call "ikrt_flite_version_interface_age"))

(define-syntax-rule (vicare-flite-version)
  (foreign-call "ikrt_flite_version"))


;;;; library initialisation

(define-syntax-rule (flite-init)
  (foreign-call "ikrt_flite_init"))


;;;; voice handling

(define-syntax-rule (flite-voice-select voice)
  (foreign-call "ikrt_flite_voice_select" voice))

;;Commented  out  because  there  is  no  finalisation  for  FLITE-VOICE
;;structures; but kept  here just in case, in future,  there is the need
;;to introduce it.
;;
;; (define-syntax-rule (flite-voice-finalise voice)
;;   (foreign-call "ikrt_flite_voice_finalise" voice))

;;; --------------------------------------------------------------------

(define-syntax-rule (flite-voice-name voice)
  (foreign-call "ikrt_flite_voice_name" voice))

(define-syntax-rule (flite-available-voice-names)
  (foreign-call "ikrt_flite_available_voice_names"))

(define-syntax-rule (flite-voice-add-lex-addenda)
  (foreign-call "ikrt_flite_voice_add_lex_addenda"))


;;;; utterance

(define-syntax-rule (flite-synth-text text voice)
  (foreign-call "ikrt_flite_synth_text" text voice))

(define-syntax-rule (flite-utterance-finalise utterance)
  (foreign-call "ikrt_flite_utterance_finalise" utterance))

(define-syntax-rule (flite-process-output utterance outtype)
  (foreign-call "ikrt_flite_process_output" utterance outtype))


;;;; strings to speech

(define-syntax-rule (flite-text-to-speech text voice outtype)
  (foreign-call "ikrt_flite_text_to_speech" text voice outtype))

(define-syntax-rule (flite-file-to-speech file voice outtype)
  (foreign-call "ikrt_flite_file_to_speech" file voice outtype))


;;;; still not implemented

(define-syntax-rule (flite-text-to-wave)
  (foreign-call "ikrt_flite_text_to_wave"))

(define-syntax-rule (flite-synth-phones)
  (foreign-call "ikrt_flite_synth_phones"))


;;;; done

)

;;; end of file
