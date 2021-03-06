/*
  Part of: Vicare/Flite
  Contents: Flite for Vicare
  Date: Sat Sep 21, 2013

  Abstract

	Core functions.

  Copyright (C) 2013 Marco Maggi <marco.maggi-ipsu@poste.it>

  This program is  free software: you can redistribute  it and/or modify
  it under the  terms of the GNU General Public  License as published by
  the Free Software Foundation, either  version 3 of the License, or (at
  your option) any later version.

  This program  is distributed in the  hope that it will  be useful, but
  WITHOUT   ANY  WARRANTY;   without  even   the  implied   warranty  of
  MERCHANTABILITY  or FITNESS  FOR A  PARTICULAR PURPOSE.   See  the GNU
  General Public License for more details.

  You  should have received  a copy  of the  GNU General  Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


/** --------------------------------------------------------------------
 ** Headers.
 ** ----------------------------------------------------------------- */

#include "vicare-flite-internals.h"


/** --------------------------------------------------------------------
 ** Initialisation.
 ** ----------------------------------------------------------------- */

ikptr
ikrt_flite_init (ikpcb * pcb)
{
#ifdef HAVE_FLITE_INIT
  flite_init();
  /* This is needed to initialise the list of voices. */
  flite_voice_list = ik_imported_flite_set_voice_list();
  /* fprintf(stderr, "%s: voice list %p\n", __func__, (void*)flite_voice_list); */
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}


/** --------------------------------------------------------------------
 ** Voice.
 ** ----------------------------------------------------------------- */

ikptr
ikrt_flite_voice_select (ikptr s_voice_name, ikpcb * pcb)
{
#ifdef HAVE_FLITE_VOICE_SELECT
  const char *	voice_name = IK_GENERALISED_C_STRING(s_voice_name);
  cst_voice *	rv;
  /* fprintf(stderr, "%s: voice %s\n", __func__, voice_name); */
  rv = flite_voice_select(voice_name);
  if (NULL != rv) {
    return ika_pointer_alloc(pcb, (ik_ulong)rv);
  } else
    return IK_FALSE;
#else
  feature_failure(__func__);
#endif
}

#if 0
/* Commented  out  because  there  is no  finalisation  for  FLITE-VOICE
   structures; but kept here just in  case, in future, there is the need
   to introduce it. */
ikptr
ikrt_flite_voice_finalise (ikptr s_voice, ikpcb * pcb)
/* NOTE Flite  is really underdocumented,  so this is just  guessing and
   trying  to cope  with it.

   As of Flite version 1.4:  the structure "cst_voice" representing each
   voice is built and initialised once by Flite; every time we request a
   specific voice struct: the same "cst_voice" is returned. */
{
  ikptr		s_pointer	= IK_FLITE_VOICE_POINTER(s_voice);
  if (ik_is_pointer(s_pointer)) {
    cst_voice *	voice		= IK_POINTER_DATA_VOIDP(s_pointer);
    int		owner		= IK_BOOLEAN_TO_INT(IK_FLITE_VOICE_OWNER(s_voice));
    if (voice && owner) {
      IK_POINTER_SET_NULL(s_pointer);
    }
  }
  /* Return false so that the return value of "$flite-voice-finalise" is
     always false. */
  return IK_FALSE;
}
#endif

/* ------------------------------------------------------------------ */

ikptr
ikrt_flite_voice_name (ikptr s_voice, ikpcb * pcb)
{
  ikptr		s_pointer	= IK_FLITE_VOICE_POINTER(s_voice);
  if (ik_is_pointer(s_pointer)) {
    cst_voice *	voice		= IK_POINTER_DATA_VOIDP(s_pointer);
    if ((NULL != voice) && (NULL != voice->name)) {
      return ika_string_from_cstring(pcb, voice->name);
    }
  }
  return ika_string_from_cstring(pcb, "unknown-flite-voice");
}
ikptr
ikrt_flite_available_voice_names (ikpcb * pcb)
{
  ikptr			s_list;
  ikptr			s_spine;
  cst_voice *		voice;
  const cst_val *	v;
  s_list = s_spine = ika_pair_alloc(pcb);
  pcb->root0 = &s_list;
  pcb->root1 = &s_spine;
  {
    /* fprintf(stderr, "%s: voice list %p\n", __func__, (void*)flite_voice_list); */
    for (v=flite_voice_list; v; ) {
      voice = val_voice(val_car(v));
      /* fprintf(stderr, "%s: name %s\n", __func__, voice->name); */
      IK_ASS(IK_CAR(s_spine), ika_string_from_cstring(pcb, voice->name));
      v = val_cdr(v);
      if (v) {
	IK_ASS(IK_CDR(s_spine), ika_pair_alloc(pcb));
	s_spine = IK_CDR(s_spine);
      } else {
	IK_CDR(s_spine) = IK_NULL_OBJECT;
	break;
      }
    }
  }
  pcb->root0 = NULL;
  pcb->root1 = NULL;
  return s_list;
}


