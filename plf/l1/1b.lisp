(defun checkAtom (l elem)
	(cond
		((null l) nil)
		((and (atom (car l)) (equal (car l) elem)) T)
		((atom (car l)) (checkAtom (cdr l) elem))
		((list (car l)) (or (checkAtom (car l) elem) (checkAtom (cdr l) elem)))
	)
)