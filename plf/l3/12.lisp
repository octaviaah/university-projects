(defun substitute1 (l e new)
	(cond
		((and (numberp l) (equal l e)) new)
		((atom l) l)
		((listp l) (mapcar #' (lambda (x) (substitute1 x e new)) l))
	)
)