/** --------------------------------------------------------------------
 ** Utterance.
 ** ----------------------------------------------------------------- */

ikptr
ikrt_flite_synth_text (ikptr s_text, ikptr s_voice, ikpcb * pcb)
{
#ifdef HAVE_FLITE_SYNTH_TEXT
  const char *		text	= IK_GENERALISED_C_STRING(s_text);
  cst_voice *		voice	= IK_FLITE_VOICE(s_voice);
  cst_utterance *	rv;
  rv = flite_synth_text(text, voice);
  if (NULL != rv) {
    return ika_pointer_alloc(pcb, (ik_ulong)rv);
  } else
    return IK_FALSE;
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}
ikptr
ikrt_flite_utterance_finalise (ikptr s_utterance, ikpcb * pcb)
{
#ifdef HAVE_DELETE_UTTERANCE
  ikptr		s_pointer		= IK_FLITE_UTTERANCE_POINTER(s_utterance);
  if (ik_is_pointer(s_pointer)) {
    cst_utterance *	utterance	= IK_POINTER_DATA_VOIDP(s_pointer);
    int			owner		= IK_BOOLEAN_TO_INT(IK_FLITE_UTTERANCE_OWNER(s_utterance));
    if (utterance && owner) {
      delete_utterance(utterance);
      IK_POINTER_SET_NULL(s_pointer);
    }
  }
  /* Return     false     so     that    the     return     value     of
     "$flite-utterance-finalise" is always false. */
  return IK_FALSE;
#else
  feature_failure(__func__);
#endif
}
ikptr
ikrt_flite_process_output (ikptr s_utterance, ikptr s_outtype, ikpcb * pcb)
{
#ifdef HAVE_FLITE_PROCESS_OUTPUT
  cst_utterance *	utterance	= IK_FLITE_UTTERANCE(s_utterance);
  const char *		outtype		= IK_GENERALISED_C_STRING(s_outtype);
  float			rv;
  rv = flite_process_output(utterance, outtype, FALSE);
  return ika_flonum_from_double(pcb, (double)rv);
#else
  feature_failure(__func__);
#endif
}


/** --------------------------------------------------------------------
 ** Text to speech.
 ** ----------------------------------------------------------------- */

ikptr
ikrt_flite_file_to_speech (ikptr s_file, ikptr s_voice, ikptr s_outtype, ikpcb * pcb)
{
#ifdef HAVE_FLITE_FILE_TO_SPEECH
  const char *	file	= IK_GENERALISED_C_STRING(s_file);
  cst_voice *	voice	= IK_FLITE_VOICE(s_voice);
  const char *	outtype	= IK_GENERALISED_C_STRING(s_outtype);
  float		rv;
  /* fprintf(stderr, "%s: file=%s, voice=%p, outtype=%s\n", __func__, file, (void*)voice, outtype); */
  rv = flite_file_to_speech(file, voice, outtype);
  return ika_flonum_from_double(pcb, (double)rv);
#else
  feature_failure(__func__);
#endif
}
ikptr
ikrt_flite_text_to_speech (ikptr s_text, ikptr s_voice, ikptr s_outtype, ikpcb * pcb)
{
#ifdef HAVE_FLITE_TEXT_TO_SPEECH
  const char *	text	= IK_GENERALISED_C_STRING(s_text);
  cst_voice *	voice	= IK_FLITE_VOICE(s_voice);
  const char *	outtype	= IK_GENERALISED_C_STRING(s_outtype);
  float		rv;
  /* fprintf(stderr, "%s: text=%s, voice=%p, outtype=%s\n", __func__, text, (void*)voice, outtype); */
  rv = flite_text_to_speech(text, voice, outtype);
  return ika_flonum_from_double(pcb, (double)rv);
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}


/** --------------------------------------------------------------------
 ** Still to be implemented.
 ** ----------------------------------------------------------------- */

ikptr
ikrt_flite_text_to_wave (ikpcb * pcb)
{
#ifdef HAVE_FLITE_TEXT_TO_WAVE

  /* rv = flite_text_to_wave(); */
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}
ikptr
ikrt_flite_synth_phones (ikpcb * pcb)
{
#ifdef HAVE_FLITE_SYNTH_PHONES
  /* rv = flite_synth_phones(); */
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}
ikptr
ikrt_flite_voice_add_lex_addenda (ikpcb * pcb)
{
#ifdef HAVE_FLITE_VOICE_ADD_LEX_ADDENDA
  /* rv = flite_voice_add_lex_addenda(); */
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}

#if 0
ikptr
ikrt_flite_doit (ikpcb * pcb)
{
#ifdef HAVE_FLITE_DOIT
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}
#endif

/* end of file */
