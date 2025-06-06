; -*- SMT2 -*-
;
; This file comes from the optimathsat distribution with the permission of the authors.

(set-option :produce-models true)
(set-option :config preprocessor.toplevel_propagation=false)

;
; PROBLEM
;
(declare-fun x () Real)

(minimize x)
(assert (<= 2 x))
(push 1)
(assert (<= 5 x))
(check-sat)
(get-objectives)
(pop 1)

(push 1)
(maximize x)
(check-sat)
(get-objectives)
(pop 1)

(check-sat)
(get-objectives)

(exit)
