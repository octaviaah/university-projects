(defun removeAppearances (l e)
	(cond
		((null l) nil)
		((= (car l) e) (removeAppearances (cdr l) e))
		(T (cons (car l) (removeAppearances (cdr l) e)))
	)
)

(defun transform (l)
	(cond
		((null l) nil)
		(T (cons (car l) (transform (removeAppearances (cdr l) (car l)))))
	)
)