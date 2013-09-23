;;; -*- coding: utf-8-unix -*-
;;;
;;;Part of: Vicare/Flite
;;;Contents: tests for Flite bindings, Nausicaa language
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


#!r6rs
(import (nausicaa)
  (nausicaa speech-tools flite)
;;;  (prefix (vicare ffi) ffi.)
  (vicare arguments validation)
  (vicare checks))

(check-set-mode! 'report-failed)
(check-display "*** testing Nausicaa Flite bindings\n")

(flite-init)


;;;; helpers



(parametrise ((check-test-name		'voice-struct)
	      (struct-guardian-logger	#f))

  (define who 'test)

;;; --------------------------------------------------------------------

  (check	;this will be garbage collected
      (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
;;;(debug-print voice)
	((<flite-voice>) voice))
    => #t)

  (check
      (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
	(voice alive?))
    => #t)

  (check	;single finalisation
      (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
  	(voice finalise))
    => #f)

  (check	;double finalisation
      (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
  	(voice finalise)
  	(voice finalise))
    => #f)

  (check	;alive predicate after finalisation
      (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
  	(voice finalise)
  	(voice alive?))
    => #f)

;;; --------------------------------------------------------------------
;;; destructor

  (check
      (with-result
       (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
	 (set! (voice destructor) (lambda (voice)
				    (add-result 123)))
	 (voice finalise)))
    => '(#f (123)))

;;; --------------------------------------------------------------------
;;; hash

  (check-for-true
   (let (((V <flite-voice>) (<flite-voice> ("rms"))))
     (integer? (V hash))))

  (check
      (let ((A (<flite-voice> ()))
	    (B (<flite-voice> ()))
	    (T (make-hashtable (lambda ((V <flite-voice>))
				 (V hash))
			       eq?)))
	(hashtable-set! T A 1)
	(hashtable-set! T B 2)
	(list (hashtable-ref T A #f)
	      (hashtable-ref T B #f)))
    => '(1 2))

;;; --------------------------------------------------------------------
;;; properties

  (check
      (let (((S <flite-voice>) (<flite-voice> ("rms"))))
	(S property-list))
    => '())

  (check
      (let (((S <flite-voice>) (<flite-voice> ("rms"))))
	(S putprop 'ciao 'salut)
	(S getprop 'ciao))
    => 'salut)

  (check
      (let (((S <flite-voice>) (<flite-voice> ("rms"))))
	(S getprop 'ciao))
    => #f)

  (check
      (let (((S <flite-voice>) (<flite-voice> ("rms"))))
	(S putprop 'ciao 'salut)
	(S remprop 'ciao)
	(S getprop 'ciao))
    => #f)

  (check
      (let (((S <flite-voice>) (<flite-voice> ("rms"))))
	(S putprop 'ciao 'salut)
	(S putprop 'hello 'ohayo)
	(list (S getprop 'ciao)
	      (S getprop 'hello)))
    => '(salut ohayo))

;;; --------------------------------------------------------------------
;;; arguments validation

  (check-for-true
   (let (((S <flite-voice>) (<flite-voice> ("rms"))))
     (with-arguments-validation (who)
	 ((flite-voice	S))
       #t)))

  (check-for-true
   (let (((S <flite-voice>) (<flite-voice> ("rms"))))
     (S finalise)
     (with-arguments-validation (who)
	 ((flite-voice	S))
       #t)))

  (check-for-true
   (let (((S <flite-voice>) (<flite-voice> ("rms"))))
     (with-arguments-validation (who)
	 ((flite-voice/alive	S))
       #t)))

;;;

  (let (((S <flite-voice>) (<flite-voice> ("rms"))))
    (check-for-procedure-argument-violation
     (begin
       (S finalise)
       (with-arguments-validation (who)
	   ((flite-voice/alive	S))
	 #t))
     (list S)))

  (collect))


(parametrise ((check-test-name		'voice-ops))

;;; voice name

  (check
      (let (((voice <flite-voice>) (<flite-voice> ())))
  	(voice name))
    => "rms")

  (check
      (let (((voice <flite-voice>) (<flite-voice> ("slt"))))
  	(voice name))
    => "slt")

  (check
      (let (((voice <flite-voice>) (<flite-voice> ("kal"))))
  	(voice name))
    => "kal")

  (check
      (let (((voice <flite-voice>) (<flite-voice> ("kal16"))))
  	(voice name))
    => "kal16")

  (check
      (let (((voice <flite-voice>) (<flite-voice> ("awb"))))
  	(voice name))
    => "awb")

  (collect))


(parametrise ((check-test-name		'text-to-speech))

  (check-for-true
   (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
     (flonum? (voice play "rms voice"))))

  (check-for-true
   (let (((voice <flite-voice>) (<flite-voice> ("slt"))))
     (flonum? (voice play "slt voice"))))

  (check-for-true
   (let (((voice <flite-voice>) (<flite-voice> ("kal"))))
     (flonum? (voice play "kal voice"))))

  (check-for-true
   (let (((voice <flite-voice>) (<flite-voice> ("awb"))))
     (flonum? (voice play "awb voice"))))

;;; --------------------------------------------------------------------

;;   (check-for-true
;;    (let ((voice (flite-voice-select)))
;;      (flonum? (flite-text-to-speech "text to speech play" voice "play"))))

;;   (check
;;       (let ((voice (flite-voice-select)))
;; 	(when (file-exists? "proof-01.wav")
;; 	  (delete-file "proof-01.wav"))
;; 	(flite-text-to-speech "text to speech saved in file" voice "proof-01.wav")
;; 	(receive-and-return (bool)
;; 	    (file-exists? "proof-01.wav")
;; 	  (when bool
;; 	    (delete-file "proof-01.wav"))))
;;     => #t)

;;   (check
;;       (let ((voice (flite-voice-select)))
;; 	(when (file-exists? "proof-02.wav")
;; 	  (delete-file "proof-02.wav"))
;; 	(flite-text-to-speech "text to wav file test" voice "proof-02.wav")
;; 	(receive-and-return (bool)
;; 	    (file-exists? "proof-02.wav")
;; 	  (when bool
;; 	    (delete-file "proof-02.wav"))))
;;     => #t)

;; ;;; --------------------------------------------------------------------

;;   (check
;;       (let ((voice (flite-voice-select)))
;; 	(when (file-exists? "proof-03.txt")
;; 	  (delete-file "proof-03.txt"))
;; 	(with-output-to-file "proof-03.txt"
;; 	  (lambda ()
;; 	    (display "file to speech test")))
;; 	(receive-and-return (bool)
;; 	    (flonum? (flite-file-to-speech "proof-03.txt" voice "play"))
;; 	  (when (file-exists? "proof-03.txt")
;; 	    (delete-file "proof-03.txt"))))
;;     => #t)

  (collect))


;;;; done

(check-report)

;;; end of file
